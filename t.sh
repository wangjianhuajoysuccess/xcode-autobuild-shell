#此处可以用来获取你录入的信息写入到文件，然后你的程序就可以根据事先约定好的录入信息来实现不同的方法（例如程序判断此处的问价内容，来实现请求不同的IP地址）

#写入内容文件的地址
ipchangeFilePath=/Users/wangjianhua/Desktop/user_pages


echo "请输入目标ip代号"
read a
echo "你输入的ip代号为：$a"
cd $ipchangeFilePath
echo $a > file1
