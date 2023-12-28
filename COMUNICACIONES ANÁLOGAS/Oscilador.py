import numpy as np
import matplotlib.pyplot as plt

# Parámetros del oscilador
frecuencia_oscilador = 100.0  # Frecuencia del oscilador en Hz
tiempo_total = 1.0
tasa_muestreo = 1000.0

# Generar una señal sinusoidal utilizando un oscilador
t = np.linspace(0, tiempo_total, int(tiempo_total * tasa_muestreo), endpoint=False)
señal_oscilador = np.sin(2 * np.pi * frecuencia_oscilador * t)

# Graficar la señal sinusoidal
plt.figure(figsize=(8, 4))
plt.plot(t, señal_oscilador)
plt.title('Señal Sinusoidal Generada por el Oscilador')
plt.xlabel('Tiempo (s)')
plt.ylabel('Amplitud')
plt.grid(True)
plt.show()
