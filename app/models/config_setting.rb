require_relative "../helpers/Validator.rb"
require_relative "../helpers/Conversor.rb"

class ConfigSetting < ActiveRecord::Base

  cattr_accessor :cache_storage

  @@data_type_available = %w(string integer float boolean)
  @@expiration_time_for_cache = 5

  validates :name, presence: true, uniqueness: true
  validates :data_type, presence: true, inclusion: { in: @@data_type_available, message: "%{value} is not a valid data_type" }
  validate :type_value_match_data_type

  after_initialize :create_validators_conversors_cache

  @@validators = {}
  @@conversors = {}

  def create_validators_conversors_cache
    @@data_type_available.each do |element|
      @@validators[element] = Validator.new(element) unless @@validators[element]
      @@conversors[element] = Conversor.new(element) unless @@conversors[element]
    end
    @@cache_storage = ActiveSupport::Cache::MemoryStore.new(expires_in: @@expiration_time_for_cache.minute)
  end

  def type_value_match_data_type
    if errors.blank? && self.value && !@@validators[self.data_type].check(self.value)
      errors.add(:value, "don't have the same #{self.data_type} of the setting")
    end
  end

  def get_value
    @@conversors[self.data_type].convert_value(self.value)
  end

  def get_value_cached
    @@cache_storage.exist?(self.name) ? @@cache_storage.read(self.name) : @@cache_storage.fetch(self.name) { get_value }
  end

end
