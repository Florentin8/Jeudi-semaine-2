
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'HTTParty'
require 'Pry'

def get_all_crypto_names_and_trading_values
	begin

		page = HTTParty.get("https://coinmarketcap.com/")
		parse_page = Nokogiri::HTML(page)

	xpath = '//td[@class="no-wrap currency-name"]/ a[@class="currency-name-display"]'
		crypto_name_html = parse_page.xpath(xpath)

		crypto_data =[]
		crypto_name_html.each {|i| crypto_data << {:name => i.text, :value => 0}}

		xpath_crypto = '//a[@class="price"]/ @data-usd'
		crypto_trading_value = parse_page.xpath(xpath_crypto)

		(0..(crypto_data.length-1)).each do |j|
			crypto_data[j][:value] = crypto_trading_value[j].text.to_f
		end
		puts crypto_data
		crypto_data

	rescue => e
	  puts "Exception Class: #{ e.class.name }"
	  puts "Exception Message: #{ e.message }"
	  puts "Exception Backtrace: #{ e.backtrace }"
	end
end

	(0..100).each { |i|
		$x = get_all_crypto_names_and_trading_values
		puts $x
		puts "round#{i}"
		sleep(y);
	}
end

def wallet_value_calculator (array)
	lenght_wallet = array.length

	total_wallet_value = 0
	crypto_wallet_value = []

	crypto_trading_values = get_all_crypto_names_and_trading_values

	wallet_overview = array

	trading_value_now = 0

	(0..(lenght_wallet-1)).each do |i|
		trading_value_now = crypto_trading_values.select {|y| y[:name] == wallet_overview[i][:crypto_name]}
		wallet_overview[i][:value_owned] = wallet_overview[i][:number_crypto] * trading_value_now[0][:value]
		total_wallet_value += wallet_overview[i][:value_owned]
	end

	puts wallet_overview
	puts "Your wallet value totals " + total_wallet_value.to_s + " $"
end

x = [
	{:crypto_name =>"Ripple",:number_crypto =>900.0},
	{:crypto_name =>"Litecoin",:number_crypto => 1.4},
	{:crypto_name =>"NEO",:number_crypto =>3.0},
	{:crypto_name =>"Iconomi",:number_crypto =>35.0},
	{:crypto_name =>"Monero",:number_crypto =>1.04},
	{:crypto_name =>"EOS",:number_crypto =>100.0},
	{:crypto_name =>"Melon",:number_crypto =>1.67},
	{:crypto_name =>"IOTA",:number_crypto =>60.0}
]

wallet_value_calculator (x)
