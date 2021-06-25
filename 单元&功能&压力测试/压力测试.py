import socket
import time
import threading
import urllib
from urllib import request


def test2(n):
    start_time = time.time()
    for i in range(n):
        try:
            r = request.urlopen('http://59.78.8.125:50008/login')
        except urllib.error.HTTPError:
            pass
    t = time.time() - start_time
    print("{} seconds per req".format(t / n))


def start_test(n):
    start_time = time.time()
    for i in range(n):
        s = socket.socket()
        s.connect(("59.78.8.125", 500011))
        s.send(('{"len":"' + "60" + '","raw":"' + "今天天气真好" + '","n":"' + "1" + '"}').encode('utf-8'))
        s.close()
    t = time.time() - start_time
    print("{} seconds per req".format(t/n))


if __name__ == '__main__':
    trd1 = threading.Thread(target=test2, args=[100])
    trd1.start()
    trd1.join()
