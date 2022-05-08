import sqlalchemy
from sqlalchemy import create_engine, engine, text
import pandas as pd
import sqlite3
from sqlalchemy import text
import os
import time
from numpy import NaN
from pathlib import Path
import logging
import sqlparse

def execute_sql(file_path:str):
    with open(file_path) as sql_file:
         for statement in sqlparse.split(sqlparse.format(sql_file, strip_comments=True)):
            if len(statement.strip()) > 0:
                print(statement)
            with e.connect() as conn:
                conn.execute(text(statement))
                logging.info(statement)
    return True

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

    df = df.drop_duplicates(subset=["listened_at", "user_name", "artist_name", "track_name"])

    # is this correct?
    df = df.fillna(NaN)

    df.to_sql("listens", con=e, if_exists="append", index=False)

    sql_etl = [
        "sql/etl/dim_date.sql",
        "sql/etl/dim_artist.sql",
        "sql/etl/dim_track.sql",
        "sql/etl/dim_user.sql",
        "sql/etl/fact_listen.sql",
        "sql/etl/kpi_listen.sql",
        "sql/etl/kpi_user.sql",
        "sql/etl/kpi_track.sql"
    ]

    [execute_sql(f) for f in sql_etl]

    logging.info("tables created")

if __name__ == "__main__":

    # Create a custom logger
    logger = logging.getLogger(__name__)

    # Create handlers
    c_handler = logging.StreamHandler()
    f_handler = logging.FileHandler('file.log')
    c_handler.setLevel(logging.INFO) #warning
    f_handler.setLevel(logging.ERROR) #error

    # Create formatters and add it to handlers
    c_format = logging.Formatter('%(name)s - %(levelname)s - %(message)s')
    f_format = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    c_handler.setFormatter(c_format)
    f_handler.setFormatter(f_format)

    # Add handlers to the logger
    logger.addHandler(c_handler)
    logger.addHandler(f_handler)

    # Connects to an in­file database in the current working directory, or creates one, if it doesn't exist:
    e = create_engine('sqlite:///data/processed/music.db', echo=False)
    #file_path = "data/raw/dataset.txt"

    #main(df_listens, e)

    watch_dir = "data/interim/"
    contents = os.listdir(watch_dir)
    count = len(watch_dir)
    dirmtime = os.stat(watch_dir).st_mtime

    while True:
        logging.info("waiting for files")

        newmtime = os.stat(watch_dir).st_mtime

        if newmtime != dirmtime:
            dirmtime = newmtime
            new_contents = os.listdir(watch_dir)
            added = set(new_contents).difference(contents)

            if added:
                logging.info(f"Files added: {' '.join(added)}")

                for f in added:
                    # fix ufffd decode error for user_name
                    df_listens = pd.read_json(watch_dir+f, lines=True, encoding_errors="ignore")

                    df_listens["last_load"] = newmtime

                    main(df_listens, e)

                removed = set(contents).difference(new_contents)

                if removed:
                    logging.info(f"Files removed: {' '.join(removed)}")

            contents = new_contents

        time.sleep(5)
