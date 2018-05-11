
def keyAddition(state, key):
    Nb = len(state)
    new_state = [[None for j in range(4)] for i in range(4)]

    for i, word in enumerate(state):
        for j, byte in enumerate(word):
            new_state[i][j] = byte ^ key[i][j]

    return new_state

if __name__ == '__main__':
    w,h = 4,4
    Matrix = [[0 for x in range(w)] for y in range(h)]
    #Column 1
    Matrix[0][0]=0
    Matrix[0][1]=1
    Matrix[0][2]=2
    Matrix[0][3]=3
    #Column 2
    Matrix[1][0]=4
    Matrix[1][1]=5
    Matrix[1][2]=6
    Matrix[1][3]=7
    #COlumn 3
    Matrix[2][0]=8
    Matrix[2][1]=9
    Matrix[2][2]=10
    Matrix[2][3]=11
    #Column 4
    Matrix[3][0]=12
    Matrix[3][1]=13
    Matrix[3][2]=14
    Matrix[3][3]=15

    w,h = 4,4
    key = [[0 for x in range(w)] for y in range(h)]
    #Column 1
    key[0][0]=0
    key[0][1]=1
    key[0][2]=0
    key[0][3]=1
    #Column 2
    key[1][0]=0
    key[1][1]=1
    key[1][2]=0
    key[1][3]=1
    #COlumn 3
    key[2][0]=0
    key[2][1]=1
    key[2][2]=0
    key[2][3]=1
    #Column 4
    key[3][0]=0
    key[3][1]=1
    key[3][2]=0
    key[3][3]=1

print(Matrix)
print(keyAddition(Matrix,key))

