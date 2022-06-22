require 'rails_helper'

describe Product do
  it "should have 0 Product" do
    expect(Product.count).to eq(0)
  end
end