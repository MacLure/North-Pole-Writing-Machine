require 'erb'

kids_data   = File.read('data/kids-data.txt')
invoice = File.read('templates/invoice_template.txt.erb')

kids_data.each_line do |kid|

  kid_data_array = kid.split

  name          = kid_data_array[0]
  behavior      = kid_data_array[1]
  toys          = kid_data_array[2..7]
  infraction    = kid_data_array[13]
  street_number = kid_data_array[8]
  street_name   = kid_data_array[9]
  street_suffix = kid_data_array[10]
  postal_code   = kid_data_array[11]
  house_value   = kid_data_array[12].to_i

  next if house_value < 200000

  if house_value > 1000000
    toy_price = 1000
  elsif house_value >= 200000
    toy_price = 100
  end

  filename    = 'letters/invoices/' + name + '.txt'
  letter_text = ERB.new(invoice, nil, '-').result(binding)

  puts "Writing #{filename}."
  File.write(filename, letter_text)

end

puts 'Done!'
