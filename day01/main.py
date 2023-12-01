nums = ['zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']

sum = 0
while True:
    thing = input()
    start = 0
    for idx, i in enumerate(thing):
        has = False
        for numIdx, num in enumerate(nums):
            if thing[idx:].startswith(num):
                start = numIdx
                has = True
                break
        if has:
            break
        if i.isnumeric():
            start = int(i)
            break
    end = 0
    for idx in range(len(thing) - 1, -1, -1):
        i = thing[idx]
        has = False
        for numIdx, num in enumerate(nums):
            if thing[idx:].startswith(num):
                end = numIdx
                has = True
                break
        if has:
            break
        if i.isnumeric():
            end = int(i)
            break
    print(start * 10 + end)
    sum += start * 10 + end
    print(sum)
