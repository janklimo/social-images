require "administrate/base_dashboard"

class OrderDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    status: EnumField,
    token: Field::String
  }

  COLLECTION_ATTRIBUTES = [
    :id,
    :status,
    :token
  ]

  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :status,
    :token
  ]

  FORM_ATTRIBUTES = [
    :status,
  ]

  def display_resource(order)
    "Order ##{order.id}"
  end
end
