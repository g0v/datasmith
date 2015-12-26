require 'erb'
require 'csv'
require 'json'

labelCol = ARGV[1].to_i

label_count = Hash.new { |h,k| h[k] = 0 }

input = CSV.read(ARGV[0], {headers: :first_row, return_headers: false})
input.each do |row|
  label_count[row[labelCol]] += 1
end

datas = label_count.to_a.sort_by { |x| -1* x[1] }
data = {
  labels: datas.map { |x| x[0] }[0..10],
  datasets: [{
    label: "My First dataset",
    fillColor: "rgba(220,220,220,0.2)",
    strokeColor: "rgba(220,220,220,1)",
    pointColor: "rgba(220,220,220,1)",
    pointStrokeColor: "#fff",
    pointHighlightFill: "#fff",
    pointHighlightStroke: "rgba(220,220,220,1)",
    data: datas.map { |x| x[1] }[0..10]
  }]
}
dataStr = data.to_json
label_name = input.headers[labelCol]

puts ERB.new(File.read("./label_count.erb")).result()
