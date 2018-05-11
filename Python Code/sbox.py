import re

def sbox(hex_input):
    out = []
    with open('sbox.txt', 'r') as file:
        lines = file.readlines()
        for l in lines:
            match = re.search(r"8'h(..);", l)
            num = match.group(1)
            out.append(num)
    return out[hex_input]



if __name__ =="__main__":
    print(sbox(0x36))

