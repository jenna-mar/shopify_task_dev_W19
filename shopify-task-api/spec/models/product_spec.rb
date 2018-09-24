require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should have_many(:line_items) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:price) }
end
