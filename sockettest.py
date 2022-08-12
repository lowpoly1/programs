import socket
from _thread import *

def client_thread(conn, addr):
    with conn:
        print('Connected by', addr, ', awaiting name...')
        name = conn.recv(1024)
        msg = 'DATA = ' + name.decode() + ' connected, now ' + str(len(conns)) + ' users; NAME = SERVER' 
        for i in conns:
            i.sendall(msg.encode())
        conn.sendall(b'CONNECTED')
        while True:
            data = conn.recv(1024)
            if not data: break
            if data.decode() == "exit": break
            msg = 'NAME = ' + name.decode() + '; DATA = ' + data.decode()
            for i in conns:
                if i == conn:
                    continue
                i.sendall(msg.encode())

        conn.sendall(b'NAME=SERVER; DATA=KILL')
        try:
            conns.remove(conn)
            print(conn, 'disconnected')
            msg = 'DATA = ' + name.decode() + ' disconnected, ' + str(len(conns)) + ' users remain; NAME = SERVER'
            for i in conns:
                i.sendall(msg.encode())
        except ValueError:
            print('Tried to remove connection from list, but was not found!')
            

conns = []

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind(('', 8080))
    s.listen()
    while True:
        print('listening')
        conn, addr = s.accept()
        print('accepted')
        conns.append(conn)
        start_new_thread(client_thread, (conn, addr))
