from copy import copy


def galoisMult(a, b):
    p = 0
    hiBitSet = 0
    for i in range(8):
        if b & 1 == 1:
            p ^= a
        hiBitSet = a & 0x80
        a <<= 1
        if hiBitSet == 0x80:
            a ^= 0x1b
        b >>= 1
    return p % 256


def mixColumn(column, encrypt):
    if encrypt == 1:
        temp = copy(column)
        column[0] = galoisMult(temp[0],2) ^ galoisMult(temp[3],1) ^ galoisMult(temp[2],1) ^ galoisMult(temp[1],3)
        column[1] = galoisMult(temp[1],2) ^ galoisMult(temp[0],1) ^ galoisMult(temp[3],1) ^ galoisMult(temp[2],3)
        column[2] = galoisMult(temp[2],2) ^ galoisMult(temp[1],1) ^ galoisMult(temp[0],1) ^ galoisMult(temp[3],3)
        column[3] = galoisMult(temp[3],2) ^ galoisMult(temp[2],1) ^ galoisMult(temp[1],1) ^ galoisMult(temp[0],3)
    else:
        temp = copy(column)
        column[0] = galoisMult(temp[0], 14) ^ galoisMult(temp[3], 9) ^ galoisMult(temp[2], 13) ^ galoisMult(temp[1], 11)
        column[1] = galoisMult(temp[1], 14) ^ galoisMult(temp[0], 9) ^ galoisMult(temp[3], 13) ^ galoisMult(temp[2], 11)
        column[2] = galoisMult(temp[2], 14) ^ galoisMult(temp[1], 9) ^ galoisMult(temp[0], 13) ^ galoisMult(temp[3], 11)
        column[3] = galoisMult(temp[3], 14) ^ galoisMult(temp[2], 9) ^ galoisMult(temp[1], 13) ^ galoisMult(temp[0], 11)


if __name__ == "__main__":
 
    #TEST CASE 6
    first = [0x25, 0x25, 0x25, 0x25]
    second = [0x25, 0x25, 0x25, 0x25]
    third = [0x25, 0x25, 0x25, 0x25]
    fourth = [0x25, 0x25, 0x25, 0x25]
    mixColumn(first, 0)
    mixColumn(second, 0)
    mixColumn(third, 0)
    mixColumn(fourth, 0)
    print("\n\nTEST CASE 6")
    for i in first:
        print(hex(i), end=" ")
    print("\n")
    for i in second:
        print(hex(i), end=" ")
    print("\n")
    for i in third:
        print(hex(i), end=" ")
    print("\n")
    for i in fourth:
        print(hex(i), end=" ")