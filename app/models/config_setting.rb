require_relative "../helpers/Validator.rb"

class ConfigSetting < ActiveRecord::Base

  attr_accessor :value,:data_type

  def set_data_type_available
    @data_type_available = %w(string integer float boolean)
    @validators = {}
  end

  before_validation :set_data_type_available, :create_validators

  validates :name, presence: true, uniqueness: true
  validates :data_type, presence: true, inclusion: { in: %w(string integer float boolean), message: "%{value} is not a valid data_type" }
  validate :type_value_match_data_type

  def type_value_match_data_type
    if self.data_type != "float"
      if self.get_type_value != self.data_type
        errors.add(:value, "don't have the same #{self.data_type} of the setting")
      end
    elsif self.get_type_value != "float" && self.get_type_value != "integer"
      errors.add(:value, "don't have the same #{self.data_type} of the setting")
    end
  end

  def get_type_value
    return "integer" if /\A[0-9]*\z/ === self.value && self.value
    return "float" if /\A[0-9]*\.[0-9]*\z/ === self.value && self.value
    return "boolean" if ("true" == self.value || "false" == self.value) && self.value
    "string"
  end

  def create_validators
    @data_type_available.each do |element|
      @validators[element] = Validator.new(element)
    end
  end

end
