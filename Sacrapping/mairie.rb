require "nokogiri"
require "open-uri"

def get_the_email_of_a_townhal_from_its_webpage(page_url)
  doc = Nokogiri::HTML(open(page_url))

 doc.css("td.Style27", "p.Style22").select do |element|
    puts element.text.scan(/.+@.+\.\w+/)
  end
end

def get_all_the_emails_of_val_doise_townhalls
  doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))

 doc.css("a.lientxt").each do |elementb|
    puts name  = elementb.text
    puts lien  = "http://annuaire-des-mairies.com" + elementb['href'][1..-1]
    email = get_the_email_of_a_townhal_from_its_webpage("#{lien}")
  end
end

get_all_the_emails_of_val_doise_townhalls
