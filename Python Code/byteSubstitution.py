import binascii
from sbox import sbox

def byteSubstitution(inputByte):
	inputByte = binascii.unhexlify(inputByte)
	outputByte = []
	for i in range(0, len(inputByte)):
		# print(sbox(inputByte[i]))
		outputByte.append(sbox(inputByte[i]))
	# print(outputByte)
	outputByte = "".join(outputByte)
	# outputByte = binascii.unhexlify(outputByte)
	outputByte = outputByte.replace('0x', "")
	return outputByte



if __name__ == "__main__":
	print(byteSubstitution('7A7A7A7A7A7A7A7A7A7A7A7A7A7A7A7A'))
	print(byteSubstitution('AEAEAEAEAEAEAEAEAEAEAEAEAEAEAEAE'))
	print(byteSubstitution('88888888888888888888888888888888'))