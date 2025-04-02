def find_all_paths(graph, start, end, path=None, all_paths=None):
    if path is None:
        path = []
    if all_paths is None:
        all_paths = []
    
    # Create a new path list to avoid modifying the original
    path = path + [start]
    
    # If we've reached the destination, add this path to our collection
    if start == end:
        all_paths.append(path)
        return
    
    # If this node isn't in the graph (no outgoing edges), stop here
    if start not in graph:
        return
    
    # Explore all neighbors recursively
    for neighbor in graph[start]:
        # Avoid cycles by not revisiting nodes in the current path
        if neighbor not in path:
            find_all_paths(graph, neighbor, end, path, all_paths)
    
    return all_paths

# Calculate distance for each path and sort by distance
def calculate_path_distance(graph, path):
    total = 0
    for i in range(len(path) - 1):
        total += graph[path[i]][path[i+1]]
    return total

# Create the graph from the map
graph = {
    'Lalbag': {'Azimpur': 1.2, 'Palashi': 1.3},
    'Azimpur': {'Nilkhet': 0.55},
    'Palashi': {'Nilkhet': 0.7},
    'Nilkhet': {'Green Road': 0.95, 'Katabon': 0.8},
    'Green Road': {'Panthapath': 1.2},
    'Katabon': {'Shahbag': 0.5, 'Saarc Circle': 1.3},
    'Panthapath': {'UAP': 0.5},
    'Shahbag': {'Saarc Circle': 1.4},
    'Saarc Circle': {'Panthapath': 0.65, 'Farmgate': 0.9},
    'Farmgate': {'UAP': 0.3},
    'UAP': {} 
}

# Find all paths from Lalbag to UAP
all_paths = find_all_paths(graph, 'Lalbag', 'UAP')

# Calculate distance for each path and sort by distance
path_distances = []
for path in all_paths:
    distance = calculate_path_distance(graph, path)
    distance = round(distance, 1)
    path_distances.append((path, distance))

# Sort paths by distance
path_distances.sort(key=lambda x: x[1])

# Display all paths with their distances
print(f"Found {len(all_paths)} paths from Lalbag to UAP:")
for i, (path, distance) in enumerate(path_distances, 1):
    print(f"Path {i}: {' -> '.join(path)} ({distance} km)\n")

# Display the optimal path
optimal_path, optimal_distance = path_distances[0]
print(f"\nOptimal path: {' -> '.join(optimal_path)} with distance {optimal_distance} km")
