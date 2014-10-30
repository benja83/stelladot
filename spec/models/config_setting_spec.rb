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

    it "don't create a setting with the same name" do
      ConfigSetting.create! name: "email",data_type: "string"
      setting_not_unique = ConfigSetting.new name: "email",data_type: "string"
      expect(setting_not_unique.valid?).to eql(false)
    end

    it "don't create a setting with a data_type not include in (string integer float boolean)" do
      setting_with_data_type_not_include = ConfigSetting.new name: "email",data_type: "magic"
      expect(setting_with_data_type_not_include.valid?).to equal(false)
    end
  end
end
