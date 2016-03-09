class Resort < ActiveRecord::Base
  belongs_to :user

  # after_save :set_zip
  #
  # def set_zip
  #   zip = GeocodingService.new.zip(self[:latitude].to_f, self[:longitude].to_f)
  #   self.update_attributes(zip_code: zip)
  # end


end
