def solve(t: int, d: int, val: int):
    speed = val
    leftover = t - val
    distance = speed * leftover
    return distance > d


def binary_search_1(low: int, high: int, t: int, d: int):
    while low < high:
        mid = (low + high) // 2
        if solve(t, d, mid):
            high = mid
        else:
            low = mid + 1
    return low

def binary_search_2(low: int, high: int, t: int, d: int):
    while low < high:
        mid = (low + high) // 2
        if not solve(t, d, mid):
            high = mid
        else:
            low = mid + 1
    return low - 1


with open('inp_test') as f:
    test_lines = f.readlines()
with open('inp') as f:
    lines = f.readlines()
# lines = test_lines

"""
times = list(map(int, lines[0].split(':')[1].split()))
distances = list(map(int, lines[1].split(':')[1].split()))
print(times)
print(distances)

rr = 1
for t, d in zip(times, distances):
    res = 0
    for i in range(t):
        speed = i
        leftover = t - i
        distance = speed * leftover
        if distance > d:
            print(f"{(t, d)} {i} works")
            print(distance)
            res += 1
    rr *= res
print(rr)
"""

time = int(''.join(lines[0].split(':')[1].split()))
dist = int(''.join(lines[1].split(':')[1].split()))
print(time)
print(dist)

# print(solve(time, dist, time // 2))
res1 = binary_search_1(0, time // 2, time, dist)
res2 = binary_search_2(time // 2, time, time, dist)
print(res2 - res1 + 1)
