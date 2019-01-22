# frozen_string_literal: true

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'json'
require 'google_drive'
require 'csv'

# création de la class
class ScrapperMail
    
# méthode qui nous permet d'initialiser notre instance et qui permet de scrapper les mairie(95) 
def initialize  
  city_names = []
  mail = []
# fonction qui va chercher les infos d'un site demandé
  page = Nokogiri::HTML(open('http://annuaire-des-mairies.com/val-d-oise.html'))
# on récupère tous les élements d'une page html et on boucle pour les stocker dans des array
  page.xpath('//a[@class="lientxt"]').each do |row|
    city_names.push(row.text)
    
    mail.push(Nokogiri::HTML(open('http://annuaire-des-mairies.com' + row['href'].sub('.', ''))).xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text)
  end
# création d'une hash grace à nos deux array.
  @mail_list = city_names.zip(mail).to_h
end

#méthode pour récupéré notre database et créer un fichier pour la sauvegarder.   
def save_as_JSON
# création d'un fichier pour sauvegarder notre database 
    file = File.open("db/mail.json","w")
# on ecris sur notre fichier la database     
    file.write(@mail_list.to_json)
    file.close
end

#méthode pour récupéré notre database, la sauvegarder sur google_drive et créer un fichier sous forme d'un exel.    
def save_as_spreadsheet
session =  GoogleDrive::Session.from_config ("config.json")
    ws = session.spreadsheet_by_key("1LsfkJ4MyRCeAK_7hLpMCJNaDsaFgeE9xjDON8w6D9M8").worksheets[0]
#une boucle pour placer correctement nos element dans un tableau type exel    
    @mail_list.each_with_index do |(city, mail),index|
        ws[index + 1,1] = city
        ws [index +1, 2] = mail
    end
#en tête des nos colonnes    
    ws [1, 1] = "City"
    ws [1, 2] = "Mail"
    ws.save  
end

  
    def save_as_csv
# création d'un fichier pour sauvegarder notre database         
     file = CSV.open("db/mail.csv", "wb") do |csv|
         csv << ["city", "name"]
# boucle pour remplir notre fichier          
      @mail_list.each do |(city,name)|
          csv << [city,name]
      end
     end
    end
end