require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    columns = params.keys.map { |col| "#{col} = ?" }
    values = params.values
    where_str = columns.join(' AND ')

    result = DBConnection.execute(<<-SQL, *values)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{where_str}
    SQL

    objs = []

    result.each do |result|
      objs << self.new(result)
    end

    objs
  end
end

class SQLObject
  extend Searchable
end
