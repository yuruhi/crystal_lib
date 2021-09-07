# ```
# tree = RedBlackTree{3, 1, 4, 1, 5, 9, 2, 6, 5, 3}
# AsciiBinaryTree.print tree
# ```
class AsciiBinaryTree(Node)
  private def self.dfs(root : Node) : {Array(Array(Char)), Range(Int32, Int32)}
    if root.nil_node?
      return {Array(Array(Char)).new, 0..0}
    elsif root.left.nil_node? && root.right.nil_node?
      top = root.to_s.chars
      return {[top], 0..top.size - 1}
    end

    left, range_l = dfs(root.left)
    width_l = left.empty? ? 0 : left.first.size
    unless left.empty?
      edge = [' '] * width_l
      edge[range_l.end] = '/'
      left.unshift edge
    end

    right, range_r = dfs(root.right)
    width_r = right.empty? ? 0 : right.first.size
    unless right.empty?
      edge = [' '] * width_r
      edge[range_r.begin] = '\\'
      right.unshift edge
    end

    top_str = root.to_s.chars
    width, gap, top_space_l, top_under =
      if right.empty?
        width = Math.max(width_l, range_l.end + top_str.size + 1)
        {width, width - width_l, range_l.end + 1, 0}
      elsif left.empty?
        gap = Math.max(0, top_str.size - range_r.begin)
        top_space_l = Math.max(0, range_r.begin - top_str.size)
        {width_r + gap, gap, top_space_l, 0}
      else
        gap = 1
        space = (width_l - range_l.end - 1) + gap + (range_r.begin)
        tuple =
          if space < top_str.size
            gap += top_str.size - space
            {range_l.end + 1, 0}
          else
            if (space - top_str.size).odd?
              space += 1
              gap += 1
            end
            under = (space - top_str.size) // 2
            {range_l.end + 1, under}
          end
        {width_l + gap + width_r, gap} + tuple
      end

    top_space_r = width - top_space_l - top_under * 2 - top_str.size
    top = [' '] * top_space_l + ['_'] * top_under + top_str + ['_'] * top_under + [' '] * top_space_r

    result = [top]
    Math.max(left.size, right.size).times do |i|
      result << left.fetch(i) { [' '] * width_l } + [' '] * gap + right.fetch(i) { [' '] * width_r }
    end
    now_l = top_space_l + top_under
    now_r = now_l + top_str.size - 1

    {result, now_l..now_r}
  end

  def self.print(tree)
    puts dfs(tree.root)[0].join('\n', &.join)
  end
end
