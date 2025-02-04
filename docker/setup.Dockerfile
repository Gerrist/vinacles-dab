FROM mcr.microsoft.com/mssql/server:2022-CU13-ubuntu-22.04

USER root

RUN apt-get update \
    && apt-get install -y curl \
    && apt-get clean

USER mssql

WORKDIR /app
COPY .. .

CMD ["/bin/bash", "/app/setup.sh"]
