# 產生用來猜一個 column 是不是指台灣地點的 token
require 'csv'

areas = []
cities = []
CSV.foreach("address.csv", {headers: :first_row, return_headers: false}) do |row|
  cities << row[0].gsub("\s","")[0..1] # 台北, 台中... etc
  areas << row[0].gsub("\s","")[3..4] # 五股, 八里... etc
end

File.open("areas.csv", 'w') do |f|
  areas.uniq.each { |a| f.puts a }
end

File.open("cities.csv",'w') do |f|
  cities.uniq.each { |c| f.puts c }
end

File.open("taiwan_location.csv", 'w') do |f|
  areas.uniq.each { |a| f.puts a }
  cities.uniq.each { |c| f.puts c }
end
