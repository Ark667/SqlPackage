# SqlPackage in a Docker image

[SqlPackage](https://docs.microsoft.com/en-us/sql/tools/sqlpackage?view=sql-server-ver15) is a Microsoft tool for importing and exporting bacpac and dacpac files from SQL Server.

This Docker image contains sqlpackage and is designed for when you want to run SqlPackage without installing it locally.

This image also contains `sqlcmd`. This makes this image very useful for running basic SQL Server tasks.

## GitHub

[https://github.com/Ark667/SqlPackage](https://github.com/Ark667/SqlPackage)

## How to use

Run from current release.

```pwsh
docker run --rm -it ghcr.io/ark667/sqlpackage:master sqlpackage
```

Build the image locally.

```pwsh
docker build --tag sqlpackage .
```

## SqlPackage

Make a database backup. After execution, the bacpac file will be placed in sqlpackage folder of the current prompt.

```pwsh
docker run --rm -it --network host -v "$($PWD)/sqlpackage:/home" sqlpackage:dev sqlpackage /Action:Export /SourceServerName:"[host],[port]" /SourceDatabaseName:"[database]" /SourceUser:"[user]" /SourcePassword:"[password]" /TargetFile:"/home/backup.bacpac"
```

Make a database restore. The imported bacpac must be placed in sqlpackage folder of the current prompt, and database shoud not exists.

```pwsh
docker run --rm -it --network host -v "$($PWD)/sqlpackage:/home" ghcr.io/ark667/sqlpackage:master sqlpackage /Action:Import /TargetServerName:"[host],[port]" /TargetDatabaseName:"[database]" /TargetUser:"[user]" /TargetPassword:"[password]" /SourceFile:"/home/backup.bacpac"
```

Deploy a database schema. A folder containing the dacpac file is needed.

```pwsh
docker run --rm -it --network host -v "[dacpac_folder]:/home" ghcr.io/ark667/sqlpackage:master sqlpackage /Action:Publish /TargetServerName:"[host],[port]" /TargetDatabaseName:"[database]" /TargetUser:"[user]" /TargetPassword:"[password]" /SourceFile:"/home/[dacpac_file]"
```

## SqlCmd

Delete a database. Highly dangerous!

```pwsh
docker run --rm -it --network host ghcr.io/ark667/sqlpackage:master sqlcmd -S "[host],[port]" -U "[user]" -P "[password]" -Q "use [databsae];alter database [database] set single_user with rollback immediate;use master;drop database [database];"
```

## Additional Resources

* [https://github.com/microsoft/mssql-docker](https://github.com/microsoft/mssql-docker)
* [Linux Microsoft ODBC Driver for SQL Server](https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver15#ubuntu17)
