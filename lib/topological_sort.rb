require_relative 'graph'

# Implementing topological sort using both Khan's and Tarjan's algorithms

def kahns_topological_sort(vertices)
  result = []
  starting_vertices = in_degree_zero(vertices)
  while !starting_vertices.empty?
    # debugger
    vertex = starting_vertices.shift
    vertex.visited = true
    result << vertex
    neighbors = vertex.out_edges.map { |e| e.to_vertex }
    in_degree_zero(neighbors).each do |neighbor|
      starting_vertices.push(neighbor) unless starting_vertices.include?(neighbor)
    end
  end
  result.each {|v| v.visited = false}
  result
end

def in_degree_zero(vertices)
  vertices.select do |v|
    v.in_edges.all? { |e| e.from_vertex.visited }
  end
end

def topological_sort(vertices)
  result = []
  visited = Set.new
  vertices.each do |vertex|
    dfs(vertex, visited, result) unless visited.include?(vertex)
  end
  result
end

def dfs(vertex, visited, result)
  visited.add(vertex)

  vertex.out_edges.each do |edge|
    dfs(edge.to_vertex, visited, result) unless visited.include?(edge.to_vertex)
  end
  result.unshift(vertex)
end
