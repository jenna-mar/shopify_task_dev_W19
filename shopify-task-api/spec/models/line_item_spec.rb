require 'rails_helper'

RSpec.describe LineItem, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:quantity) }
  it { should validate_presence_of(:price) }
end
