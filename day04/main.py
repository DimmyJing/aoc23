with open('inp_test') as f:
    test_lines = f.readlines()
with open('inp') as f:
    lines = f.readlines()
# lines = test_lines

lines = [line.strip() for line in lines]
res = 0
copies = [1] * len(lines)
for idx, line in enumerate(lines):
    card = line.split(":")[1]
    one = card.split('|')[0]
    two = card.split('|')[1]
    one = list(map(int, one.split()))
    two = list(map(int, two.split()))
    thing = len(set(two).intersection(set(one)))
    for i in range(thing):
        copies[idx + i + 1] += copies[idx]
    # res += (int(2 ** (len(set(two).intersection(set(one))) - 1)))
print(sum(copies))
# print(res)
