import numpy as np
import matplotlib.pyplot as plt

# Parámetros de la señal
amplitud = 1.0
frecuencia = 5.0
tiempo_total = 1.0
tasa_muestreo = 1000.0

# Generar una señal sinusoidal
t = np.linspace(0, tiempo_total, int(tiempo_total * tasa_muestreo), endpoint=False)
señal = amplitud * np.sin(2 * np.pi * frecuencia * t)

# Calcular el espectro de frecuencia
espectro_frecuencia = np.fft.fft(señal)
frecuencias = np.fft.fftfreq(len(t), 1 / tasa_muestreo)

# Graficar el espectro de frecuencia
plt.figure(figsize=(8, 4))
plt.plot(frecuencias, np.abs(espectro_frecuencia))
plt.title('Espectro de Frecuencia de la Señal')
plt.xlabel('Frecuencia (Hz)')
plt.ylabel('Amplitud')
plt.grid(True)
plt.show()
