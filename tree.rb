require_relative 'node.rb'

class Tree
  attr_accessor :root
  def initialize(array)
    @root = build_tree(array.sort.uniq)
  end

  def build_tree(array)
    return nil if array.empty?

    mid = (array.size - 1) / 2
    root = Node.new(array[mid])

    root.left = build_tree(array[0...mid])
    root.right = build_tree(array[mid + 1..-1])
    root
  end

  def insert(value, node = @root)
    return Node.new(value) if node.nil?

    if value < node.data 
      node.left = insert(value, node.left)
    else
      node.right = insert(value, node.right)
    end
    node
  end

  def delete(value, node = @root)
    return node if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      if node.left.nil?
        temp = node.right
        node = nil
        return temp
      elsif node.right.nil?
        temp = node.left
        node = nil
        return temp
      else
        temp = min_value_node(node.right)
        node.data = temp.data
        node.right = delete(temp.data, node.right)
      end
      node
    end
  end

  def find(value, node = @root)
    return nil if node.nil?

    if value < node.data
      find(value, node.left)
    elsif value > node.data
      find(value, node.right)
    else
      node
    end
  end

  def level_order(queue = [@root], &blk)
    return nil if queue.empty?

    node = queue.shift
    yield node
    queue.push(node.left) unless node.left.nil?
    queue.push(node.right) unless node.right.nil?

    level_order(queue, &blk)
  end

  def level_order2
    return nil if @root.nil?

    queue = [@root]
    until queue.empty?
      node = queue.shift
      yield node
      queue.push(node.left) unless node.left.nil?
      queue.push(node.right) unless node.right.nil?
    end
  end

  def inorder
  end

  def preorder
  end

  def postorder
  end

  def height
  end

  def depth
  end

  def balanced?
  end

  def rebalance
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private
  def min_value_node(node)
    current = node

    current = current.left until current.left.nil?

    current
  end
end

tree = Tree.new([1, 2, 3, 4, 6, 7, 8, 9, 10])
tree.pretty_print
#tree.insert(5)
#tree.pretty_print
tree.delete(2)
puts tree.find(2)
tree.pretty_print
tree.level_order { |node| puts node.data }