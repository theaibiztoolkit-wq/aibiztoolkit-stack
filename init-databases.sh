#!/bin/bash
set -e

echo "=========================================="
echo "Initializing PostgreSQL Databases"
echo "=========================================="

# Create the three required databases
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    -- Create N8N database
    CREATE DATABASE n8n_db OWNER postgres;
    GRANT ALL PRIVILEGES ON DATABASE n8n_db TO postgres;
    
    -- Create NocoDB database
    CREATE DATABASE nocodb_db OWNER postgres;
    GRANT ALL PRIVILEGES ON DATABASE nocodb_db TO postgres;
    
    -- Create Metabase database
    CREATE DATABASE metabase OWNER postgres;
    GRANT ALL PRIVILEGES ON DATABASE metabase TO postgres;
    
    -- Verify databases were created
    \l
EOSQL

echo "=========================================="
echo "Database initialization completed!"
echo "=========================================="
echo "Created databases:"
echo "  - n8n_db"
echo "  - nocodb_db"
echo "  - metabase"
echo "=========================================="