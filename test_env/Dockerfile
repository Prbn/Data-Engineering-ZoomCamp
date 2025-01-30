FROM python:3.12.8

RUN pip install pandas numpy notebook pgcli sqlalchemy

WORKDIR /app

COPY notebook.sh notebook.sh

ENTRYPOINT [ "bash" ]