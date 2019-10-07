import paramiko
# sftp上传检测客户端
def sftp_upload_file(host, user, password, server_path, local_path):
    ret = {'status': 0}
    try:
        t = paramiko.Transport((host, 22))
        t.connect(username=user, password=password)
        sftp = paramiko.SFTPClient.from_transport(t)
        sftp.put(local_path, server_path)
        t.close()
    except Exception as e:
        ret['status'] = 1
        ret['msg'] = '连接不成功，上传失败 %s' % e
    return ret


# ssh远程执行检测客户端命令
def sftp_exec_command(host, port, user, password, command):
    ret = {'status': 0}
    try:
        ssh_client = paramiko.SSHClient()
        ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh_client.connect(host, port, user, password)
        try:
            std_in, std_out, std_err = ssh_client.exec_command(command)
            ret['msg'] = std_out.read()
            ret['err'] = std_err.read().decode('utf8')
        except Exception as e:
            ret['status'] = 1
            ret['msg'] = '执行失败,执行失败 %s' % e
            ssh_client.close()
    except Exception as e:
        ret['status'] = 1
        ret['msg'] = '环境错误,执行失败 %s' % e
    return ret