# Node is the data structure used for Binary Search Tree Node.
# Node has data, and reference to left and right nodes 
class Node
  attr_reader :data             # we want data to be read only, set only during creating the node
  attr_accessor :left, :right   # left and right nodes will be set in the tree

  def initialize(data = 0, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
  
  # utility method to print node's data and a space
  def printnode
    print @data, " "
  end
end

# Binary Search Tree
class Tree
  attr_reader :root

  def initialize 
    @root = nil
  end

  #pre order traversal of binary tree
  def preorder(node = @root)
    return if (nil == node)
    node.printnode
    preorder(node.left)
    preorder(node.right)  
  end

  # in order traversal of binary tree
  def inorder(node = @root)
    return if (nil == node)
    inorder(node.left)
    node.printnode
    inorder(node.right)  
  end 

  #post order traversal of binary tree
  def postorder(node = @root)
    return if (nil == node)
    postorder(node.left)
    postorder(node.right)  
    node.printnode
  end

  # Breadth First traversal of binary tree (level by level from left to right)
  def breadthfirst(node = @root)
    queue = []
    queue << node if (nil != node) # add root to queue
    until (queue.empty?)
       removedNode = queue.shift
       removedNode.printnode
       queue << removedNode.left if (nil != removedNode.left)
       queue << removedNode.right if (nil != removedNode.right)
    end
  end
  
  # insert data into binary search tree
  # start with the root node of binary search tree and check recursively data 
  # and decide to go left or right, when reached end, create new node and set parent left or right
  def insert(data, node = @root)
    if (nil == node) then
       n = Node.new(data)
       @root = n if (nil == @root)
       return n
    end
    if (data < node.data)
       node.left = insert(data, node.left)
    elsif (data > node.data)
       node.right = insert(data, node.right)
    end
    # no need to add duplicate node = case
    return node
    end

end

# creating the tree and testing it
t = Tree.new
t.insert(5) # root node
t.insert(3)
t.insert(4)
t.insert(1)
t.insert(2)
t.insert(7)
t.insert(6)
t.insert(9)
t.insert(10)
t.insert(8)
t.insert(0)
puts "---------"
puts "Pre: #{t.preorder}"
puts "In: #{t.inorder}"
puts "Post: #{t.postorder}"
puts "BF: #{t.breadthfirst}"

# convert above binary search tree to Double link list
# Same tree Node structure will be used for Double link list
# left and and right will be assumed as forward and backward
class TreeToDList
  attr_reader :head, :tail

  def initialize(root)
     @head = nil
     @tail = nil
     @prev = nil
     inorderConvert(root)
  end

  private
  def inorderConvert(node)
     return if (nil == node)
     inorderConvert(node.left)
     swapLink(node)
     inorderConvert(node.right)
  end

  def swapLink(node)
     if (nil == @prev) then
       @head = node
     else
       node.left = @prev  #swap the links
       @prev.right = node
     end
     @prev = node 
     @tail = node if (nil == node.right) 
  end

  public
  def printlist
     puts "Head>>Tail:"
     tmp = @head
     until (nil == tmp)
       tmp.printnode
       tmp = tmp.right
     end
     tmp = @tail
     puts "\b\nTail>>Head:"
     until (nil == tmp)
       tmp.printnode
       tmp = tmp.left
     end
     puts "\n---"
  end
end
# test the list
dl = TreeToDList.new(t.root)
dl.printlist
