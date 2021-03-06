class Validator

  @@data_type_rules = {/\A[0-9]*\z/ => "integer",
                      /\A[0-9]*\.[0-9]*\z/ => "float",
                      "true" => "boolean",
                      "false" => "boolean"}

  def initialize(data_type)
    @data_type = data_type
  end

  def check(value)
    get_type(value) == @data_type || (get_type(value) == "integer" && @data_type == "float")
  end

  def get_type(value)
    @@data_type_rules.each { |key,data_type| return data_type if value.match(key) }
    "string"
  end
end