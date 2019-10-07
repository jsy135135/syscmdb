from django.db import models
from django.contrib.auth.models import User


# Create your models here.
class Profile(models.Model):
    name_cn = models.CharField(max_length=32, verbose_name='中文名称')
    phone = models.CharField(max_length=11, verbose_name='电话号码')
    wechat = models.CharField(max_length=32, verbose_name='微信号')
    info = models.TextField()
    profile = models.OneToOneField(User)
    class Meta:
        default_permissions = []
        permissions = (
            ('show_user','查看用户'),
            ('add_user','添加用户'),
            ('update_user','修改用户'),
            ('delete_user','删除用户')
        )