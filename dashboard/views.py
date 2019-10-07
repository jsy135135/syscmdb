from django.shortcuts import render
from django.views.generic import View, TemplateView
from django.http import JsonResponse, HttpResponseRedirect
from django.contrib.auth import login, logout, authenticate
from django.contrib.auth.mixins import LoginRequiredMixin
from django.urls import reverse


# Create your views here.
class BaseView(View):
    def get(self, request):
        return render(request, 'base.html')


# class IndexView(View):
#     def get(self,request):
#         return render(request,'index.html',{'name':'linux'})

class IndexView(LoginRequiredMixin, TemplateView):
    template_name = 'index.html'

    def get_context_data(self, **kwargs):
        context = super(IndexView, self).get_context_data()
        context['name'] = 'Linux'
        return context


class LoginView(TemplateView):
    template_name = 'login.html'

    def post(self, request):
        username = request.POST.get('username')
        password = request.POST.get('password')
        # if username == 'admin' and password == '123456':
        # django 用户验证方法
        user = authenticate(request, username=username, password=password)
        if user:
            # 登录操作
            login(request, user)
            res = {'status': 0, 'msg': '登录成功'}
        else:
            res = {'status': 1, 'msg': '用户名称或者密码错误'}
        return JsonResponse(res)


class LogoutView(View):
    def get(self, request):
        logout(request)
        return HttpResponseRedirect(reverse('user_login'))


def not_fond(request):
    return render(request, '404.html')
