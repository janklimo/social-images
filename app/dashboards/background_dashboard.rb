require "administrate/base_dashboard"

class BackgroundDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    image: PaperclipField,
  }

  COLLECTION_ATTRIBUTES = [
    :id,
    :image,
  ]

  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :image,
  ]

  FORM_ATTRIBUTES = [
    :image,
  ]

  def display_resource(background)
    "Background ##{background.id}"
  end
end
