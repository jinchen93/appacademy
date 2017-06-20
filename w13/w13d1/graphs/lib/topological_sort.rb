require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted = []
  sort_queue = []

  vertices.each do |vertex|
    sort_queue << vertex if vertex.in_edges.empty?
  end

  until sort_queue.empty?
    current_vertex = sort_queue.shift
    sorted << current_vertex
    current_vertex.out_edges.each do |edge|
      to_vertex = edge.to_vertex
      edge.destroy!
      sort_queue << to_vertex if to_vertex.in_edges.empty?
    end
  end

  sorted
end
