require 'rails_helper'

RSpec.describe Shop, type: :model do
  describe 'model associations' do
    it { should have_many(:orders) }
    it { should have_many(:products) }
  end

  describe 'model validations' do
    it { should validate_presence_of(:name) }
  end
end
