require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  
  def self.columns
    unless @columns
      table = self.table_name
      query_results = DBConnection.execute2(<<-SQL)
        SELECT
          *
        FROM
          #{table}
      SQL
      @columns = query_results.first.map { |ele| ele.to_sym }
    end
    @columns
  end

  def self.finalize!
    columns.each do |attribute|

      define_method(attribute) do
        attributes[attribute]
      end

      define_method("#{attribute}=") do |value|
        attributes[attribute] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= ActiveSupport::Inflector.tableize(self.name)
  end

  def self.all
    db_objects = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL

    parse_all(db_objects)
  end

  def self.parse_all(results)
    all = []
    results.each do |obj|
      all << self.new(obj)
    end
    all
  end

  def self.find(id)
    result = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
      WHERE
        id = #{id}
    SQL
    return nil if result.empty?
    self.new(result.first)
  end

  def initialize(params = {})
    params.each do |name, value|
      attr_name = name.to_sym
      unless self.class.columns.include?(attr_name)
        raise("unknown attribute '#{attr_name}'")
      end
      send("#{attr_name}=", value)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    attributes.values
  end

  def insert
    col_names = self.class.columns[1..-1].join(', ')
    num_question_marks = []

    attribute_values.length.times do |i|
      num_question_marks << '?'
    end

    question_str = num_question_marks.join(', ')

    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES
        (#{question_str})
    SQL

    attributes[:id] = DBConnection.last_insert_row_id
  end

  def update

    cols = self.class.columns[1..-1].map { |name| "#{name} = ?" }
    cols_str = cols.join(', ')

    set_cols = attribute_values[1..-1]
    id = attribute_values[0]

    DBConnection.execute(<<-SQL, *set_cols, id)
      UPDATE
        #{self.class.table_name}
      SET
        #{cols_str}
      WHERE
        id = (?)
    SQL
  end

  def save
    if attributes[:id].nil?
      insert
    else
      update
    end
  end
end
