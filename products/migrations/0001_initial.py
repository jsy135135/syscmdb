# -*- coding: utf-8 -*-
# Generated by Django 1.11.18 on 2019-09-27 19:49
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Product',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=32, verbose_name='业务线的名字')),
                ('name_cn', models.CharField(db_index=True, max_length=10, verbose_name='业务线字母简称')),
                ('op_interface', models.CharField(max_length=150, verbose_name='运维对接人')),
                ('dev_interface', models.CharField(max_length=150, verbose_name='业务对接人')),
            ],
            options={
                'permissions': (('add_product', '添加业务线'), ('delete_product', '删除业务线'), ('show_product', '查看业务线'), ('update_product', '修改业务线')),
                'default_permissions': [],
            },
        ),
    ]
