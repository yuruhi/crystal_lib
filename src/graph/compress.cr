require "../graph"

module Graph(Edge, Edge2)
  # Returns the graph that deleted isolated vertices.
  def compress : self
    values = [] of Int32
    each { |edge| values << edge.from << edge.to }
    values.uniq!.sort!

    each_with_object(self.class.new(values.size)) do |edge, compressed|
      edge.from = values.bsearch_index { |x| edge.from <= x }.not_nil!
      edge.to = values.bsearch_index { |x| edge.to <= x }.not_nil!
      compressed << edge
    end
  end
end
