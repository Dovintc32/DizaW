import json

data = {}
for y in range(20, -51, -1):
    y_key = f"y{y}"
    data[y_key] = {}
    for x in range(0, 101):
        data[y_key][f"x{x}"] = 0

with open('world.json', 'w') as f:
    json.dump(data, f, indent=4)