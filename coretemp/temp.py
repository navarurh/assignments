import os
x = os.popen('sensors').read()
print(x)
x.search('coretemp')
