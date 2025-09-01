import os
os.environ['TERM'] = 'linux'

p = 2**255 - 19
R.<x0> = GF(p)[]

shares = []
for i in range(3):
    shares.append((i, 10 + 2*i + i**2))
    
print(f"{list(R.lagrange_polynomial(shares)) = }")