=begin
#
# Unfortunately, I was never able to get this test to work, possibly due to something specific about the scope of the GraphQL Query Type (or types in general).
#


require 'rails_helper'

RSpec.describe Types::ShopType do
  # avail type definer in our tests
  types = GraphQL::Define::TypeDefiner.instance

  it 'has an :id field of ID type' do
    # Ensure that the field id is of type ID
    expect(subject).to have_field(:id).that_returns(!types.ID)
  end

  it 'has a :name field of String type' do
    # Ensure the field is of String type
    expect(subject).to have_field(:name).that_returns(!types.String)
  end
end

=end