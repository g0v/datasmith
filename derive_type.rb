require 'csv'
require 'json'

def column_types(rows)
  taiwan_location_tokens = []
  File.open("cities.csv").each_line { |line| taiwan_location_tokens << line.chomp }

  columns = rows.transpose
  cts = []
  parsed = []

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

    if taiwan_location_token_match_count > c.uniq.size / 2
      cts << [:taiwan_location, taiwan_location_token_match_count / c.uniq.size.to_f]

      parsed_col = []
      c.each do |x|
        checked = false
        taiwan_location_tokens.each do |t|
          if x.include? t
            parsed_col << t
            checked = true
            break
          end
        end
        parsed_col << x unless checked
      end
      parsed << parsed_col
    else
      cts << [nil,0]
      parsed << c
    end
  end

  return cts, parsed
end

rows = []
input = CSV.open(ARGV[0], { headers: :first_row, return_headers: false })
input.each do |row|
  rows << row.to_hash.values
end

cts, parsed = column_types(rows)
puts cts.to_json

output = CSV.open(ARGV[1], 'wb', { headers: input.headers, write_headers: true })
parsed.transpose.each do |r|
  output << r
end

