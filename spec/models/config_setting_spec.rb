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
      setting = ConfigSetting.new name: "discount",data_type: "boolean", value: "false"
      expect(setting.valid?).to equal(true)
    end

    it "don't allow to record a integer" do
      setting = ConfigSetting.new name: "discount",data_type: "boolean", value: "1223"
      expect(setting.valid?).to equal(false)
    end

    it "don't allow to record a string" do
      setting = ConfigSetting.new name: "discount",data_type: "boolean", value: "dbvbe1223"
      expect(setting.valid?).to equal(false)
    end

    it "don't allow to record a float" do
      setting = ConfigSetting.new name: "discount",data_type: "boolean", value: "12.23"
      expect(setting.valid?).to equal(false)
    end
  end

  context "validation of the value during update" do
    it "don't allows to change the value with a invalid data using the set method and save" do
      setting = ConfigSetting.create name: "discount",data_type: "boolean", value: "false"
      setting.value = "233"
      setting.save
      setting = ConfigSetting.last
      expect(setting.value).to eq("false")
    end

    it "don't allows to change the value with a invalid data using the update method" do
      setting = ConfigSetting.create name: "discount",data_type: "boolean", value: "false"
      setting.update value: "233"
      setting = ConfigSetting.last
      expect(setting.value).to eq("false")
    end
  end

  context 'get_value method returns value with the good data_type' do
    it "returns an integer for integer field" do
      setting = ConfigSetting.create name: "age",data_type: "integer", value: "1223"
      expect(setting.get_value).to be_a(Integer)
    end
    it "returns an boolean for a boolean field" do
      setting = ConfigSetting.create name: "discount",data_type: "boolean", value: "true"
      expect(setting.get_value).to be_an_instance_of(TrueClass)
    end
    it "returns a float for a float field" do
      setting = ConfigSetting.create name: "price",data_type: "float", value: "12.23"
      expect(setting.get_value).to be_a(Float)
    end
    it "returns a string for a string field" do
      setting = ConfigSetting.create name: "name",data_type: "string", value: "Ben"
      expect(setting.get_value).to be_a(String)
    end
  end
end
