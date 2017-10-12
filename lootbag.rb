require 'securerandom'
require 'json'
p SecureRandom.uuid

class Bag
	attr_accessor :bags,:ls

	def initialize(bags={bob:{presents:["Balls","Bag","Kites"],delivered:false},sarah:{presents:["Legos","Toy Car","EZ-Bake Oven"],delivered:false}})
		@bags = bags

	end
	def add_toy_for_child(first,second)
		if @bags.has_key? second.downcase.to_sym
			@bags[second.downcase.to_sym][:presents]<<first.downcase.capitalize
		else
			@bags[second.downcase.to_sym] = {presents:[first.downcase.capitalize],delivered:false}
		end
		puts
		p "Adding #{first} to #{second}'s list."
		puts "#{@bags}"
		puts
		@bags
	end
	def remove_toy_for_child(first,second)
		if second == nil || @bags[second.downcase.to_sym] == nil
			puts
			puts "Child's Name Required or Does Not Exist!"
			return
		end
		if @bags[second.downcase.to_sym][:presents].find_index(first) != nil && second !=nil
			@bags[second.downcase.to_sym][:presents].delete_at(@bags[second.downcase.to_sym][:presents].find_index(first))
			puts
			p "Removing #{first} to #{second}'s list."
			p "#{@bags}"
			puts
			@bags
		else
			puts
			puts "This Item Doesn't Exist!"
			return "This Item Doesn't Exist!"
		end

	end

	def ls(a=nil)
		if a != nil
			p a
			p @bags[a.to_sym][:presents]
		else
			@bags.keys.each{|a| puts a.to_s}
		end
	end

	def deliver_toy_for_child(child)
		if @bags[child.downcase.to_sym] !=nil
			@bags[child.downcase.to_sym][:delivered]=true
			puts
			puts "Delivered presents for #{child.capitalize}!"
			p @bags
			@bags
		else
			puts
			p "This Child Does Not Exist!"
		end
	end


	def help
		puts
		puts "===ARGV Arguments==="
		puts "add (item) (name) - Adds a toy onto a child's list"
		puts "remove (item) (name) - Removes a toy from a child's list"
		puts "remove all (name) - Removes all the toys from a Naughty Child's list"
		puts "ls - Lists all the children receiving presents"
		puts "ls (name) - Lists all the presents of a child"
		puts "delivered (name) - Delivers a child's toys"
		puts "help - Lists all available ARGV arguments and public methods"
		puts
		puts "===Public Methods==="
		(self.methods - @bags.methods).sort.each{|a|
			result = case a.to_s
			when "ls" then " - Lists all the children receiving presents"
			when "bags" then " - Shows the lootbag object"
			when "ls=" then " - Lists all the presents of a child"
			when "add_toy_for_child" then " - Adds a toy onto a child's list"
			when "remove_toy_for_child" then " - Removes a toy from a child's list"
			when "help" then " - Lists all available public methods"
			when "deliver_toy_for_child" then " - Delivers a child's toys"
			else " - **Deprecated Method**"
			end
			puts "."+a.to_s+result
		}
	end

	def delete_all_toys_of_a_child(child)
		if @bags[child.downcase.to_sym]
			@bags[child.downcase.to_sym][:presents]=[]
			puts
			puts "All Presents Removed!"
			puts @bags
			@bags
		else
			puts
			puts "Child Does Not Exist!"
		end
	end
end

@first = ARGV[0]
@second = ARGV[1]
@third = ARGV[2]
puts "Function: #{@first}. Name: #{@second}. Item: #{@third}. "
bag = Bag.new
if @first.downcase.include?("add")
	if @third
		bag.add_toy_for_child(@second,@third)
	else
		puts
		puts "Child's Name Required"
	end
elsif @first.downcase.include?('remove') && @second && @third !=nil && @second.downcase == 'all'
	bag.delete_all_toys_of_a_child(@third)
elsif @first.downcase.include?('remove')
	if @third
		bag.remove_toy_for_child(@second,@third)
	else
		puts
		puts "Child's Name Required"
	end
elsif @first.downcase.include?("ls")
	if @second
		bag.ls(@second.downcase)
	else
		bag.ls
	end
elsif @first.downcase.include?('delivered')
	bag.deliver_toy_for_child(@second.downcase)
elsif @first.downcase.include?('help')
	bag.help
else
	puts
	puts "Argument Invalid: Use 'help' to see list of valid arguments!"
end

# file = File.read('./presentlist.json')
# lootfile = JSON.parse(file)
# l = Bag.new(lootfile)

# l.add_toy_for_child("kite", ":sarah")

# puts l.bags

# json_from_hash = l.bags.to_json

# newJson = open('./presentlist.json', 'r+')
# newJson.read
# newJson.write(json_from_hash)
# newJson.close
# puts lootfile["bob"]