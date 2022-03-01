# frozen_string_literal: true

require_relative 'node'

# Primitive tree class
class Tree # rubocop:disable Metrics/ClassLength
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
      delete_helper(node)
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

  def level_order(queue = [@root], &blok)
    return nil if queue.empty?

    node = queue.shift
    yield node
    queue.push(node.left) unless node.left.nil?
    queue.push(node.right) unless node.right.nil?

    level_order(queue, &blok)
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

  def inorder(node = @root, &blok)
    return nil if node.nil?

    inorder(node.left, &blok)
    yield node
    inorder(node.right, &blok)
  end

  def preorder(node = @root, &blok)
    return nil if node.nil?

    yield node
    preorder(node.left, &blok)
    preorder(node.right, &blok)
  end

  def postorder(node = @root, &blok)
    return nil if node.nil?

    postorder(node.left, &blok)
    postorder(node.right, &blok)
    yield node
  end

  def height(node)
    return -1 if node.nil?

    [height(node.left), height(node.right)].max + 1
  end

  def depth(node, parent = @root, edges = 0)
    if node.data < parent.data
      depth(node, parent.left, edges + 1)
    elsif node.data > parent.data
      depth(node, parent.right, edges + 1)
    else
      edges
    end
  end

  def balanced?(node = @root)
    return true if node.nil?

    left = height(node.left)
    right = height(node.right)
    diff = (left - right).abs
    return false if diff > 1

    balanced?(node.left) && balanced?(node.right)
  end

  def rebalance
    arr = []
    inorder { |node| arr.push(node.data) }
    @root = build_tree(arr)
  end

  def pretty_print(node = @root, prefix = '', is_left = true) # rubocop:disable Style/OptionalBooleanParameter
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  def min_value_node(node)
    node = node.left until node.left.nil?
    node
  end

  def delete_helper(node) # rubocop:disable Metrics/MethodLength
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

tree = Tree.new([1, 2, 3, 4, 6, 7, 8, 9, 10])
tree.pretty_print
tree.delete(2)
tree.pretty_print
