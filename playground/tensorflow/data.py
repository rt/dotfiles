with open("data.txt") as f:
    lis = [line.split() for line in f]
    for i,x in enumerate(lis):
        print("line{0} = {1}".format(i,x))
