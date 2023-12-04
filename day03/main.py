with open('inp_test') as f:
    test_lines = f.readlines()
with open('inp') as f:
    lines = f.readlines()
# lines = test_lines
grid = list(map(lambda x: x.strip(), lines))

n = len(grid)
m = len(grid[0])

gears = [[[] for __ in range(m)] for _ in range(n)]

def get_num(i: int, j: int):
    if grid[i][j] == '.':
        return 0
    num = 0
    numStr = ""
    poses = []
    if j > 0 and grid[i][j - 1].isdigit():
        return 0
    while j < m and grid[i][j].isdigit():
        numStr += grid[i][j]
        poses.append((i, j))
        j += 1
    if len(numStr) == 0:
        return 0
    num = int(numStr)
    res = False
    visited = set()
    for i, j in poses:
        for x, y in ((-1, 0), (0, -1), (1, 0), (0, 1), (-1, -1), (-1, 1), (1, -1), (1, 1)):
            if 0 <= i + x < n and 0 <= j + y < m:
                val = grid[i + x][j + y]
                if val != "." and not val.isdigit():
                    res = True
                if val == "*" and (i + x, j + y) not in visited:
                    gears[i + x][j + y].append(num)
                    visited.add((i + x, j + y))
    if res:
        return num
    else:
        return 0

res = 0
for i in range(n):
    for j in range(m):
        # print((i, j))
        # print(m)
        get_num(i, j)
        pass
print(gears)
for i in range(n):
    for j in range(m):
        gear = gears[i][j]
        if len(gear) == 2:
            print(gear)
            res += (gear[0] * gear[1])
print(res)
# print(res)
