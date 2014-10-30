require 'rails_helper'

RSpec.describe ConfigSetting, :type => :model do
  context "validation model test" do
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

  context "validation of the value for a setting with a string data_type" do
    it "allows to record a string" do
      setting = ConfigSetting.new name: "email",data_type: "string", value: "dbvbe1223"
      expect(setting.valid?).to equal(true)
    end

    it "don't allow to record a integer" do
      setting = ConfigSetting.new name: "email",data_type: "string", value: "1223"
      expect(setting.valid?).to equal(false)
    end

    it "don't allow to record a float" do
      setting = ConfigSetting.new name: "email",data_type: "string", value: "12.23"
      expect(setting.valid?).to equal(false)
    end

    it "don't allow to record a boolean" do
      setting = ConfigSetting.new name: "email",data_type: "string", value: "false"
      expect(setting.valid?).to equal(false)
    end
  end

  context "validation of the value for a setting with a integer data_type" do
    it "allows to record a integer" do
      setting = ConfigSetting.new name: "age",data_type: "integer", value: "1223"
      expect(setting.valid?).to equal(true)
    end

    it "don't allow to record a string" do
      setting = ConfigSetting.new name: "age",data_type: "integer", value: "dbvbe1223"
      expect(setting.valid?).to equal(false)
    end

    it "don't allow to record a float" do
      setting = ConfigSetting.new name: "age",data_type: "integer", value: "12.23"
      expect(setting.valid?).to equal(false)
    end

    it "don't allow to record a boolean" do
      setting = ConfigSetting.new name: "age",data_type: "integer", value: "false"
      expect(setting.valid?).to equal(false)
    end
  end

  context "validation of the value for a setting with a float data_type" do
    it "allows to record a float" do
      setting = ConfigSetting.new name: "price",data_type: "float", value: "12.23"
      expect(setting.valid?).to equal(true)
    end

    it "allows to record a integer" do
      setting = ConfigSetting.new name: "price",data_type: "float", value: "1223"
      expect(setting.valid?).to equal(true)
    end

    it "don't allow to record a string" do
      setting = ConfigSetting.new name: "price",data_type: "float", value: "dbvbe1223"
      expect(setting.valid?).to equal(false)
    end

    it "don't allow to record a boolean" do
      setting = ConfigSetting.new name: "price",data_type: "float", value: "false"
      expect(setting.valid?).to equal(false)
    end
  end

  context "validation of the value for a setting with a boolean data_type" do
    it "allows to record a boolean" do
      setting = ConfigSetting.new name: "price",data_type: "boolean", value: "false"
      expect(setting.valid?).to equal(true)
    end

    it "don't allow to record a integer" do
      setting = ConfigSetting.new name: "price",data_type: "boolean", value: "1223"
      expect(setting.valid?).to equal(false)
    end

    it "don't allow to record a string" do
      setting = ConfigSetting.new name: "price",data_type: "boolean", value: "dbvbe1223"
      expect(setting.valid?).to equal(false)
    end

    it "don't allow to record a float" do
      setting = ConfigSetting.new name: "price",data_type: "boolean", value: "12.23"
      expect(setting.valid?).to equal(false)
    end
  end


end
