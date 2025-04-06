import heapq

# Graph with actual distances (g)
graph = {
    'Lalbag': {'Azimpur': 1.2, 'Palashi': 1.3},
    'Azimpur': {'Nilkhet': 0.55},
    'Palashi': {'Nilkhet': 0.7},
    'Nilkhet': {'Green Road': 0.95, 'Katabon': 0.8},
    'Green Road': {'Panthapath': 1.2},
    'Katabon': {'Shahbag': 0.5, 'Saarc Circle': 1.3},
    'Shahbag': {'Saarc Circle': 1.4},
    'Saarc Circle': {'Panthapath': 0.65, 'Farmgate': 0.9},
    'Panthapath': {'UAP': 0.5},
    'Farmgate': {'UAP': 0.3},
    'UAP': {}
}

# Heuristic values (h) 
heuristics = {
    'Lalbag': 4.1,
    'Azimpur': 3.1,
    'Palashi': 3.1,
    'Nilkhet': 2.6,
    'Green Road': 1.7,
    'Katabon': 1.8,
    'Shahbag': 2.0,
    'Saarc Circle': 0.7,
    'Panthapath': 0.5,
    'Farmgate': 0.3,
    'UAP': 0
}

def a_star_search(start, goal):
    open_set = [(heuristics[start], start, [start], 0)]
    visited = set()

    while open_set:
        f_score, current, path, g_score = heapq.heappop(open_set)

        if current == goal:
            return path, g_score

        if current in visited:
            continue
        visited.add(current)

        for neighbor, cost in graph.get(current, {}).items():
            if neighbor not in visited:
                new_g = g_score + cost
                new_f = new_g + heuristics[neighbor]
                heapq.heappush(open_set, (new_f, neighbor, path + [neighbor], new_g))

    return None, float('inf')

# A* algorithm
path, total_cost = a_star_search('Lalbag', 'UAP')

# Output the result
print("Optimal Path:", " -> ".join(path))
print("Total Cost:", round(total_cost, 2), "km")
