FROM python:3.12.8

RUN apt-get install wget
RUN pip install pandas sqlalchemy psycopg2

WORKDIR /app
COPY ingest_data.py ingest_data.py 

# This entrypoint ensures the container doesn't exit immediately
ENTRYPOINT [ "tail", "-f", "/dev/null" ]
