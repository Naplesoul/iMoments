import sys

import socket

s = socket.socket()

def main(arg):

    def get_file_content(filePath):
        with open(filePath, 'rb') as fp:
            return fp.read()

    conn = s.connect(("59.78.8.125", 50011))
    sim_res = ""

    s.send(('{"len":"'+"90"+'","raw":"'+get_file_content(arg[0]).decode()+'","n":"'+"1"+'"}').encode('utf-8'))
    poem = s.recv(1024).decode('utf-8')

    sim_res += poem + "。"

    print(sim_res)

if __name__ == "__main__":
    main(sys.argv[1:])
