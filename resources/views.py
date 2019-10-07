from django.shortcuts import render
from django.views.generic import ListView, TemplateView, View, DetailView
from resources.models import *
from django.http.response import JsonResponse, HttpResponseRedirect
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
import json, os
from util.ssh import sftp_upload_file, sftp_exec_command


# ======================
# 临时方法  之后规划管理
def queryDictToDict(querydict):
    newdata = {}
    for k, v in querydict.items():
        if k != 'csrfmiddlewaretoken':
            newdata[k] = v
    return newdata


# =======================

# Create your views here.
class IdcListView(ListView):
    template_name = 'idc_list.html'
    model = Idc


class IdcAddView(TemplateView):
    template_name = 'idc_add.html'

    def post(self, request):
        res = {'status': 0, 'msg': '添加idc成功'}
        data = request.POST
        ###########start
        ####组合数据为dict 直接传入方法
        ####避免一个一个拼接的麻烦
        newdata = queryDictToDict(data)
        ############end
        try:
            Idc.objects.create(**newdata)
        except Exception as e:
            print(e)
            res = {'status': 1, 'msg': '添加idc失败'}
        return JsonResponse(res)


class IdcUpdateView(TemplateView):
    template_name = 'idc_update.html'

    def get_context_data(self, **kwargs):
        context = super(IdcUpdateView, self).get_context_data()
        context['idc_obj'] = Idc.objects.get(id=self.request.GET.get('id'))
        return context

    def post(self, request):
        res = {'status': 0, 'msg': '更新idc成功'}
        data = request.POST
        newdata = queryDictToDict(data)
        try:
            Idc.objects.filter(id=request.POST.get('id')).update(**newdata)
        except Exception as e:
            print(e)
            res = {'status': 1, 'msg': '更新idc失败'}
        return JsonResponse(res)


class IdcDeleteView(View):
    def post(self, request):
        res = {'status': 0, 'msg': '删除idc成功'}
        try:
            Idc.objects.get(id=request.POST.get('id')).delete()
        except Exception as e:
            print(e)
            res = {'status': 1, 'msg': '删除idc失败'}
        return JsonResponse(res)


class ServerUserListView(ListView):
    template_name = 'serveruser_list.html'
    model = ServerUser


class ServerUserAddView(TemplateView):
    template_name = 'serveruser_add.html'

    def post(self, request):
        res = {'status': 0, 'msg': '添加资产用户成功'}
        data = request.POST
        try:
            serveruser = ServerUser()
            serveruser.name = data.get('name')
            serveruser.username = data.get('username')
            serveruser.password = data.get('password')
            serveruser.info = data.get('info')
            serveruser.save()
        except Exception as e:
            print(e)
            res = {'status': 1, 'msg': '添加资产用户失败'}
        return JsonResponse(res)


class ServerUserUpdateView(View):
    def get(self, request):
        serveruser_obj = ServerUser.objects.get(id=request.GET.get('id'))
        return render(request, 'serveruser_update.html', locals())

    def post(self, request):
        res = {'status': 0, 'msg': '更新资产用户成功'}
        data = request.POST
        try:
            serveruser = ServerUser.objects.get(id=request.POST.get('id'))
            serveruser.name = data.get('name')
            serveruser.username = data.get('username')
            serveruser.password = data.get('password')
            serveruser.info = data.get('info')
            serveruser.save()
        except Exception as e:
            print(e)
            res = {'status': 1, 'msg': '更新资产用户失败'}
        return JsonResponse(res)


class ServerUserDeleteView(View):
    def post(self, request):
        serveruser = ServerUser.objects.get(id=request.POST.get('id'))
        res = {'status': 0, 'msg': '删除资产用户{}成功'.format(serveruser.username)}
        try:
            serveruser.delete()
        except Exception as e:
            print(e)
            res = {'status': 1, 'msg': '删除资产用户失败'}
        return JsonResponse(res)


class ServerListView(View):
    def get(self, request):
        object_list = Server.objects.all()
        os_list = ServerAuto.os_status_list
        system_list = ServerAuto.system_status_list
        systemuser_list = ServerUser.objects.all()
        return render(request, 'server_list.html', locals())


class ServerAddView(View):
    def post(self, request):
        data = request.POST
        # 1、存储到serverauto表
        try:
            ServerAuto.objects.get(ip_inner=data.get('ip_inner'))
            return JsonResponse({'status': 0, 'msg': '请勿重复添加'})
        except Exception as e:
            serverauto = ServerAuto()
            serverauto.ip_inner = data.get('ip_inner')
            serverauto.port = data.get('port')
            serverauto.os_status = data.get('os_status')
            serverauto.system_status = data.get('system_status')
            serverauto.save()
        # 2、上传文件
        serveruser = ServerUser.objects.get(id=data.get('serveruser_id'))
        BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        res = sftp_upload_file(serverauto.ip_inner, serveruser.username, serveruser.password, '/root/sysinfo.py',
                               os.path.join(BASE_DIR, 'util/sysinfo.py'))
        # 3、远程执行命令 触发主机信息接收API
        # 文件上传成功
        if res['status'] == 0:
            # 远程执行客户端采集数据
            res = sftp_exec_command(serverauto.ip_inner, serverauto.port, serveruser.username, serveruser.password,
                                    "bash -lc 'python3 /root/sysinfo.py {} {}'".format(serverauto.id, serveruser.id))
            print(res)
            if json.loads(res['msg'])['status'] == 0:
                # 远程执行成功 获取信息成功 添加主机成功
                res = {'status': 0, 'msg': '添加主机成功'}
            else:
                res = {'status': 1, 'msg': '添加主机失败'}
        return JsonResponse(res)


