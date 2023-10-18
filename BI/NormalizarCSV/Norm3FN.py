
'''
El código se encarga de llevar a cabo la Tercera Forma Normal (3FN) a partir del archivo ya obtenido del script de DataNorm. En este proceso, se crean tablas adicionales y se preparan varios archivos CSV para lograr una estructura de base de datos que cumpla con la 3FN. El resultado final es un archivo que contiene los datos normalizados de acuerdo con esta forma de normalización.
'''
import pandas as pd

# Cargar el archivo CSV
def load_data(file_path):
    df = pd.read_csv(file_path)
    return df

def remove_duplicates(df):
    df = df.drop_duplicates()
    return df

# Tabla para la información personal (IDPERSON es la clave primaria)
def create_personal_table(df):
    personal_df = df[['IDPERSON', 'first name', 'last name', 'birthdate', 'gender']]
    return personal_df

# Tabla para la información de idiomas (IDLANGUAGE es la clave primaria)
def create_language_table(df):
    language_df = df[['IDLANGUAGE', 'language']]
    language_df = language_df.drop_duplicates(subset=['language'])
    return language_df

# Tabla para la información de habilidades (IDSKILLS es la clave primaria)
def create_skills_table(df):
    skills_df = df[['IDSKILLS', 'skills']]
    skills_df = skills_df.drop_duplicates(subset=['skills'])
    return skills_df

# Tabla para la información de razas (IDRACE es la clave primaria)
def create_race_table(df):
    race_df = df[['IDRACE', 'race']]
    race_df = race_df.drop_duplicates(subset=['race'])
    return race_df

# Tabla para la información de universidades (IDUNIVERSITY es la clave primaria)
def create_university_table(df):
    university_df = df[['IDUNIVERSITY', 'University']]
    university_df = university_df.drop_duplicates(subset=['University'])
    return university_df

def main():
    input_file = "/Users/desarrollo/Desktop/PERSONAL_DATA_NORMALIZADO.csv"
    output_base_path = "/Users/desarrollo/Desktop/"  # Ruta base para los archivos
    output_file = "NORMALIZADO_3NF.csv"  # Nombre del archivo 3NF

    data = load_data(input_file)
    data = remove_duplicates(data)

    personal_df = create_personal_table(data)
    language_df = create_language_table(data)
    skills_df = create_skills_table(data)
    race_df = create_race_table(data)
    university_df = create_university_table(data)

    # Rutas para los archivos de las tablas individuales
    personal_csv_path = "PersonalData.csv"
    language_csv_path = "Languages.csv"
    skills_csv_path ="Skills.csv"
    race_csv_path =  "Race.csv"
    university_csv_path = "University.csv"

    # Guardar las tablas individuales en archivos CSV
    personal_df.to_csv(personal_csv_path, index=False)
    language_df.to_csv(language_csv_path, index=False)
    skills_df.to_csv(skills_csv_path, index=False)
    race_df.to_csv(race_csv_path, index=False)
    university_df.to_csv(university_csv_path, index=False)

    # Guardar los datos normalizados en un archivo 3NF
    data.to_csv(output_base_path + output_file, index=False)


if __name__ == "__main__":
    main()


