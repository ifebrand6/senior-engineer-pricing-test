# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderProduct do
  it 'has a valid factory' do
    expect(build(:order_product)).to be_valid
  end

  describe 'associations' do
    it 'belongs to order' do
      expect(described_class.new).to belong_to(:order)
    end

    it 'belongs to product' do
      expect(described_class.new).to belong_to(:product)
    end
  end

  describe 'validations' do
    it 'validates presence of quantity' do
      expect(described_class.new).to validate_presence_of(:quantity)
    end
  end

  describe 'subtotal' do
    let(:order_product) { build(:order_product, quantity: 2, price: 100) }

    it 'returns the subtotal' do
      expect(order_product.subtotal).to eq(200)
    end
  end

  describe 'ransackable_attributes' do
    it 'returns an array with the attributes' do
      expect(described_class.ransackable_attributes).to eq(%w[created_at id id_value order_id product_id quantity
                                                              updated_at])
    end
  end

  describe 'ransackable_associations' do
    it 'returns an empty array' do
      expect(described_class.ransackable_associations).to eq(%w[order product])
    end
  end
end
