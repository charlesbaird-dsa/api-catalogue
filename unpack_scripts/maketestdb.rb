require 'sqlite3'
require 'csv'

def schema
  query = <<-SQL
    CREATE TABLE catalogue (
      id text PRIMARY KEY,
      url text,
      name text NOT NULL,
      description text,
      documentation text,
      license text,
      maintainer text,
      provider text,
      areaServed text,
      startDate date,
      endDate date,
      organisation text
    );
  SQL

  query
end

def load_catalogue(tx, path)
  tx.execute(schema)

  catalogue = CSV.read(path, headers: true).map(&:to_h)

  insert_query = <<-SQL
    INSERT INTO catalogue VALUES (
      :id,
      :url,
      :name,
      :description,
      :documentation,
      :license,
      :maintainer,
      :provider,
      :areaServed,
      :startDate,
      :endDate,
      :organisation
    );
  SQL
  stmt = tx.prepare(insert_query)

  catalogue.each do |record|
    stmt.execute(record)
  end

  count = tx.query("SELECT count(*) FROM catalogue").next

  puts count
end

def load_all
  db = SQLite3::Database.new "apic.db"
  db.transaction do |tx|
    load_catalogue(tx, "apic1.csv")
  end
rescue SQLite3::Exception => e
  puts "Exception occurred"
  puts e
end


# Main
load_all
