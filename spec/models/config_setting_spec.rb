require 'rails_helper'

RSpec.describe ConfigSetting, :type => :model do
  context "model" do
    it "don't create a setting without both field" do
      setting = ConfigSetting.new
      expect(setting.valid?).to equal(false)
    end
    it "don't create a setting without type" do
      setting_without_type = ConfigSetting.new name: "email"
      expect(setting_without_type.valid?).to equal(false)
    end
    it "don't create a setting without name" do
      setting_without_name = ConfigSetting.new data_type: "string"
      expect(setting_without_name.valid?).to equal(false)
    end
  end
end
