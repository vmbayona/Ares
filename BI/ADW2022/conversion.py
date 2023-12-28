

import pandas as pd

# Especifica la ruta del archivo Excel
excel_path = '/Users/desarrollo/Desktop/Product_data/Date_data.xlsx'  # Reemplaza con la ruta correcta de tu archivo Excel

# Cargar datos desde el archivo Excel
df = pd.read_excel(excel_path)

# Convertir a JSON
json_data = df.to_json(orient='records')

# Imprimir el resultado
print(json_data)

