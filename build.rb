require 'json'

ct = `ruby derive_type.rb #{ARGV[0]} temp.csv`
score = JSON.parse(ct).map.with_index { |x,i| x + [i]}.sort_by { |x| -1*x[1] }

puts `ruby label_count_renderer.rb temp.csv #{score[0][2]} #{File.basename(ARGV[0], '.csv')}`
