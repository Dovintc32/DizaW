import json
import os

# Путь к файлу
filename = "inventory.json"

# Если файл не существует — создать с нуля
if not os.path.exists(filename):
    data = {}
else:
    # Иначе — загрузить существующий
    with open(filename, "r", encoding="utf-8") as f:
        data = json.load(f)

# Создать/обновить 3 линии, 6 колонок в каждой
for i in range(1, 4):  # Line1, Line2, Line3
    line_key = f"{i}"
    if line_key not in data:
        data[line_key] = {}

    for j in range(1, 7):  # Column1 ... Column6
        col_key = f"{j}"
        data[line_key][col_key] = {
            "Item": "DizaW:Air",
            "Busy": False
        }

# Сохранить обратно
with open(filename, "w", encoding="utf-8") as f:
    json.dump(data, f, indent=4, ensure_ascii=False)