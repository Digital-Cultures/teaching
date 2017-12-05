import serial # if you have not already done so
# from serial.tools import list_ports
# print list(list_ports.comports())
import time

ser = serial.Serial('/dev/cu.usbmodem1421', 9600)

ser.write('hi ms arduino\n')

# time.sleep(2)
# ser.write('5\n')

# while True:
# 	print ser.readline()

# waiting = True
# while waiting:
# 	print ser.readline()
# 	waiting = False

# ser.write('5')