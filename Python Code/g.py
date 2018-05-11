import binascii
from sbox import sbox

def g(inputWord, roundNum):
    if type(inputWord) is str:
        input = binascii.unhexlify(inputWord)
    else:
        input = inputWord
    byte1 = input[1];
    byte2 = input[2];
    byte3 = input[3];
    byte4 = input[0];

    rcNum = [0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36]
    rc = rcNum[roundNum - 1]
    subByte1 = sbox(byte1)
    subByte2 = sbox(byte2)
    subByte3 = sbox(byte3)
    subByte4 = sbox(byte4)
    
    temp4 = int(subByte1, 16) ^ rc
    #print("{:02x}".format(temp4))
    temp3 = subByte2
    temp2 = subByte3
    temp1 = subByte4
    tempWord = ["{:02x}".format(temp4),temp3,temp2,temp1]
    #print(tempWord)
    g = "".join(tempWord)
    g = g.replace("0x","")
    return g

if __name__ == "__main__":
    #numG = g(b'\xc4\xdc\x8d\xc1', 1)
    numG = g(b'0469bf41', 4)

    print(numG)




