from flask import Flask, jsonify
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

# Configuración de la base de datos con autenticación de Windows
DATABASE_URL = 'mssql+pyodbc:///?odbc_connect=' + \
               'DRIVER={SQL Server};' + \
               'SERVER=DESKTOP-NJ31F30;' + \
               'DATABASE=STOPWASHDB;' + \
               'trusted_connection=yes;'
app.config['SQLALCHEMY_DATABASE_URI'] = DATABASE_URL
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Crear la instancia de SQLAlchemy
db = SQLAlchemy(app)

# Modelo para la tabla "Clientes"
class Cliente(db.Model):
    __tablename__ = 'Clientes'
    ClienteID = db.Column(db.Integer, primary_key=True)
    Nombre = db.Column(db.String(50))
    Apellido = db.Column(db.String(50))
    Email = db.Column(db.String(50))
    Celular = db.Column(db.String(20))
    VehiculoID = db.Column(db.Integer)
    VisitasMensuales = db.Column(db.Integer)

# Ruta para obtener clientes
@app.route('/clientes', methods=['GET'])
def obtener_clientes():
    clientes = Cliente.query.all()

    # Convertir objetos Cliente a diccionarios
    clientes_dict = [
        {
            'ClienteID': cliente.ClienteID,
            'Nombre': cliente.Nombre,
            'Apellido': cliente.Apellido,
            'Email': cliente.Email,
            'Celular': cliente.Celular,
            'VehiculoID': cliente.VehiculoID,
            'VisitasMensuales': cliente.VisitasMensuales
        }
        for cliente in clientes
    ]

    # Devolver los datos en formato JSON
    return jsonify(clientes=clientes_dict)

if __name__ == '__main__':
    app.run(debug=True)
