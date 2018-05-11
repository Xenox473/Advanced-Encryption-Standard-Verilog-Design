def ShiftRows(state):
    Nb = len(state)
    n = [word[:] for word in state]

    for i in range(Nb):
        for j in range(4):
            n[i][j] = state[(i+j) % Nb][j]


    return n

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

    print(Matrix)

print(ShiftRows(Matrix))