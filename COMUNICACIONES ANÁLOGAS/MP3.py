import numpy as np
import matplotlib.pyplot as plt

n = 7

x_rect = np.array([-1, -0.5, -0.5, 0.5, 0.5, 1])
y_rect = np.array([0, 0, 1, 1, 0, 0])

plt.figure()

# Graficar el pulso rectangular
plt.plot(x_rect, y_rect, 'b', linewidth=1.5)

x = np.linspace(-1, 1, 100)
y = np.zeros(len(x))

for i in range(len(x)):
    y[i] = 1/2
    for k in range(1, 2*n+1, 2):
        y[i] += ((-1)**((k-1)//2)) * 2 * np.cos(k * np.pi * x[i]) / (k * np.pi)

# Graficar la aproximación de Fourier
plt.plot(x, y, 'r')

plt.title(f'Aproximación de Fourier: {n} términos')
plt.xlabel('t')
plt.ylabel('f(t)')
plt.grid(True)

plt.show()

