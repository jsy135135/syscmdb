# syscmdb
管理主机和信息收集
## 安装配置
### 1、获取项目
```git
git clone git@github.com:jsy135135/syscmdb.git
```
### 2、测试数据配置
**导入配置**
```mysql
CREATE DATABASE syscmdb DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
use syscmdb
source syscmdb/syscmdb.sql
```
**修改项目目录下syscmdb/syscmdb/settings.py**
```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'syscmdb',
        'USER': 'root',
        'PASSWORD': '123456',
        'HOST': '127.0.0.1',
        'PORT': '3306',
    }
}
```
### 3、环境依赖
```shell
cd syscmdb
pip3 install -r requirements.txt
```
### 4、启动项目
```shell
cd syscmdb
python3 manage.py runserver
```
### 5、访问页面
http://127.0.0.1:8000

Tip:
>①此项目仅作为测试和学习使用
>
>②项目基于**django==1.11.18**开发,使用习惯和位置错误请参照django
>
>③需要后台启动,可以参考django项目对于Nginx和uwsgi的使用
>
>④也许后期必要的时候,会写一个安装部署和管理脚本
