import duckdb
import requests
from pathlib import Path

BASE_URL = "https://github.com/DataTalksClub/nyc-tlc-data/releases/download"
TAXI_TYPE = "fhv"
YEAR = 2019

def download_and_convert_files():
    data_dir = Path("data") / TAXI_TYPE
    data_dir.mkdir(exist_ok=True, parents=True)

    for month in range(1, 13):
        parquet_filename = f"{TAXI_TYPE}_tripdata_{YEAR}-{month:02d}.parquet"
        parquet_filepath = data_dir / parquet_filename

        if parquet_filepath.exists():
            print(f"Skipping {parquet_filename} (already exists)")
            continue

        csv_gz_filename = f"{TAXI_TYPE}_tripdata_{YEAR}-{month:02d}.csv.gz"
        csv_gz_filepath = data_dir / csv_gz_filename

        # Download
        print(f"Downloading {csv_gz_filename}...")
        try:
            response = requests.get(f"{BASE_URL}/{TAXI_TYPE}/{csv_gz_filename}", stream=True)
            response.raise_for_status()
        except requests.HTTPError:
            print(f"Skipping {csv_gz_filename} (not found on server)")
            continue

        with open(csv_gz_filepath, 'wb') as f:
            for chunk in response.iter_content(chunk_size=8192):
                f.write(chunk)

        # Convert to Parquet
        print(f"Converting {csv_gz_filename} to Parquet...")
        con = duckdb.connect()
        con.execute(f"""
            COPY (SELECT * FROM read_csv_auto('{csv_gz_filepath}'))
            TO '{parquet_filepath}' (FORMAT PARQUET)
        """)
        con.close()

        # Delete CSV.gz
        csv_gz_filepath.unlink()
        print(f"Done: {parquet_filename}")


def load_into_duckdb():
    print("\nLoading parquet files into taxi_rides_ny.duckdb...")
    con = duckdb.connect("taxi_rides_ny.duckdb")
    con.execute("CREATE SCHEMA IF NOT EXISTS prod")
    con.execute(f"""
        CREATE OR REPLACE TABLE prod.fhv_tripdata AS
        SELECT * FROM read_parquet('data/{TAXI_TYPE}/*.parquet', union_by_name=true)
    """)
    count = con.execute("SELECT COUNT(*) FROM prod.fhv_tripdata").fetchone()[0]
    print(f"Loaded {count:,} rows into prod.fhv_tripdata")
    con.close()


if __name__ == "__main__":
    download_and_convert_files()
    load_into_duckdb()