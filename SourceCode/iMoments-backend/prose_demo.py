import sys,random
from aip import AipImageClassify


import socket

s = socket.socket()

def main(arg):
    """ 你的 APPID AK SK """
    APP_ID = '23521368'
    API_KEY = 'ZsU4yX9sebQmW06s7xc3oaaG'
    SECRET_KEY = '94OsjVY5GwbaD8QZRLqzRGQgWhwdWcTq'

    client = AipImageClassify(APP_ID, API_KEY, SECRET_KEY)


    def get_file_content(filePath):
        with open(filePath, 'rb') as fp:
            return fp.read()

    image = get_file_content(arg[0])

    """ 调用通用物体识别 """

    res = client.advancedGeneral(image)
    sim_res = "\nGeneral:\n"
    poem_keys = ""
    for i in range(len(res["result"])):
        sim_res += res["result"][i]["keyword"] + ' '
        if len(res["result"][i]["keyword"])>4:
                res["result"][i]["keyword"]=res["result"][i]["keyword"][:4]
        if i < 3:
            poem_keys += res["result"][i]["keyword"] + ' '
        if i == 3:
            poem_keys += res["result"][i]["keyword"]

    res = client.animalDetect(image)
    sim_res += "\nAnimal:\n"
    for i in range(len(res["result"])):
        sim_res += res["result"][i]["name"] + ' '

    res = client.plantDetect(image)
    sim_res += "\nPlant:\n"
    for i in range(len(res["result"])):
        sim_res += res["result"][i]["name"] + ' '

    res = client.dishDetect(image)
    sim_res += "\nDish:\n"
    for i in range(len(res["result"])):
        sim_res += res["result"][i]["name"] + ' '

    sim_res += "\nPoem:\n"
    conn = s.connect(("59.78.8.125", 50011))

    s.send(('{"len":"'+"60"+'","raw":"'+"今天天气真好"+'","n":"'+"1"+'"}').encode('utf-8'))
    poem = s.recv(1024).decode('utf-8')
    sim_res += poem

    print(sim_res)

if __name__ == "__main__":
    main(sys.argv[1:])
