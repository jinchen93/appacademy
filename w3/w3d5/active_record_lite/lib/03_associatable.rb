require_relative '02_searchable'
require 'active_support/inflector'
require 'byebug'

# ActiveSupport::Inflector

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  # Foreign key is the other id but is held in self table
  def initialize(name, options = {})
    @primary_key = options[:primary_key] || :id
    @foreign_key = options[:foreign_key] ||
      "#{ActiveSupport::Inflector.underscore(name)}_id".to_sym
    @class_name = options[:class_name] ||
      ActiveSupport::Inflector.singularize(name).camelcase
  end
end

class HasManyOptions < AssocOptions
  # Foreign key is self id but is held in other table
  def initialize(name, self_class_name, options = {})
    @primary_key = options[:primary_key] || :id
    @foreign_key = options[:foreign_key] ||
      "#{ActiveSupport::Inflector.underscore(self_class_name)}_id".to_sym
    @class_name = options[:class_name] ||
      ActiveSupport::Inflector.singularize(name).camelcase

  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)
    foreign_key_name = options.foreign_key

    define_method(name) do
      foreign_id = self.send(foreign_key_name)
      return nil if foreign_id.nil?
      options.model_class.find(foreign_id)
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self.name, options)
    foreign_key_name = options.foreign_key

    define_method(name) do
      options.model_class.where(foreign_key_name => self.id)
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  extend Associatable
end
