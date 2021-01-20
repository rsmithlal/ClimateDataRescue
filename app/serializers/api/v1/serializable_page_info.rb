
module Api
  module V1
    # Serializes the PageInfo class
    class SerializablePageInfo < ApplicationSerializer
      type 'page_infos'

      attributes :observer, :lat, :lon, :location, :elevation, :month, :year
    end
  end
end