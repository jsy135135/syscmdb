from django.db import models


# Create your models here.
# 业务线模型
class Product(models.Model):
    name = models.CharField("业务线的名字", max_length=32)
    name_cn = models.CharField("业务线字母简称", max_length=10, db_index=True)
    op_interface = models.CharField(max_length=150, verbose_name='运维对接人')
    dev_interface = models.CharField(max_length=150, verbose_name='业务对接人')

    def __str__(self):
        return self.name_cn

    class Meta:
        default_permissions = []
        permissions = (
            ('add_product', '添加业务线'),
            ('delete_product', '删除业务线'),
            ('show_product', '查看业务线'),
            ('update_product', '修改业务线'),
        )
