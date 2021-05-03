require 'bundler'
require 'json'
require 'csv'
Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)
require 'controller'
require 'gossip'

run ApplicationController
