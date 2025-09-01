#!/usr/bin/env python3

import os
os.environ['TERM'] = 'linux'

from pwn import *

io = process(['python3','ssss.py'])
#io = remote('ctfi.ng',31555)

io.recvline()
p = 2**255 - 19
k = 15
R.<x0> = GF(p)[]


def query():
    io.sendline(str(k).encode())
    g = 2
    while pow(g,(p-1)//k,p) == 1:
        g+=1    
    g = pow(g,(p-1)//k,p)
    
    #assert pow(g,k,p) == 1
    
    shares = []
    for i in range(k-1):
        log.info(f'{i = }')
        x = pow(g,i,p)
        io.sendline(str(x).encode())
        y = int(io.recvline())
        shares.append((x,y))
        
    return list(R.lagrange_polynomial(shares))

A = query()
log.info(f'{A = }')
io.interactive()

# B = query()

# for secret in A:
#     if secret in B:
#         io.sendline(str(secret).encode())
#         log.info(f'{io.recvline().decode().rstrip() = }')