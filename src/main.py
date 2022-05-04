import sqlalchemy
from sqlalchemy import create_engine, engine, text
import pandas as pd
import sqlite3
from sqlalchemy import text
import os
import time
from numpy import NaN

def main(df_listens: pd.DataFrame, e: engine.base.Engine):
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

    df = df.drop_duplicates()

    # is this correct?
    df = df.fillna(NaN)

    df.to_sql("listens", con=e, if_exists="append", index=False)

if __name__ == "__main__":
    # Connects to an in­file database in the current working directory, or creates one, if it doesn't exist:
    e = create_engine('sqlite:///data/processed/spotify.db', echo=False)
    file_path = "data/raw/dataset.txt"

    # fix ufffd decode error for user_name
    df_listens = pd.read_json(file_path, lines=True, encoding_errors="ignore")

    main(df_listens, e)

    watch_dir = "data/raw/"
    contents = os.listdir(watch_dir)
    count = len(watch_dir)
    dirmtime = os.stat(watch_dir).st_mtime

    while True:
        newmtime = os.stat(watch_dir).st_mtime

        if newmtime != dirmtime:
            dirmtime = newmtime
            new_contents = os.listdir(watch_dir)
            added = set(new_contents).difference(contents)

            if added:
                print(f"Files added: {' '.join(added)}")

            removed = set(contents).difference(new_contents)

            if removed:
                print(f"Files removed: {' '.join(removed)}")

            contents = new_contents

        time.sleep(5)


    """
    with e.connect() as conn:
        conn.execute(text("CREATE TABLE IF NOT EXISTS dim_user;"))
        conn.execute(text("CREATE TABLE IF NOT EXISTS dim_track"))
        conn.execute(text("CREATE TABLE IF NOT EXISTS dim_artist"))
        conn.execute(text("CREATE TABLE IF NOT EXISTS fact_listen"))
    """

