mkdir -p /var/opt/mssql/backup

DOWNLOAD_TARGET=/var/opt/mssql/backup/AdventureWorksDW2022.bak

# If the DW file does not exist, download it
if [ ! -f "$DOWNLOAD_TARGET" ]; then
  echo "AdventureWorksDW2022.bak not found. Downloading to $DOWNLOAD_TARGET..."
  curl -L -o $DOWNLOAD_TARGET https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2022.bak
else
  echo "AdventureWorksDW2022.bak found, skipping download."
fi

# Wait for the SQL Server to be available
until /opt/mssql-tools/bin/sqlcmd -S db -U sa -P "$MSSQL_SA_PASSWORD" -Q "SELECT 1"; do
  echo "Waiting for SQL Server to be available..."
  sleep 1
done

echo "Shaping database..."
/opt/mssql-tools/bin/sqlcmd -S db -U sa -P "$MSSQL_SA_PASSWORD" -i /usr/src/app/ddl.sql

echo "Database shaping complete!"
