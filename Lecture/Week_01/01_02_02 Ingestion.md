# 1. Setting up PostgreSQL in Docker
- Image and Version: Used the official PostgreSQL image (e.g., postgres:13).
- Configuration:
- Set environment variables for the database user, password, and database name using -e flags.

```Terminal
docker run it 
    -e POSTGRES_USER=root 
    -e POSTGRES_PASSWORD=root 
    -e POSTGRES_DB=ny_taxi 
    -p 5433:5432 
    -v /path/to/ny_taxi_postgres_data:/var/lib/postgresql/data
    postgres:13
```

2. Persisting Data with Docker Volumes
	- Mapped a directory from the host machine to the container to ensure data persistence across container restarts:

docker run -v /path/to/ny_taxi_postgres_data:/var/lib/postgresql/data ...

3. Connecting to PostgreSQL
	- Tools Used:
	- CLI: Used pgcli for SQL queries:

pgcli -h localhost -p 5432 -u root -d ny_taxi


	- Port Mapping: The host port (5432) is mapped to the container port, allowing local tools to connect.

4. Working with the Dataset
	- Dataset Overview:
	- Used a NYC taxi dataset available online with millions of records.
	- Downloaded via wget or saved manually.
	- Explored the dataset briefly to understand its schema.
	- Data Processing with Pandas:
	- Loaded the dataset into Pandas for inspection and manipulation.
	- Ensured timestamp columns were parsed correctly using pd.to_datetime.

5. Creating and Populating the Database
	- Table Creation:
	- Used Pandas’ get_schema function to auto-generate the SQL CREATE TABLE statement.
	- Created the table in PostgreSQL.
	- Chunked Insertion:
	- Inserted data into PostgreSQL in chunks (e.g., 100,000 rows at a time) to avoid memory issues.
	- Utilized a loop to iterate over chunks and insert them one by one.
	- Example:

for chunk in pd.read_csv(file, chunksize=100000):
    chunk.to_sql(name='yellow_taxi_data', con=engine, if_exists='append')

6. Next Steps
	- Plan to explore pgAdmin in the next lesson for database management using a graphical interface.

This step-by-step process provides a hands-on introduction to Docker, PostgreSQL, SQL practice, and Python integration. Let me know if you need help with any specific part!









---
---



---

## Running PostgreSQL in Docker

### Docker Command for PostgreSQL
To run PostgreSQL in Docker, we use the official Docker image for PostgreSQL. Here's the command:

```bash
docker run -d \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v /Users/prbnrs/GIT/Data-Engineering-ZoomCamp/Lecture/Week_01/vol/ny_taxi_postgres_data:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:13
```

#### Explanation of the Command:
- **`docker run -it` / `docker run -d`**:
   - **`docker run`**: Creates and starts a new container.
   - **`-it`**: Runs the container in interactive mode, attaching the terminal for interaction and displaying logs.
   - **`-d`**: Runs the container in detached mode, the container runs on background.
- **Environment Variables:**
  - `POSTGRES_USER`: Sets the username (`root`).
  - `POSTGRES_PASSWORD`: Sets the password (`root`).
  - `POSTGRES_DB`: Sets the default database name (`ny_taxi`).
- **Volumes:**
  - Maps a local directory to `/var/lib/postgresql/data` in the container to persist data.
  - must provide full path
  - for Mac we can use $(pwd)/vol/ny_taxi_postgres_data:/var/lib/postgresql/data
- **Ports:**
  - Maps the container's default PostgreSQL port (5432) to the same port on the host machine.

#### **What Happens When You Run This Command**
1. A PostgreSQL container starts with:
   - **Username**: `root`
   - **Password**: `root`
   - **Default Database**: `ny_taxi`
2. The database files are stored persistently on the host machine in `/Users/prbnrs/GIT/Data-Engineering-ZoomCamp/Lecture/Week_01/vol/ny_taxi_postgres_data`.
3. The terminal remains attached, displaying logs from the PostgreSQL service.
4. PostgreSQL is accessible on `localhost:5432` using the credentials provided.

**How to Use the Running Container**

#### **1. Connect to PostgreSQL Inside the Container**
To interact with the PostgreSQL instance directly from the container, open a `psql` shell:
```bash
docker exec -it <container_name> psql -U root -d ny_taxi
```

#### **2. Connect from the Host Machine**
Use any PostgreSQL client to connect to the database:
- **Host**: `localhost`
- **Port**: `5432`
- **Username**: `root`
- **Password**: `root`
- **Database**: `ny_taxi`

For example, with `psql`:
```bash
psql -h localhost -p 5432 -U root -d ny_taxi
```

**Stop the Container:**
To stop the container, use:
```bash
docker stop <container_id>
```

---

## Connecting to PostgreSQL

Once PostgreSQL is running, we can connect using `pgcli`:

1. Install `pgcli` (if not already installed):
   ```bash
   pip install pgcli
   ```

2. Connect to the database:
   ```bash
   pgcli -h localhost -p 5432 -u root -d ny_taxi
   ```

   - `-h`: Hostname (default is `localhost`).
   - `-p`: Port (default is `5432`).
   - `-u`: Username (`root`).
   - `-d`: Database name (`ny_taxi`).

Once connected, test the database with basic queries like:
```sql
\dt
```
```sql
SELECT 1;
```

---

## Dataset Overview

We will use the New York Taxi dataset for practice. The dataset includes:
- Yellow taxi trip records.
- Pickup and drop-off times.
- Passenger count, trip distances, payment types, and more.

Link: https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page

### Downloading the Dataset
Use the following command to download the dataset:

```bash
wget https://path-to-dataset/yellow_tripdata_2021-01.csv
```

---

## Loading Data into PostgreSQL

### Preparing the Dataset

1. Use `pandas` to inspect and process the dataset:

```python
import pandas as pd

# Load dataset
df = pd.read_csv("yellow_tripdata_2021-01.csv")

# Convert date columns to datetime
for col in ['pickup_datetime', 'dropoff_datetime']:
    df[col] = pd.to_datetime(df[col])
```

2. Generate the SQL schema using `pandas`:

```python
from pandas.io.sql import get_schema

print(get_schema(df, "yellow_taxi_data"))
```

### Writing Data to PostgreSQL

1. Install `SQLAlchemy`:
   ```bash
   pip install sqlalchemy
   ```

2. Create a connection and load the data:

```python
from sqlalchemy import create_engine

# Create a connection to PostgreSQL
engine = create_engine("postgresql://root:root@localhost:5432/ny_taxi")

# Load data in chunks
chunk_size = 100000
for chunk in pd.read_csv("yellow_tripdata_2021-01.csv", chunksize=chunk_size):
    chunk.to_sql("yellow_taxi_data", engine, if_exists="append", index=False)
```

---

## Verifying Data in PostgreSQL

After loading the data, connect to PostgreSQL and verify:

```sql
SELECT COUNT(*) FROM yellow_taxi_data;
```

Check the schema:
```sql
\d yellow_taxi_data;
```

---
