# frozen_string_literal: true

require_relative 'tree'


tree = Tree.new(Array.new(15) { rand(1..100) })
tree.pretty_print
puts "Tree balanced? #{tree.balanced?}"

puts "Level order:"
tree.level_order { |node| print node.data.to_s + ", "}
puts "\nPre order:"
tree.preorder { |node| print node.data.to_s + ", "}
puts "\nPost order:"
tree.postorder { |node| print node.data.to_s + ", "}
puts "\nIn order:"
tree.inorder { |node| print node.data.to_s + ", "}
puts "\n"

puts "Inserting numbers > 100"
tree.insert(111)
tree.insert(222)
tree.pretty_print
puts "Tree balanced? #{tree.balanced?}"
puts "Rebalancing.."
tree.rebalance
tree.pretty_print
puts "Tree balanced? #{tree.balanced?}"

puts "Level order:"
tree.level_order { |node| print node.data.to_s + ", "}
puts "\nPre order:"
tree.preorder { |node| print node.data.to_s + ", "}
puts "\nPost order:"
tree.postorder { |node| print node.data.to_s + ", "}
puts "\nIn order:"
tree.inorder { |node| print node.data.to_s + ", "}
puts "\n"