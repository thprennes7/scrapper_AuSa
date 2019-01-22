require 'bundler'
require 'json'
require 'csv'
Bundler.require

$:.unshift File.expand_path('./../lib', __FILE__)
require "scrapper"
scrapper = ScrapperMail.new
scrapper.save_as_JSON
scrapper.save_as_spreadsheet
scrapper.save_as_csv

