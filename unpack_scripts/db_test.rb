require 'sqlite3'
require 'csv'

def schema
  query = <<-SQL
    CREATE TABLE catalogue (
      dateadded date,
      dateupdated date,
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
      :dateadded,
      :dateupdated,
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


  
  # generate the three levels of folders - top index, departmental folders, individual api folders
  orgs = tx.query("SELECT organisation, count(*), provider FROM catalogue GROUP BY organisation")

  orgs.each { |row| 
     puts row
     prov = row["provider"]
     provs = tx.query("SELECT name, maintainer, provider FROM catalogue WHERE provider = ? GROUP BY name", prov)
        provs.each { |row| 
          puts row
          api_pr = row["provider"]
          api_name = row["name"]
          apis = tx.query("SELECT name, url, documentation, maintainer, provider FROM catalogue WHERE provider = ? AND name = ? GROUP BY name", api_pr, api_name)
             apis.each { |row|
             puts row
             }
        }
    }
    
  #build the dashboard
  count = tx.query("SELECT count(*) FROM catalogue").next
  number_of_depts = tx.query("SELECT count(distinct provider) FROM catalogue").next
  org_count = tx.query("SELECT organisation, count(*) AS number, provider, min(dateadded) AS firstadded, max(dateupdated) AS mostrecent FROM catalogue GROUP BY provider ORDER BY count(*) DESC")
  
  puts "---\ntitle: API Catalogue Contents\nweight: 1000\nhide_in_navigation: true\n---"
  puts "## API Catalogue Contents\n\n<div style=\"height:1px;font-size:1px;\">&nbsp;</div>\n|Total APIs:|Departments Represented:|\n|:---|:---|"
  puts "|#{count["count(*)"]}|#{number_of_depts["count(distinct provider)"]}|"
  puts "\n<div style=\"height:1px;font-size:1px;\">&nbsp;</div>\n"
  org_count.each { |org| 
    puts "|#{org['organisation']}|#{org['number']}|#{org['firstadded']}|#{org['mostrecent']}|[#{org['provider']}](/api-catalogue/#{org['provider']})|"
   }

    
end

def load_all
  db = SQLite3::Database.new ":memory:"
  db.results_as_hash = true
  db.transaction do |tx|
    load_catalogue(tx, "apic1.csv")
  end
rescue SQLite3::Exception => e
  puts "Exception occurred"
  puts e
end


# Main
load_all
