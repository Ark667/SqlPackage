FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

# Install default modules
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        curl \
        libcurl4 \
        libicu60 \
        libunwind8 \
        netcat \
        libssl1.0 \
        wget \
        libgdiplus \
        unzip 

# Install SqlPackage
RUN wget -O sqlpackage.zip https://go.microsoft.com/fwlink/?linkid=2143497
RUN unzip sqlpackage.zip -d /opt/sqlpackage
RUN chmod +x /opt/sqlpackage/sqlpackage
RUN ln -s /opt/sqlpackage/sqlpackage /usr/local/bin/sqlpackage
RUN rm sqlpackage.zip

# Install SQLCMD
RUN apt install -y gnupg gnupg1 gnupg2
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list | tee /etc/apt/sources.list.d/msprod.list
RUN apt update && apt upgrade -y
RUN ACCEPT_EULA=Y apt install mssql-tools unixodbc-dev
RUN ln -s /opt/mssql-tools/bin/sqlcmd /usr/local/bin/sqlcmd

WORKDIR /home