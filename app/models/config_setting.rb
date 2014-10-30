class ConfigSetting < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true
  validates :data_type, presence: true, inclusion: { in: %w(string integer float boolean)}
end
