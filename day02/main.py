with open("inp") as f:
    lines = f.readlines()
res = 0
"""
for idx, line in enumerate(lines):
    line = line.split(":")[1]
    rounds = line.split(';')
    good = True
    for round in rounds:
        colors = round.split(',')
        for color in colors:
            amount = int(color.strip().split()[0])
            if 'red' in color:
                if amount > 12:
                    good = False
            if 'green' in color:
                if amount > 13:
                    good = False
            if 'blue' in color:
                if amount > 14:
                    good = False
    if good:
        res += idx + 1
"""
for idx, line in enumerate(lines):
    line = line.split(":")[1]
    rounds = line.split(';')
    minRed = 0
    minBlue = 0
    minGreen = 0
    for round in rounds:
        colors = round.split(',')
        for color in colors:
            amount = int(color.strip().split()[0])
            if 'red' in color:
                minRed = max(minRed, amount)
            if 'green' in color:
                minGreen = max(minGreen, amount)
            if 'blue' in color:
                minBlue = max(minBlue, amount)
    res += minRed * minGreen * minBlue
print(res)
