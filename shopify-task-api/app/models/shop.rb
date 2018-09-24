# Table name: shops
#
#  id                     :integer(4)      not null, primary key
#  name                   :string(255)     not null, default("")
#  created_at             :datetime
#  updated_at             :datetime
#

class Shop < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :products, dependent: :destroy

  validates_presence_of :name
end
