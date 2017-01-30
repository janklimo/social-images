require "administrate/base_dashboard"

class OrderDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    status: EnumField,
  }

  COLLECTION_ATTRIBUTES = [
    :id,
    :status,
  ]

  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :status,
  ]

  FORM_ATTRIBUTES = [
    :status,
  ]

  def display_resource(order)
    "Order ##{order.id}"
  end
end
