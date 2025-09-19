import time
Limit = 10000

start = time.perf_counter()
num = 1
while num < Limit:
    num += 1
print("Python time:", time.perf_counter() - start)
print(f"end {Limit}")