require 'bundler'
require 'json'
Bundler.require

$:.unshift File.expand_path('./../lib', __FILE__)
require "scrapper"
scrapper = ScrapperMail.new
scrapper.save_as_JSON

