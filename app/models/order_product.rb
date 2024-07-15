# frozen_string_literal: true

#
# Represents a line item on the order
# Contains the quantity of the given product added to the order
#
class OrderProduct < ApplicationRecord
  # belongs to
  belongs_to :order
  belongs_to :product

  # validations
  validates :quantity, presence: true

  # set the price from the Product model
  before_create :set_price

  #
  # Calculates the subtotal for the given order product
  #
  # @return [Integer] the subtotal
  #
  def subtotal
    quantity * price
  end

  # class methods
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value order_id product_id quantity updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[order product]
  end

  private

  def set_price
    self.price = product.price
  end
end
