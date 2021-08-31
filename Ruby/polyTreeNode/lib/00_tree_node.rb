class PolyTreeNode
    def initialize(val = nil)
        @value , @parent , @children = val, nil, []
    end

    attr_accessor :value, :children
    attr_reader :parent
    
    
    def parent=(newParent)
        parent.children.delete(self) unless parent.nil?
        @parent = newParent                                
        parent.children << self unless newParent.nil?
    end 

    def add_child(newChild)
        newChild.parent = self 
    end

    def remove_child(child_node)
        raise "error, node is not a child" unless children.include?(child_node) 
        child_node.parent = nil 
    end

    def dfs(target_val = nil, &prc)
        raise "Need a target or a proc.." unless prc || target_val
        prc ||= Proc.new{|node| node.value == target_val}
        return self if prc.call(self)
        children.each do |child_node|
            res = child_node.dfs(target_val)
            return res unless res.nil? 
        end
        nil 
    end

    def bfs(target_val = nil , &prc)
        raise "Need a target or a proc.." unless prc || target_val
        prc ||= Proc.new{|node| node.value == target_val}
        queue = [self]
        while(!queue.empty?)
            curr_node = queue.shift
            return curr_node if prc.call(curr_node)
            queue.concat(curr_node.children)
        end
        nil 
    end

end

