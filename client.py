import socket
from _thread import *

def send_input(s):
    while True:
        data = input()
        s.sendall(data.encode())
    

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.connect(('127.0.0.1', 8080))

    name = input('Enter your name: ')
    s.sendall(name.encode())
    
    print('awaiting server...')
    
    response = s.recv(1024)
    while response.decode() != 'CONNECTED':
        response = s.recv(1024)
    
    print('Connected!')
    
    start_new_thread(send_input, (s,))
    
    while True:
        rawdata = s.recv(1024)
        rawdata = rawdata.decode()
        
        data = dict((x.strip(), y.strip())
        for x,y in (element.split('=')
        for element in rawdata.split('; ')))
        
        if data['NAME'] == 'SERVER':
            if data['DATA'] == 'KILL': break
            msg = '\u001b[31mSERVER: \u001b[0m' + data['DATA']
            
            print(msg)
        else:
            msg = '\u001b[32m' + data['NAME'] + ': \u001b[0m' + data['DATA']

            print(msg)
