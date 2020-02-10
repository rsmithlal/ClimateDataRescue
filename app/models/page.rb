class Page < ApplicationRecord
  Paperclip.interpolates :image_file_name do |attachment, style|
    attachment.instance.image_file_name
  end

  belongs_to :page_type

  has_many :field_groups, through: :page_type
  has_many :fields, through: :field_groups
  has_many :transcriptions, dependent: :destroy  
  has_many :page_days, dependent: :destroy
  has_many :data_entries, dependent: :destroy
  has_one :page_info, dependent: :destroy
  

  #handles the image upload association
  has_attached_file :image,
                  styles: { 
                    thumb: ["64x64#", :jpg],
                    small: ["200x200>", :jpg],
                    medium: ["400x400>", :jpg],
                    large: ["600x600>", :jpg],
                    xlarge: ["1000x1000>", :jpg]
                  },
                  default_style: :medium,
                  url: "/uploads/:class/:style/:image_file_name"
  validates_attachment :image,
                     content_type: { content_type: ["image/jpg","image/jpeg", "image/png"] }

  before_validation :parse_filename
  before_save :extract_upload_dimensions
  before_destroy :check_for_delete
  
  #sets a scope for all transcribable pages to be those that are not done
  scope :transcribeable, -> { 
    joins(page_type: {
      field_groups: :fields
    }).
    where(
      done: false, visible: true, 
      page_types: { visible: true }
    ).order("pages.start_date asc").distinct
  }

  scope :unseen, -> (user) {
    if user && user.pages.any?
      where("pages.id not in (?)", user.pages.pluck(:id))
    end
  }

  def page_days?
    page_days.any?
  end

  def page_metadata?
    page_info.present?
  end

  def num_rows_expected
    if page_days.any?
      page_days.sum(:num_observations)
    else
      nil
    end
  end
  
  def to_jq_upload
    {
      "name" => read_attribute(:image_file_name),
      "size" => image.size,
      "url" => image.url,
      "thumbnailUrl" => image.url(:thumb),
      "deleteUrl" => "/pages/#{self.id}",
      "deleteType" => "DELETE",
      "pageId" => "page-#{self.id}"
    }
  end
  
  #sets the height and width attributes of the page to those of its attachment dimensions on update
  def extract_dimensions
    return unless self.image?
    #regex to select all parts of the filename preceding the end of the supported file types and forms
    reg = /(.+\.(jpg|JPG|jpeg|JPEG|png|PNG))/
    tempfile = self.image.url
    # puts tempfile
    cleaned = reg.match(tempfile).to_s
    # puts cleaned
    full_path = Rails.root.to_s + "/public" + cleaned
    # puts full_path
    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(full_path)
      self.width = geometry.width.to_i
      self.height = geometry.height.to_i
      self.save
    end
  end

  private 

  def check_for_delete
    if data_entries.any? 
      errors.add(:base, I18n.t('cant-delete-page-that-has-been-transcribed'))
      throw(:abort)
    end
  end
  
  def parse_filename
    return if image.blank? || persisted?
    filename = image_file_name
    components = filename.split("_")
    component_count = components.size

    ledger_type = components[1]
    volume = components[2]
    start_date = components[3]

    ledger = Ledger.find_or_create_by(ledger_type: ledger_type) do |l|
      l.title = ledger_type
    end

    self.accession_number = components[0]

    self.volume = volume
    self.start_date = Date.parse(start_date)

    if component_count == 6 # Normal DRAW app
      end_date = components[4]
      
      if components[5] && components[5].length > 0
        # take the first character of the 6th position?
        page_type_num = components[5][0]
        self.page_type = PageType.find_or_create_by(number: page_type_num, ledger_id: ledger.id) do |page_type|
          page_type.ledger_type = ledger_type
          page_type.title = "Register #{ledger_type}, page #{page_type_num}"
        end
      end
      self.end_date = Date.parse(end_date)
      
      self.title = "#{start_date} to #{end_date}"

    elsif component_count == 5 #ECCC data
      
      page_types = components[4].split(".")
      page_type_num = page_types[0]

      self.page_type = PageType.find_or_create_by(number: page_type_num, ledger_id: ledger.id) do |page_type|
        page_type.ledger_type = ledger_type
        page_type.title = "Register #{ledger_type}, page #{page_type_num}"
      end
      self.end_date = self.start_date.next_month.prev_day
      self.title = "#{accession_number} - #{start_date} to #{self.end_date}"
    else
      raise "invalid filename"
    end
  end
  
  #sets the height and width attributes of the page to those of its attachment dimensions on create
  def extract_upload_dimensions
    return unless image?

    tempfile = image.queued_for_write[:original]

    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(tempfile)
      self.width = geometry.width.to_i
      self.height = geometry.height.to_i
    end
  end

end
