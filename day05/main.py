with open('inp_test') as f:
    test_lines = f.readlines()
with open('inp') as f:
    lines = f.readlines()
# lines = test_lines

"""
seeds = list(map(int, lines[0].split()[1:]))
print(seeds)
new_seeds = []

it = iter(lines)
next(it)
next(it)

def proc(it):
    things = []
    next(it)
    for line in it:
        if line == "\n":
            break
        things.append(list(map(int, line.split())))
    return things

for _ in range(7):
    new_seeds = []
    maps = proc(it)

    for seed in seeds:
        has = False
        for (dest, source, rang) in maps:
            if source <= seed < source + rang:
                new_seeds.append(dest + seed - source)
                has = True
                break
        if not has:
            new_seeds.append(seed)
    seeds = new_seeds
    print(seeds)
print(min(seeds))
"""


seeds = list(map(int, lines[0].split()[1:]))
act_seeds = []
for i in range(len(seeds) // 2):
    seeds_1 = seeds[i * 2]
    seeds_2 = seeds[i * 2 + 1]
    act_seeds.append((seeds_1, seeds_2))
seeds = act_seeds

new_seeds = []

it = iter(lines)
next(it)
next(it)

def proc(it):
    things = []
    next(it)
    for line in it:
        if line == "\n":
            break
        things.append(list(map(int, line.split())))
    return things

for _ in range(7):
    new_seeds = []
    maps = proc(it)

    for (seed_start, seed_len) in seeds:
        ranges = []
        for (dest, source, rang) in maps:
            if source <= seed_start < source + rang:
                new_len = min((source + rang) - seed_start, seed_len)
                ranges.append((seed_start, new_len))
                new_seeds.append((dest + seed_start - source, new_len))
            elif seed_start <= source < seed_start + seed_len:
                new_len = min(seed_start + seed_len - source, rang)
                ranges.append((source, new_len))
                new_seeds.append((dest, new_len))
        ranges.sort()
        old_seed_start = seed_start
        for r in ranges:
            if r[0] > seed_start:
                new_seeds.append((seed_start, r[0] - seed_start))
                seed_start = r[0] + r[1]
            else:
                seed_start += r[1]
        if seed_start < old_seed_start + seed_len:
            new_seeds.append((seed_start, old_seed_start + seed_len - seed_start))
    seeds = new_seeds
    print(seeds)
print(min(seeds))
