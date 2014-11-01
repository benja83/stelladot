require_relative "../helpers/Validator.rb"

class ConfigSetting < ActiveRecord::Base

  after_initialize :create_validators

  @@data_type_available = %w(string integer float boolean)
  @@validators = {}

  def create_validators
    @@data_type_available.each do |element|
      @@validators[element] = Validator.new(element) unless @@validators[element]
    end
  end

  validates :name, presence: true, uniqueness: true
  validates :data_type, presence: true, inclusion: { in: @@data_type_available, message: "%{value} is not a valid data_type" }
  validate :type_value_match_data_type

  def type_value_match_data_type
    if errors.blank? && !@@validators[self.data_type].check(self.value)
      errors.add(:value, "don't have the same #{self.data_type} of the setting")
    end
  end

end
