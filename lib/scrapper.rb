# frozen_string_literal: true

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'

class ScrapperMail
    
    
def initialize
  city_names = []
  mail = []
  page = Nokogiri::HTML(open('http://annuaire-des-mairies.com/val-d-oise.html'))

  page.xpath('//a[@class="lientxt"]').each do |row|
    city_names.push(row.text)
    mail.push(Nokogiri::HTML(open('http://annuaire-des-mairies.com' + row['href'].sub('.', ''))).xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text)
  end
  @mail_list = city_names.zip(mail).to_h
  
  
end

def save_as_JSON
    file = File.open("db/mail.json","w")
    file.write(@mail_list.to_json)
    file.close
end

#get_mail
#binding.pry
#puts "end of fil"
end