class ServerDataApiView(View):
    @method_decorator(csrf_exempt)
    def dispatch(self, request, *args, **kwargs):
        return super(ServerDataApiView, self).dispatch(request, *args, **kwargs)

    def post(self, request):
        data_dict = json.loads(request.body)
        # print(data_dict)
        # 添加数据
        # 主机基本信息
        res = {'status': 0, 'msg': 'success'}
        # 判断是否存在数据
        try:
            # 存在就修改
            server = Server.objects.get(uuid=data_dict['uuid'])
        except Exception as e:
            # print(e)
            # 不存在添加
            server = Server()
        try:
            server.hostname = data_dict['hostname']
            server.cpu_info = data_dict['cpu_info']
            server.cpu_count = data_dict['cpu_count']
            server.mem_info = data_dict['mem_info']
            server.os_system = data_dict['os_system']
            server.os_system_num = data_dict['os_system_num']
            server.uuid = data_dict['uuid']
            server.sn = data_dict['sn']
            server.scan_status = 1
            server.server_auto_id = data_dict['server_auto_id']
            server.server_user_id = data_dict['server_user_id']
            server.save()
            # 磁盘
            for k, v in data_dict['disk_info'].items():
                try:
                    disk = Disk.objects.get(server_id=server.id, name=k)
                except Exception as e:
                    print(e)
                    disk = Disk()
                disk.name = k
                disk.size = v
                disk.server = server
                disk.save()
            # 网卡
            for k, v in data_dict['ip_info'].items():
                try:
                    network = NetWork.objects.get(server_id=server.id, name=k)
                except Exception as e:
                    print(e)
                    network = NetWork()
                network.name = k
                network.ip_address = v
                network.server = server
                network.save()
        except Exception as e:
            print(e)
            res = {'status': 1, 'msg': e}
        return JsonResponse(res)


class ServerFlushView(View):
    def post(self, request):
        print(request.POST)
        server = Server.objects.get(id=request.POST.get('server_id'))
        serverauto = server.server_auto
        res = sftp_exec_command(serverauto.ip_inner, serverauto.port, server.server_user.username,
                                server.server_user.password,
                                "bash -lc 'python3 /root/sysinfo.py {} {}'".format(serverauto.id, server.server_user.id))
        # print(res)
        if json.loads(res['msg'])['status'] == 0:
            # 远程执行成功 获取信息成功 添加主机成功
            res = {'status': 0, 'msg': '刷新主机成功'}
        else:
            res = {'status': 1, 'msg': '刷新主机失败'}
        return JsonResponse(res)


class ServerDetailView(View):
    def get(self, request):
        server_obj = Server.objects.get(id=request.GET.get('id'))
        idc_list = Idc.objects.all()
        return render(request, 'server_detail.html', locals())


class ServerIdcView(View):
    def post(self, request):
        res = {'status': 0, 'msg': '设置成功'}
        try:
            Server.objects.filter(id=request.POST.get('server_id')).update(idc_id=request.POST.get('idc_id'))
        except Exception as e:
            print(e)
            res = {'status': 0, 'msg': '设置失败'}
        return JsonResponse(res)


class ServerDeleteView(View):
    def post(self, request):
        res = {'status': 0, 'msg': '删除主机成功'}
        try:
            server = Server.objects.get(id=request.POST.get('id'))
            server.delete()
            server.server_auto.delete()
        except Exception as e:
            print(e)
            res = {'status': 1, 'msg': '删除主机失败'}
        return JsonResponse(res)


class ServerWebSSHView(View):
    def get(self, request):
        object_list = Server.objects.all()
        os_list = ServerAuto.os_status_list
        system_list = ServerAuto.system_status_list
        systemuser_list = ServerUser.objects.all()
        return render(request, 'server_webssh.html', locals())

    def post(self, request):
        res = {'status': 0, 'msg': '进入终端'}
        return JsonResponse(res)


class WebSSHView(View):
    def get(self, request):
        server = Server.objects.get(id=request.GET.get('id'))
        import base64
        password = base64.b64encode(server.server_user.password.encode('utf-8'))
        password = str(password, 'utf-8')
        url = 'http://192.168.17.1:8888/?hostname={}&username={}&password={}'.format(server.server_auto.ip_inner, server.server_user.username, password)
        return render(request, 'webssh.html', locals())
