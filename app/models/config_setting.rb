class ConfigSetting < ActiveRecord::Base

  attr_accessor :data_type,:data_type

  validates :name, presence: true, uniqueness: true
  validates :data_type, presence: true, inclusion: { in: %w(string integer float boolean), message: "%{value} is not a valid data_type" }
  validate :type_value_match_data_type

  def type_value_match_data_type
    if self.get_type_value != self.data_type
      errors.add(:value, "don't have the same #{self.data_type} of the setting")
    end
  end

  def get_type_value
    return "integer" if /\A[0-9]*\z/ === self.value && self.value
    return "float" if /\A[0-9]*\.[0-9]*\z/ === self.value && self.value
    "string"
  end

end
