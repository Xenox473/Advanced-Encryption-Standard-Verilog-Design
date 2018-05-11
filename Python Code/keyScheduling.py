import binascii
import uuid
from g import g

def keyScheduling(keyword, roundNum):
    input = binascii.unhexlify(keyword)

    W0 = int.from_bytes(input[0:4], byteorder='big')
    W1 = int.from_bytes(input[4:8], byteorder='big')
    W2 = int.from_bytes(input[8:12], byteorder='big')
    W3 = input[12:16]

    G1 = g(W3, roundNum)
    W3 = int.from_bytes(W3, byteorder='big')

    X0 = int(G1,16) ^ W0
    X1 = X0 ^ W1
    X2 = X1 ^ W2
    X3 = X2 ^ W3
    outputWord = [X0,X1,X2,X3]
    #h = [hex(X0),"0x{:08x}".format(X1),hex(X2),hex(X3)]
    #print(h)
    subkey = "".join("{:08x}".format(x) for x in outputWord)
    subkey = subkey.replace("0x","")

    return subkey

def generateKeys(key): #key should be hex string
    subkeys = []
    subkey = keyScheduling(key, 1)
    subkeys.append(subkey)
    #print(subkey1)
    for i in range(9):
        key2 = subkey
        subkey = keyScheduling(key2, i+2)
        subkeys.append(subkey)
        #print(i)
        #print(subkey)
    for s in range(len(subkeys)):
        subkeys[s] = "128'h" + subkeys[s]
    out_str = '{' + ",\n ".join(subkeys) + '};'
    return out_str
if __name__ == "__main__":
    # key = b'\xb5\xa4\xc0\xbe\x8d\xc1\xbb\xc4\xdc\x8d\xc1\xbb\xc4\xdc\x8d\xc1'
    key = '000102030405060708090a0b0c0d0e0f'
    str = generateKeys(key)
    print(str)
