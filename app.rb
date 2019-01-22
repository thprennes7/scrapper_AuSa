require 'bundler'
require 'json'
require 'csv'
Bundler.require

#ce qui appelle les fichiers dans le dossier en question
$:.unshift File.expand_path('./../lib', __FILE__)
require "scrapper"

#création de l'instance
scrapper = ScrapperMail.new
#appelle des méthodes
scrapper.save_as_JSON
scrapper.save_as_spreadsheet
scrapper.save_as_csv

