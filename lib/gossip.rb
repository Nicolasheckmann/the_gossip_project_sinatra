require 'pry'
require 'csv'
class Gossip
  attr_accessor :author, :content

  def initialize(author, content)
    self.author = author
    self.content = content
  end
  
  # def save_as_json
  #   temp_hash = {author: self.author, content: self.content}

  #   json = File.read('db/gossip.json')
  #   data_h = JSON.parse(json.to_json) 
  #   puts data_h
  #   puts data_h.class
  #   # File.open("db/gossip.json", "a") do |f|
  #   #   f.puts JSON.parse(json) << JSON.pretty_generate(params)
  #   # end
  #   File.write("db/gossip.json", JSON.pretty_generate(temp_hash), File.size("db/gossip.json"), mode: 'a')
  #   # , File.size("db/gossip.json"), mode: 'a'
  # end

  def save_as_csv
    CSV.open("db/gossip.csv","a",headers: true) do |csv| 
      csv << [author, content]
    end
  end

  def self.find(id)
    gossip_from_id = nil
    CSV.open("db/gossip.csv",'r', headers: true) do |csv|
      gossip_from_id_arr = csv.select.with_index { |row, i| i == id }.to_csv.gsub(/\n|\"/,'').split(",")
      gossip_from_id = Gossip.new(gossip_from_id_arr[0], gossip_from_id_arr[1])
    end
    return gossip_from_id
  end

  def self.all
    all_gossips = []
    CSV.open("db/gossip.csv","a+", headers: true) do |csv|
      csv.each do |row|                        
        dummy_gossip = Gossip.new(row[0], row[1])
        all_gossips << dummy_gossip
      end
    end
    return all_gossips
  end

  def self.destroy_gossip(index_to_be_destroyed)
    table = CSV.table("db/gossip.csv")
    table.delete(index_to_be_destroyed)
    File.open("db/gossip.csv",'w') do |f|
      f.write(table.to_csv)
    end
  end
end