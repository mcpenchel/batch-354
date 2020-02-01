require 'open-uri'
require 'nokogiri'

gift_list = [
  {name: "Hamster", bought: false}, {name: "Almoço", bought: true}
]

user_action = ""

until user_action == "quit"

  puts "What do you want to do? [idea/list/add/delete/mark/quit]"
  user_action = gets.chomp

  case user_action
  when "list"
    gift_list.each_with_index do |hash, index|
      bought = hash[:bought] ? "X" : " "
      puts "#{index + 1} [#{bought}] #{hash[:name]}"
    end
  when "add"
    puts "What do you want for Christmas?"
    gift = gets.chomp
    gift_list << {name: gift, bought: false}
  when "delete"
    puts "Which item you don't want anymore? Provide the number"
    gift_index = gets.chomp.to_i
    gift_list.delete_at(gift_index - 1)
  when "mark"
    puts "Which item you bought? Provide the number"
    gift_index = gets.chomp.to_i

    gift_list[gift_index - 1][:bought] = true
  when "idea"
    puts "Which item do you want to get ideas for?"
    idea = gets.chomp

    html_content = open("https://www.etsy.com/search?q=#{idea}").read

    doc = Nokogiri::HTML(html_content)

    search_items = []

    doc.search('.mb-xs-0')[0..20].each_with_index do |element, index|
      search_items << element.text.strip
      puts "#{index + 1} #{element.text.strip[0..20]}"
    end

    puts "Which one do you want to add to your wish list? Provide the number"
    chosen_number = gets.chomp.to_i - 1

    gift_list << {name: search_items[chosen_number], bought: false}

  end

end
