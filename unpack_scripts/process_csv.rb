require 'csv'
require 'FileUtils'
require 'securerandom'

CSV.foreach('apic1.csv', headers:true).with_index(10) do |row|  #load csv file by row, include headers

uuid = SecureRandom.uuid
puts "#row['dateadded'], #row['name'], #[uuid]"


end