class RemoveDuplicateProvinces < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      DELETE bad_rows.*
      FROM provinces AS bad_rows
      INNER JOIN (
      SELECT 
        number,
        name,
        abbreviation,
        min(id) AS min_id
      FROM provinces
      GROUP BY 
        number,
        name,
        abbreviation
      HAVING count(*) > 1
      ) AS good_rows 
      ON  good_rows.number 		      = bad_rows.number
      AND good_rows.name        		= bad_rows.name
      AND good_rows.abbreviation 		= bad_rows.abbreviation
      AND good_rows.min_id <> bad_rows.id
    SQL
  end

  def self.down
  end
end
