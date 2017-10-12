require 'minitest/autorun'
require_relative 'lootbag'
class DeveloperTest < Minitest::Test
	def setup
		@lootBag = Bag.new(bob:{presents:["Balls","Bag","Kites"],delivered:false},sarah:{presents:["Legos","Toy Car","EZ-Bake Oven"],delivered:false})
	end
	def test_toys_for_child_can_be_added_to_bag
		@lootBag.add_toy_for_child("Legos", :suzy)
		@lootBag.add_toy_for_child("Watch", :suzy)
		@lootBag.add_toy_for_child("Mirror", :Suzy)
		assert_includes( @lootBag.bags[:suzy][:presents], "Mirror")
	end

	def test_toys_for_child_can_be_removed_from_bag
		@lootBag.remove_toy_for_child("Bag", :bob)
		assert_equal("This Item Doesn't Exist!",@lootBag.remove_toy_for_child("Bag", :bob) )
		assert_equal(2, @lootBag.method(:remove_toy_for_child).arity)
		refute_includes( @lootBag.bags[:bob][:presents], "Bag")
	end

	def test_children_can_be_listed_with_or_without_name_arg
		@lootBag.respond_to?(:ls)
		begin
			@lootBag.ls("bob","sarah")
		rescue ArgumentError => e
			assert_includes(e.message,"expected 0..1")
			assert_equal(true, e.message.include?('expected 0..1'))
			p "Is the expected number of arguments for :ls '0..1'?: #{e.message.include?('expected 0..1')}"
		end
	end
	def test_presents_can_be_delivered
		@lootBag.deliver_toy_for_child("sarah")
		assert_equal(true, @lootBag.bags[:sarah][:delivered])
	end

	def test_delete_all_presents_of_a_child
		@lootBag.delete_all_toys_of_a_child("sarah")
		assert_empty @lootBag.bags[:sarah][:presents]
	end

	def teardown
	end
end
