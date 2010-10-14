class Asset < ActiveRecord::Base
  has_attachment    :storage => :file_system,
                    :max_size => 1.gigabytes,
                    :path_prefix => "public/assets/",
                    :partition => false
                    
  validates_as_attachment
                      
  belongs_to  :post
  belongs_to  :user
end
