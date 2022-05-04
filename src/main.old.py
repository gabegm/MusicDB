from sqlalchemy import create_engine
from sqlalchemy.types import Integer, DATETIME, String, Float
import sqlite3
import pandas as pd
# import json
# from numpy import NaN

# Connects to an in­file database in the current working directory, or creates one, if it doesn't exist:
conn = sqlite3.connect('data/processed/spotify.db')
engine = create_engine('sqlite:///data/processed/spotify.db', echo=False)

with conn:
    # Set up your database here
    conn.execute("""CREATE TABLE IF NOT EXISTS greeting (greeting TEXT);""")
    conn.execute("""INSERT INTO greeting VALUES ("Hello World!");""")

pd.read_sql_query('SELECT * from greeting', conn)

file_path = "data/raw/dataset.txt"

df_listens = pd.read_json(file_path, lines=True)

df_tracks = pd.json_normalize(df_listens["track_metadata"])

df = pd.concat([df_listens.drop(["track_metadata"], axis=1), df_tracks], axis=1)

old_cols = df.columns
new_cols = [col.replace('.', '_') for col in old_cols]

mapper = {i:j for i,j in zip(old_cols, new_cols)}

df = df.rename(columns=mapper)

# keeping list type for now
for col in df.columns:
    if df[col].dtype == 'O':
        df[col] = df[col].astype(str)

# df = df.fillna("")

df.to_sql('fact_listen', con=engine, if_exists="replace", index=False)

pd.read_sql_query('SELECT * from fact_listen limit 10;', engine)

"""
df = pd.DataFrame({})

with open(file_path) as f:
    s = f.read()

    # Remove 'ISODate(', ')'       For correct, we can use regex
    #string = string.replace('ISODate(', '')
    #string = string.replace(')', '')

    jsonData = json.loads(json.dumps(s))

    df = df.append(pd.DataFrame(jsonData))



    with open(file_path) as f:
    data = json.load(f)

    df_listens = pd.DataFrame(data)

    main(df_listens)
"""