from django.shortcuts import render, HttpResponse
from django.views.generic import TemplateView, ListView, View
from django.contrib.auth.models import User, Group, Permission
from django.http.response import JsonResponse
from users.models import *
from django.contrib.auth.hashers import make_password
from django.utils.decorators import method_decorator
from django.contrib.auth.decorators import login_required, permission_required
from faker import Faker


# Create your views here.
# class UserListView(TemplateView):
# template_name = 'user_list.html'
#
# def get_context_data(self, **kwargs):
#     context = super(UserListView, self).get_context_data()
#     context['userlist'] = User.objects.all()
#     return context
# 添加用户测试数据
class TestDataView(View):
    def get(self, request):
        # 循环添加
        for i in range(1, 100):
            # 初始化 faker
            faker = Faker(locale='zh_CN')
            user = User()
            profile = Profile()
            # 添加用户表信息
            username = faker.user_name()
            try:
                User.objects.get(username=username)
            except Exception as e:
                username = faker.user_name()
            user.username = username
            user.password = make_password('123456')
            user.email = faker.email()
            user.save()
            # 添加用户扩展信息
            profile.name_cn = faker.name()
            profile.wechat = faker.phone_number()
            profile.phone = faker.phone_number()
            profile.info = faker.paragraph()
            profile.profile_id = user.id
            profile.save()
        return HttpResponse('测试数据添加')


# class UserListView(ListView):
#     template_name = 'user_list.html'
#     model = User
#     paginate_by = 7
#
#     # def get_context_data(self, **kwargs):
#     #     context = super().get_context_data()
#     # 第一页
#     # context['object_list'] = User.objects.all()[0:8]
#     # 第二页
#     # context['object_list'] = User.objects.all()[8:16]
#     # 第三页
#     # context['object_list'] = User.objects.all()[16:24]
#     # 第5页  取几条是定数
#     #     page = int(self.request.GET.get('page'))
#     #     end = page * 8
#     #     start = end-8
#     #     context['object_list'] = User.objects.all()[start:end]
#     #     return context
#     # 重写返回分页范围
#     def get_context_data(self, **kwargs):
#         context = super(UserListView, self).get_context_data()
#         context['page_range'] = self.page_range(context['page_obj'],context['paginator'])
#         # print(context)
#         return context
#
#     # 确定返回分页范围
#     def page_range(self, page_obj,paginator):
#         # 计算开始和结束页
#         # 当前在第几页
#         current_index = page_obj.number
#         start_page = current_index - 2
#         end_page = current_index + 3
#         # 处理不合法的范围
#         # start 小于1
#         if start_page < 1:
#             start_page = 1
#         # end 不能大过最大页面
#         if end_page > paginator.num_pages:
#             end_page = paginator.num_pages+1
#         return range(start_page, end_page)

class UserListView(ListView):
    template_name = 'user_list.html'
    model = User
    paginate_by = 7
    ordering = 'id'

    # @method_decorator(login_required())
    # def get(self,request):
    #     return render(request,'user_list.html')
    def get_context_data(self, **kwargs):
        context = super(UserListView, self).get_context_data(**kwargs)
        context['page_range'] = self.page_range(context['paginator'])
        return context

    def page_range(self, paginator):
        # 接收当前URL里的page参数
        if self.request.GET.get('page') == None:
            page = 1
        else:
            page = self.request.GET.get('page')
        current_index = int(page)
        page_range = 11
        start = current_index - 5
        end = current_index + 6
        # 计算取出几页
        current_pages_num = end - start
        # 计算差几页
        add_pages_num = page_range - current_pages_num
        # 如果end是最大页数 取完了 后面也没有
        if end == paginator.num_pages + 1:
            start = start - add_pages_num
        else:
            # 如果取出页面不够5页  后面还有页面可取 就补齐
            if current_pages_num < page_range:
                end = end + add_pages_num
        # 最小start 从1
        if start < 1:
            start = 1
        # 最大就等于总页数
        if end > paginator.num_pages:
            end = paginator.num_pages + 1
        print(start)
        print(end)
        return range(start, end)


class UserAddView(TemplateView):
    template_name = 'user_add.html'

    @method_decorator(login_required())
    @method_decorator(permission_required('user.user_add'))
    def get(self, request):
        return render(request, 'user_add.html')

    def post(self, request):
        # print(request.POST)
        # 接收用户信息并添加到数据库
        data = request.POST
        res = {'status': 0, 'msg': '添加用户成功'}
        try:
            user = User()
            user.username = data.get('username')
            user.password = make_password(data.get('password'))
            user.email = data.get('email')
            user.save()
            profile = Profile()
            profile.profile_id = user.id
            profile.name_cn = data.get('name_cn')
            profile.wechat = data.get('wechat')
            profile.phone = data.get('phone')
            profile.save()
        except Exception as e:
            print(e)
            res = {'status': 1, 'msg': '添加用户失败'}
        return JsonResponse(res)


