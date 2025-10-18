Perfect — this `init-databases.sh` script completes your stack beautifully 👏

Let’s now **update your README.md** to include this script properly explained — so your YouTube viewers understand *what it does, how it runs, and why it’s important*.

Here’s the **final, YouTube-ready README.md** — fully styled, with clear explanations, visuals, and a professional tone that’s still friendly 👇

---

# 🚀 AI Biz Toolkit — Ultimate Open-Source Automation & Analytics Stack

Welcome to **AI Biz Toolkit**, your all-in-one open-source environment for automating workflows, managing data visually, and analyzing insights — powered entirely by **Docker**.

This toolkit combines **PostgreSQL**, **NocoDB**, **n8n**, **Metabase**, and **Ntfy** into one integrated stack.
It’s ideal for automation enthusiasts, indie developers, data-driven startups, or AI creators who want everything connected and running locally or on a NAS.

---

## 🌟 What’s Inside

| Service           | Purpose                               | Port     | Highlights                                            |
| ----------------- | ------------------------------------- | -------- | ----------------------------------------------------- |
| 🐘 **PostgreSQL** | Central database powering everything  | —        | Shared by NocoDB, n8n & Metabase                      |
| 🧩 **NocoDB**     | Airtable-like UI for your database    | **8085** | Visual database management, API-ready                 |
| ⚙️ **n8n**        | No-code workflow automation tool      | **8086** | Connect APIs, trigger automations, build integrations |
| 📢 **Ntfy**       | Simple HTTP-based notification server | **8087** | Push notifications from your workflows                |
| 📊 **Metabase**   | Business intelligence & dashboards    | **8088** | Visualize and explore your data instantly             |

---

## 🧠 Why This Stack?

* 🚀 **Fully open-source** — no vendor lock-in
* 🧩 **One database to rule them all** — all apps share PostgreSQL
* 💾 **Persistent volumes** — data survives container restarts
* ⚙️ **Health checks included** — automatic startup sequencing
* 🌍 **Perfect for Synology NAS, VPS, or local development**
* 💡 **AI-Ready backend** — perfect companion for OpenAI, LangChain, and workflow automation agents

---

## 🧱 Folder Structure

This stack stores all persistent data on your host system under `/volume1/docker/aibiztoolkit`:

```
/volume1/docker/aibiztoolkit/
│
├── db_data/          # PostgreSQL database files
├── nc_data/          # NocoDB project data
├── n8n_data/         # n8n workflows, credentials, and logs
├── metabase_data/    # Metabase configuration and data
└── init-databases.sh # Auto-creates databases for each app
```

> 💡 You can change the `device:` paths in the `volumes:` section of the docker-compose file to fit your environment.

---

## ⚙️ How to Run

### 🧩 Step 1. Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/aibiztoolkit.git
cd aibiztoolkit
```

### 🧾 Step 2. Make the Init Script Executable

```bash
chmod +x init-databases.sh
```

This script automatically creates the required databases inside PostgreSQL when the container starts.

---

## 🧰 The Init Script Explained (`init-databases.sh`)

```bash
#!/bin/bash
set -e

echo "=========================================="
echo "Initializing PostgreSQL Databases"
echo "=========================================="

# Create the three required databases
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE n8n_db OWNER postgres;
    GRANT ALL PRIVILEGES ON DATABASE n8n_db TO postgres;
    
    CREATE DATABASE nocodb_db OWNER postgres;
    GRANT ALL PRIVILEGES ON DATABASE nocodb_db TO postgres;
    
    CREATE DATABASE metabase OWNER postgres;
    GRANT ALL PRIVILEGES ON DATABASE metabase TO postgres;
    
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
```

**💬 What it does:**

* Runs automatically when the PostgreSQL container starts.
* Creates three databases:

  * `n8n_db` for **n8n workflows**
  * `nocodb_db` for **NocoDB**
  * `metabase` for **Metabase**
* Grants full access to the `postgres` user.
* Prints a friendly summary confirming database creation.

---

### 🐋 Step 3. Launch Everything

```bash
docker compose up -d
```

All services will start automatically.
The PostgreSQL container initializes first, runs your script, and only once the databases exist do the other services launch.

---

## 🔍 Access the Services

| App             | URL                                            | Description                          |
| --------------- | ---------------------------------------------- | ------------------------------------ |
| 🧩 **NocoDB**   | [http://localhost:8085](http://localhost:8085) | Spreadsheet-style database UI        |
| ⚙️ **n8n**      | [http://localhost:8086](http://localhost:8086) | Build automations visually           |
| 📢 **Ntfy**     | [http://localhost:8087](http://localhost:8087) | Receive push/webhook notifications   |
| 📊 **Metabase** | [http://localhost:8088](http://localhost:8088) | Interactive dashboards and analytics |

> ⏱️ Give it a minute after the first run — PostgreSQL needs to initialize before all services report healthy.

---

## 🩺 Health Checks

Every container includes health monitoring:

* ✅ PostgreSQL ensures all three databases exist before declaring “healthy”
* ✅ Ntfy checks `GET /v1/health` returns `"healthy": true`
* ✅ Metabase checks `/api/health` endpoint before marking ready

This ensures reliable startup and restart behavior — no more race conditions 🎯

---

## 🧩 Environment Variables Overview

| Variable                                            | Purpose                                |
| --------------------------------------------------- | -------------------------------------- |
| `POSTGRES_DB`, `POSTGRES_USER`, `POSTGRES_PASSWORD` | PostgreSQL base config                 |
| `NC_DB`                                             | NocoDB connection string to PostgreSQL |
| `DB_POSTGRESDB_*`                                   | n8n database connection details        |
| `MB_DB_*`                                           | Metabase PostgreSQL connection         |
| `TZ`                                                | Timezone consistency across containers |

---

## 💡 Tips & Extensions

* 🧠 Connect **LangChain** or **OpenAI API** to your n8n workflows
* 📤 Expose NocoDB REST API for frontend apps
* 📊 Use Metabase to visualize your AI agent logs or workflow stats
* 📩 Integrate Ntfy for workflow notifications

---

## 🧩 Troubleshooting

| Issue                       | Solution                                    |
| --------------------------- | ------------------------------------------- |
| PostgreSQL not initializing | Ensure `init-databases.sh` is executable    |
| Containers restarting       | Run `docker logs <container_name>` to debug |
| Port conflicts              | Change ports in `docker-compose.yml`        |
| Data not saving             | Check your volume mount paths are valid     |

---

## ❤️ Credits

* [PostgreSQL](https://www.postgresql.org/)
* [NocoDB](https://nocodb.com/)
* [n8n](https://n8n.io/)
* [Metabase](https://www.metabase.com/)
* [Ntfy](https://ntfy.sh/)

---

## 🎥 Watch the Tutorial

👉 [**Watch on YouTube**](https://youtube.com/@your_channel)
I’ll walk you through the setup, explain each service, and show how to build your first AI-powered workflow.

---

## ⭐ TL;DR

```bash
git clone https://github.com/YOUR_USERNAME/aibiztoolkit.git
cd aibiztoolkit
chmod +x init-databases.sh
docker compose up -d
```

**That’s it!**
Your complete automation and analytics toolkit is live in minutes 🚀
