require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    through_options = assoc_options[through_name]
#   => Cat belongs to Human
    define_method(name) do
      through_obj = self.send(through_name)
      # => Returns Human obj
      source_options = through_options.model_class.assoc_options[source_name]
      # => Returns the Human belongs to House association
      source_foreign_key_name = source_options.foreign_key
      # => Gets foreign key name so that we can find ID ('house_id')
      source_id = through_obj.send(source_foreign_key_name)
      # => Gets the house_id #
      source_options.model_class.find(source_id)
      # => Finds the House obj
    end
  end
end
