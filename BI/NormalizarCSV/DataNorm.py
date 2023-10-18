'''
El código se encarga de realizar una eliminación de duplicados y normalización en la primera forma normal (1FN) a partir del archivo CSV original. También crea identificadores únicos (ID) para las columnas con el fin de obtener un archivo normalizado. Finalmente, el código prepara los datos normalizados para ser utilizados en el script Norm3FN.py .
'''

import pandas as pd
import re
from unidecode import unidecode

def load_data(file_path):
    # Cargar el archivo CSV
    df = pd.read_csv(file_path)
    return df

def remove_duplicates(df):
    # Eliminar duplicados
    df = df.drop_duplicates()
    return df

def normalize_name(name):
    # Función para normalizar nombres
    return name.capitalize()

def preprocess_names(df):
    # Corregir errores de formato o estandarizar datos
    df['first_name'] = df['first_name'].apply(normalize_name)
    df['last_name'] = df['last_name'].apply(normalize_name)
    # Cambiar nombres de columnas
    df.rename(columns={'first_name': 'first name'}, inplace=True)
    df.rename(columns={'last_name': 'last name'}, inplace=True)
    df.rename(columns={'id': 'IDPERSON'}, inplace=True)
    return df

def preprocess_birthdate(df):
    # Validar y manejar valores faltantes en 'birthdate'
    df['birthdate'].fillna('2023-01-01', inplace=True)
    # Convertir 'birthdate' a tipo datetime
    df['birthdate'] = pd.to_datetime(df['birthdate'])
    # Mantener solo el día y el mes
    df['birthdate'] = df['birthdate'].dt.strftime('%d - %m')
    return df


def normalize_gender(gender):
    # Normalizar la columna 'gender'
    gender = gender.lower()
    gender = gender.replace("-", " ")
    return gender

def preprocess_gender(df):
    df['gender'] = df['gender'].apply(normalize_gender)
    # Usar factorize para asignar valores únicos a cada género
    df['IDGENDER'], _ = pd.factorize(df['gender'])
    # Asegurarte de que los valores en 'IDGENDER' estén en el rango de 100 a 110
    df['IDGENDER'] = df['IDGENDER'] + 100
    df['IDGENDER'] = df['IDGENDER'].clip(lower=100, upper=110)
    return df


def normalize_text(text):
    # Función para normalizar el texto y eliminar carácteres
    text = unidecode(text)
    text = text.replace(";", "").replace("&", "")
    return text

def preprocess_language_skills(df):
    # Función para normalizar lenguaje y habilidades
    df['language'] = df['language'].apply(normalize_text)
    df['skills'] = df['skills'].apply(normalize_text)

    unique_languages = df['language'].unique()
    language_mapping = {language: i + 200 for i,
                        language in enumerate(unique_languages)}
    df['IDLANGUAGE'] = df['language'].map(language_mapping)
    # Validar que los valores en 'IDLANGUAGE' estén en el rango de 200 a 400
    df['IDLANGUAGE'] = df['IDLANGUAGE'].clip(lower=200, upper=400)
    return df

def normalize_race(race):
    race = re.sub(r'\([^)]*\)', '', race)  # Eliminar texto entre paréntesis
    if " and " in race:
        race = race.split(" and ")[0]
    elif " or " in race:
        race = race.split(" or ")[0]
    return race

def preprocess_race(df):
    df['race'] = df['race'].apply(normalize_race)
    unique_races = df['race'].unique()
    race_mapping = {race: i + 300 for i, race in enumerate(unique_races)}
    df['IDRACE'] = df['race'].map(race_mapping)
    # Validar que los valores en 'IDRACE' estén en el rango de 300 a 500
    df['IDRACE'] = df['IDRACE'].clip(lower=300, upper=500)
    return df


def normalize_university(university):
    # Función para normalizar la columna 'University'
    university = re.sub(r'\([^)]*\)', '', university)
    university = university.replace('-', '').replace(',', '').replace('"', '')
    return university


def preprocess_university(df):
    df['University'] = df['University'].apply(normalize_university)

    unique_universities = df['University'].unique()
    university_mapping = {university: i + 400 for i,
                          university in enumerate(unique_universities)}
    df['IDUNIVERSITY'] = df['University'].map(university_mapping)
    # Validar que los valores en 'IDUNIVERSITY' estén en el rango de 400 a 1500
    df['IDUNIVERSITY'] = df['IDUNIVERSITY'].clip(lower=400, upper=1500)
    return df


def preprocess_skills(df):
    unique_skills = df['skills'].unique()
    skills_mapping = {skills: i + 500 for i,
                      skills in enumerate(unique_skills)}
    df['IDSKILLS'] = df['skills'].map(skills_mapping)
    # Validar que los valores en 'IDSKILLS' estén en el rango de 500 a 1500
    df['IDSKILLS'] = df['IDSKILLS'].clip(lower=500, upper=1500)
    return df


def save_data(df, output_path):
    # Guardar el archivo normalizado
    df.to_csv(output_path, index=False)
    print("Archivo CSV normalizado:", output_path)


def main():
    input_file = "/Users/desarrollo/Desktop/PERSONAL_DATA.csv"
    output_file = "/Users/desarrollo/Desktop/PERSONAL_DATA_NORMALIZADO.csv"
    data = load_data(input_file)
    data = remove_duplicates(data)
    data = preprocess_names(data)
    data = preprocess_birthdate(data)
    data = preprocess_gender(data)
    data = preprocess_language_skills(data)
    data = preprocess_race(data)
    data = preprocess_university(data)
    data = preprocess_skills(data)
    save_data(data, output_file)

if __name__ == "__main__":
    main()
