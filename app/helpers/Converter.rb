class Converter
  
  @@convertion_rules = {"integer" => :to_i,
                        "float" => :to_f,
                        "string" => :to_s
                        }

  def initialize(data_type)
    @data_type = data_type
  end

  def convert_value(value)
    call = @@convertion_rules[@data_type]
    return value.send(call) unless @data_type == "boolean"
    eval(value)
  end

  def check_true_or_false(value)
    value = "true" ? true : false
  end
end