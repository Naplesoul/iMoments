import sys
from aip import AipNlp

def main(arg):
    """ 你的 APPID AK SK """
    APP_ID = '23738220'
    API_KEY = 'E0MDRQpKgrkvNtVl27ZUBHZC'
    SECRET_KEY = 'yxAg1c23N9X0HdrWdGgpzPbWPfIDlr7D'

    client = AipNlp(APP_ID, API_KEY, SECRET_KEY)

    def get_file_content(filePath):
        with open(filePath, 'rb') as fp:
            return fp.read()

    text = get_file_content(arg[0]).decode('utf-8')

    """ 调用通用物体识别 """
    print(client.sentimentClassify(text))

if __name__ == "__main__":
    main(sys.argv[1:])
