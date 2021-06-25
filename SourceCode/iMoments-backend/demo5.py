import socket

s = socket.socket()
conn = s.connect(("59.78.8.30", 50010))

s.send(input().encode('utf-8'))
print(s.recv(1024).decode('utf-8'))
