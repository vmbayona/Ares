import numpy as np
import matplotlib.pyplot as plt

# Parámetros de la señal
amplitud_moduladora = 1.0  # Amplitud de la señal moduladora
frecuencia_moduladora = 2.0  # Frecuencia de la señal moduladora (Hz)
amplitud_portadora = 2.0  # Amplitud de la señal portadora
frecuencia_portadora = 20.0  # Frecuencia de la señal portadora (Hz)
tiempo_total = 1.0  # Duración total de la señal en segundos
tasa_muestreo = 1000.0  # Tasa de muestreo en Hz

# Generar la señal moduladora (una señal sinusoidal en este caso)
t = np.linspace(0, tiempo_total, int(tiempo_total * tasa_muestreo), endpoint=False)
moduladora = amplitud_moduladora * np.sin(2 * np.pi * frecuencia_moduladora * t)

# Generar la señal portadora (otra señal sinusoidal)
portadora = amplitud_portadora * np.sin(2 * np.pi * frecuencia_portadora * t)

# Realizar la modulación AM
señal_am = (1 + moduladora) * portadora

# Graficar las señales
plt.figure(figsize=(12, 6))

plt.subplot(3, 1, 1)
plt.plot(t, moduladora)
plt.title('Señal Moduladora')

plt.subplot(3, 1, 2)
plt.plot(t, portadora)
plt.title('Señal Portadora')

plt.subplot(3, 1, 3)
plt.plot(t, señal_am)
plt.title('Señal Modulada AM')

plt.tight_layout()
plt.show()
