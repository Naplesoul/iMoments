from PIL import Image
import os,shutil,sys
def compressImage(srcFile,dstFile):
    if os.path.isfile(srcFile):
        try:
            sImg=Image.open(srcFile)
            w,h=sImg.size
            dImg=sImg.resize((int(w/3),int(h/3)),Image.ANTIALIAS)  #设置压缩尺寸和选项，注意尺寸要用括号
            dImg.save(dstFile) #也可以用srcFile原路径保存,或者更改后缀保存，save这个函数后面可以加压缩编码选项JPEG之类的
            print (dstFile)
        except Exception:
            print(dstFile)

if __name__ == "__main__":
    compressImage(sys.argv[1], sys.argv[2])
