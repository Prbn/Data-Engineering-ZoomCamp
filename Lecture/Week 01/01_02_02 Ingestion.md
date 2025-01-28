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
	•	Mapped a directory from the host machine to the container to ensure data persistence across container restarts:

docker run -v /path/to/ny_taxi_postgres_data:/var/lib/postgresql/data ...

3. Connecting to PostgreSQL
	•	Tools Used:
	•	CLI: Used pgcli for SQL queries:

pgcli -h localhost -p 5432 -u root -d ny_taxi


	•	Port Mapping: The host port (5432) is mapped to the container port, allowing local tools to connect.

4. Working with the Dataset
	•	Dataset Overview:
	•	Used a NYC taxi dataset available online with millions of records.
	•	Downloaded via wget or saved manually.
	•	Explored the dataset briefly to understand its schema.
	•	Data Processing with Pandas:
	•	Loaded the dataset into Pandas for inspection and manipulation.
	•	Ensured timestamp columns were parsed correctly using pd.to_datetime.

5. Creating and Populating the Database
	•	Table Creation:
	•	Used Pandas’ get_schema function to auto-generate the SQL CREATE TABLE statement.
	•	Created the table in PostgreSQL.
	•	Chunked Insertion:
	•	Inserted data into PostgreSQL in chunks (e.g., 100,000 rows at a time) to avoid memory issues.
	•	Utilized a loop to iterate over chunks and insert them one by one.
	•	Example:

for chunk in pd.read_csv(file, chunksize=100000):
    chunk.to_sql(name='yellow_taxi_data', con=engine, if_exists='append')

6. Next Steps
	•	Plan to explore pgAdmin in the next lesson for database management using a graphical interface.

This step-by-step process provides a hands-on introduction to Docker, PostgreSQL, SQL practice, and Python integration. Let me know if you need help with any specific part!