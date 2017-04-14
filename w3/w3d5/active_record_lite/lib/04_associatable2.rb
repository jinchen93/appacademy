require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    through_options = assoc_options[through_name]
#   => Cat belongs to Human
    define_method(name) do
      through_obj = self.send(through_name)
      source_options = through_options.model_class.assoc_options[source_name]
      source_foreign_key_name = source_options.foreign_key
      source_id = through_obj.send(source_foreign_key_name)
      source_options.model_class.find(source_id)
    end
  end
end
