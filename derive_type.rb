require 'csv'

def column_types(rows)
  taiwan_location_tokens = []
  File.open("taiwan_location.csv").each_line { |line| taiwan_location_tokens << line.chomp }

  columns = rows.transpose
  cts = []

  columns.each do |c|
    taiwan_location_token_match_count = 0
    c.uniq.each do |x|
      taiwan_location_tokens.each do |t|
        if x.include? t
          taiwan_location_token_match_count += 1
          break
        end
      end
    end

    puts "#{taiwan_location_token_match_count} / #{c.uniq.size}"
    if taiwan_location_token_match_count > c.uniq.size / 2
      cts << :taiwan_location
    else
      cts << nil
    end
  end

  return cts
end

rows = []
CSV.foreach(ARGV[0], { headers: :first_row, return_headers: false }) do |row|
  rows << row.to_hash.values
end

p column_types(rows)