class UserUpdateView(View):
    def get(self, request):
        user_obj = User.objects.get(id=request.GET.get('id'))
        return render(request, 'user_update.html', locals())

    def post(self, request):
        # print(request.POST)
        # 接收用户信息并添加到数据库
        data = request.POST
        res = {'status': 0, 'msg': '更新用户成功'}
        try:
            # 更新需要查到用户 在修改对象属性
            user = User.objects.get(id=request.POST.get('id'))
            user.username = data.get('username')
            user.password = make_password(data.get('password'))
            user.email = data.get('email')
            user.save()
            profile = Profile.objects.get(profile=user.id)
            profile.profile_id = user.id
            profile.name_cn = data.get('name_cn')
            profile.wechat = data.get('wechat')
            profile.phone = data.get('phone')
            profile.save()
        except Exception as e:
            print(e)
            res = {'status': 1, 'msg': '更新用户失败'}
        return JsonResponse(res)


class UserDeleteView(View):
    def get(self, request):
        res = {'status': 0, 'msg': '删除成功'}
        try:
            User.objects.filter(id=request.GET.get('id')).delete()
        except Exception as e:
            print(e)
            res = {'status': 1, 'msg': '删除失败'}
        return JsonResponse(res)


class UserStatusView(View):
    def get(self, request):
        res = {'status': 0, 'msg': '用户状态更新成功'}
        # 更新用户状态
        # 根据用户当前状态 确定修改为什么状态
        user = User.objects.get(id=request.GET.get('id'))
        current_status = user.is_active
        # 当前为启用
        if current_status == 1:
            # 修改为禁用
            new_status = 0
            res['msg'] = '{}用户禁用'.format(user.username)
        else:
            # 当前为禁用 修改启用
            new_status = 1
            res['msg'] = '{}用户启用'.format(user.username)
        try:
            user.is_active = new_status
            user.save()
        except Exception as e:
            print(e)
            res['status'] = 1
        return JsonResponse(res)


class GroupListView(ListView):
    template_name = 'group_list.html'
    model = Group


class GroupAddView(ListView):
    template_name = 'group_add.html'
    model = User

    def post(self, request):
        data = request.POST
        res = {'status': 0, 'msg': '添加用户组成功'}
        # 用户组
        try:
            group = Group()
            group.name = data.get('name')
            group.save()
            # many to many 用户和用户组的关系
            group_user = data.getlist('group_user')
            # print(group_user)
            # 用户和用户组的关系  需要一个一个添加
            for one in group_user:
                group.user_set.add(User.objects.get(id=one))
        except Exception as e:
            print(e)
            res = {'status': 1, 'msg': '添加用户组失败'}
        return JsonResponse(res)


class GroupUpdateView(TemplateView):
    template_name = 'group_update.html'

    def get_context_data(self, **kwargs):
        context = super(GroupUpdateView, self).get_context_data()
        context['group_obj'] = Group.objects.get(id=self.request.GET.get('id'))
        context['user_list'] = User.objects.all()
        return context

    def post(self, request):
        data = request.POST
        res = {'status': 0, 'msg': '更新用户组成功'}
        # 用户组
        try:
            group = Group.objects.get(id=data.get('id'))
            group.name = data.get('name')
            group.save()
            # many to many 用户和用户组的关系
            group_user = data.getlist('group_user')
            # print(group_user)
            # 用户和用户组的关系  需要一个一个添加
            # 先清空再添加
            group.user_set.clear()
            for one in group_user:
                # group.user_set.update(User.objects.get(id=one))
                group.user_set.add(User.objects.get(id=one))
        except Exception as e:
            print(e)
            res = {'status': 1, 'msg': '更新用户组失败'}
        return JsonResponse(res)


class GroupDeleteView(View):
    def get(self, request):
        res = {'status': 0, 'msg': '删除成功'}
        # 判断如果用户组下有用户 就不能够删除用户组
        group = Group.objects.get(id=request.GET.get('id'))
        if group.user_set.all():
            res = {'status': 1, 'msg': '用户组下有用户,无法删除,请先删除用户'}
            return JsonResponse(res)
        try:
            group.delete()
        except Exception as e:
            print(e)
            res = {'status': 1, 'msg': '删除失败'}
        return JsonResponse(res)


class PermListView(ListView):
    template_name = 'perm_list.html'
    model = Permission

    def get_queryset(self):
        queryset = super(PermListView, self).get_queryset()
        queryset = queryset.exclude(name__regex='[a-zA-Z]')
        return queryset


class UserSetPermView(ListView):
    template_name = 'user_set_perm.html'
    model = Permission

    def get_context_data(self, **kwargs):
        context = super(UserSetPermView, self).get_context_data()
        # 当前用户是哪个
        context['user_obj'] = User.objects.get(id=self.request.GET.get('id'))
        print(context)
        return context

    def get_queryset(self):
        queryset = super(UserSetPermView, self).get_queryset()
        queryset = queryset.exclude(name__regex='[a-zA-Z]')
        return queryset

    def post(self, request):
        # print(request.POST)
        res = {'status': 0, 'msg': '更新用户权限成功'}
        try:
            # 获取用户id  获取用户对象
            user = User.objects.get(id=request.POST.get('id'))
            # 获取用户权限的id
            # 添加用户和用户权限的关系
            user.user_permissions = request.POST.getlist('perm_list[]')
            user.save()
        except Exception as e:
            print(e)
            res = {'status': 1, 'msg': '更新用户权限失败'}
        return JsonResponse(res)
