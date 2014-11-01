class Validator
  def initialize(data_type)
    @data_type = data_type
  end

  def check(value)
    get_type(value) == @data_type || (get_type(value) == "integer" && @data_type == "float")
  end

  def get_type(value)
    return "integer" if /\A[0-9]*\z/ === value
    return "float" if /\A[0-9]*\.[0-9]*\z/ === value
    return "boolean" if "true" == value || "false" == value
    "string"
  end
end