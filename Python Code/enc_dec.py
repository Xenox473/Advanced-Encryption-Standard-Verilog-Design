from Crypto.Cipher import AES
import binascii
import os

# key=binascii.unhexlify('Input key here')
# encryptor=AES.new(key,AES.MODE_ECB)
# text = binascii.unhexlify('Input Data')
# #Encryptio and Decryption
# encrypted = encryptor.encrypt(text)
# decrypted = encryptor.decrypt(text)
# #Printing encrypted and decrypted
# print('ENCRYTED:  '+ str(binascii.hexlify(encrypted)))
# print('DECRYPTED: ' + str(binascii.hexlify(decrypted)))


#Test Case 1
key = binascii.unhexlify('000102030405060708090a0b0c0d0e0f')
text = binascii.unhexlify('69c4e0d86a7b0430d8cdb78070b4c55a')
encryptor=AES.new(key,AES.MODE_ECB)
decrypted = encryptor.decrypt(text)
print('DECRYPTED: ' + str(binascii.hexlify(decrypted)))
text = binascii.unhexlify('00112233445566778899aabbccddeeff')
encrypted = encryptor.encrypt(text)
print('ENCRYTED:  '+ str(binascii.hexlify(encrypted)))
key = binascii.unhexlify('00112233445566778899AABBCCDDEEFF')
text = binascii.unhexlify('aeaeaeaeaeaeaeaeaeaeaeaeaeaeaeae')
encryptor=AES.new(key,AES.MODE_ECB)
encrypted = encryptor.encrypt(text)
print('ENCRYTED:  '+ str(binascii.hexlify(encrypted)))
text = binascii.unhexlify('aeaeaeaeaeaeaeaeaeaeaeaeaeaeaeae')
decrypted = encryptor.decrypt(text)
print('DECRYPTED: ' + str(binascii.hexlify(decrypted)))
key = binascii.unhexlify('AABBCCDDEEFFAABBCCDDEEFFAABBCCDD')
text = binascii.unhexlify('00110022003300440055006600770088')
encryptor=AES.new(key,AES.MODE_ECB)
encrypted = encryptor.encrypt(text)
print('ENCRYTED:  '+ str(binascii.hexlify(encrypted)))
text = binascii.unhexlify('00110022003300440055006600770088')
decrypted = encryptor.decrypt(text)
print('DECRYPTED: ' + str(binascii.hexlify(decrypted)))
key = binascii.unhexlify('11111111111111111111111111111111')
text = binascii.unhexlify('00000000000000000000000000000000')
encryptor=AES.new(key,AES.MODE_ECB)
encrypted = encryptor.encrypt(text)
print('ENCRYTED:  '+ str(binascii.hexlify(encrypted)))
text = binascii.unhexlify('00000000000000000000000000000000')
decrypted = encryptor.decrypt(text)
print('DECRYPTED: ' + str(binascii.hexlify(decrypted)))