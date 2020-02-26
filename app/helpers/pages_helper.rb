
module PagesHelper
  def transcribable_pages(user)
    Page.select(Arel.star, PageType.arel_table[:number]).inactive.transcribeable.unseen(user)
  end

  def transcribable_pages_select2(user)
    transcribable_pages(user).map do |page|
      {
        id: page.id,
        text: page.display_name
      }
    end
  end
end
