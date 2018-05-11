def mix_columns(state, inv=False):
    for i in range(4):

        # if inv == False:  # encryption
        s0 = mul_by_02(state[0][i]) ^ mul_by_03(state[1][i]) ^ state[2][i] ^ state[3][i]
        s1 = state[0][i] ^ mul_by_02(state[1][i]) ^ mul_by_03(state[2][i]) ^ state[3][i]
        s2 = state[0][i] ^ state[1][i] ^ mul_by_02(state[2][i]) ^ mul_by_03(state[3][i])
        s3 = mul_by_03(state[0][i]) ^ state[1][i] ^ state[2][i] ^ mul_by_02(state[3][i])
        # else:  # decryption
        #     s0 = mul_by_0e(state[0][i]) ^ mul_by_0b(state[1][i]) ^ mul_by_0d(state[2][i]) ^ mul_by_09(state[3][i])
        #     s1 = mul_by_09(state[0][i]) ^ mul_by_0e(state[1][i]) ^ mul_by_0b(state[2][i]) ^ mul_by_0d(state[3][i])
        #     s2 = mul_by_0d(state[0][i]) ^ mul_by_09(state[1][i]) ^ mul_by_0e(state[2][i]) ^ mul_by_0b(state[3][i])
        #     s3 = mul_by_0b(state[0][i]) ^ mul_by_0d(state[1][i]) ^ mul_by_09(state[2][i]) ^ mul_by_0e(state[3][i])

        state[0][i] = s0
        state[1][i] = s1
        state[2][i] = s2
        state[3][i] = s3

    return state

def mul_by_02(x):
    return 0x02*x
def mul_by_03(x):
    return 0x03*x

if __name__ == "__main__":
    print("AHA")
    mix_columns('0x25252525252525252525252525252525',32)
    result = mix_columns([[0x27,0x27,0x29,0x32],[0x10,0x10,0x10,0x34],[0x11,0x11,0x11,0x11],[0x43,0x11,0x31,0x12]],False)
    print (''.join('{:02x}'.format(x) for x in result))
    result = mix_columns([[0x25,0x25,0x25,0x25],[0x25,0x25,0x25,0x25],[0x25,0x25,0x25,0x25],[0x25,0x25,0x25,0x25]],False)
    print (''.join('{:02x}'.format(x) for x in result))