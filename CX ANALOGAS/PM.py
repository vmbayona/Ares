import numpy as np
import matplotlib.pyplot as plt

# Parámetros de la señal
amplitud_moduladora = 1.0
frecuencia_moduladora = 2.0
fase_moduladora = 0.0  # Fase inicial de la señal moduladora
frecuencia_portadora = 20.0
tiempo_total = 1.0
tasa_muestreo = 1000.0

# Generar la señal moduladora y la señal portadora
t = np.linspace(0, tiempo_total, int(tiempo_total * tasa_muestreo), endpoint=False)
moduladora = amplitud_moduladora * np.sin(2 * np.pi * frecuencia_moduladora * t + fase_moduladora)
portadora = np.sin(2 * np.pi * frecuencia_portadora * t)

# Realizar la modulación PM
indice_modulación = 0.5  # Índice de modulación
señal_pm = np.sin(2 * np.pi * frecuencia_portadora * t + indice_modulación * moduladora)

# Demodulación PM
señal_demodulada = np.gradient(señal_pm) / (2 * np.pi * frecuencia_portadora * t)

# Graficar las señales
plt.figure(figsize=(12, 6))

plt.subplot(3, 1, 1)
plt.plot(t, moduladora)
plt.title('Señal Moduladora')

plt.subplot(3, 1, 2)
plt.plot(t, portadora)
plt.title('Señal Portadora')

plt.subplot(3, 1, 3)
plt.plot(t, señal_demodulada)
plt.title('Señal Demodulada PM')

plt.tight_layout()
plt.show()
