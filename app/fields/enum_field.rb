require "administrate/field/base"

class EnumField < Administrate::Field::Number
  def to_s
    data.humanize
  end
end
