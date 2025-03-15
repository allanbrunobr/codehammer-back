# PostgreSQL Database Setup

This project contains everything needed to set up a PostgreSQL database with predefined tables and sample data for the CodeHammer application.

## Files

- `database_setup.sql` - SQL script with table definitions and initial data
- `Dockerfile` - Defines the PostgreSQL container with the database setup
- `docker-compose-db.yml` - Docker Compose configuration for easy deployment

## Database Structure

The database includes the following tables:

- users
- plans
- periods
- plan_periods
- subscriptions
- billings
- integrations

## Getting Started

### Prerequisites

- Docker
- Docker Compose

### Running the Database

#### Option 1: Using Docker Compose (Recommended)

1. Build and start the PostgreSQL container:

```bash
docker-compose -f docker-compose-db.yml up -d
```

This will:

- Build a PostgreSQL 15 container
- Initialize the database with the tables and data from `database_setup.sql`
- Expose the database on port 5433 (to avoid conflicts with existing PostgreSQL instances)
- Create an isolated network for the container
- Create a persistent volume for the data

#### Option 2: Using Docker Directly

1. Build the Docker image:

```bash
docker build -t postgresql-codehammer .
```

2. Create an isolated network:

```bash
docker network create codehammer_network
```

3. Run a container from the image:

```bash
docker run -d \
  --name postgresql-codehammer \
  --network codehammer_network \
  -p 5433:5432 \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=codehammer \
  -v postgresql_codehammer_data:/var/lib/postgresql/data \
  postgresql-codehammer
```

4. Verify the container is running:

```bash
docker ps
```

You should see the `postgresql-codehammer` container running.

### Connecting to the Database

You can connect to the database using any PostgreSQL client with these credentials:

- Host: localhost
- Port: 5433 (since we mapped the container's 5432 port to host's 5433)
- Database: codehammer
- Username: postgres
- Password: postgres

Example using psql:

```bash
psql -h localhost -p 5433 -U postgres -d codehammer
```

### Stopping the Database

#### Option 1: Using Docker Compose

To stop the database:

```bash
docker-compose -f docker-compose-db.yml down
```

To stop and remove all data (including the volume):

```bash
docker-compose -f docker-compose-db.yml down -v
```

#### Option 2: Using Docker Directly

To stop the container:

```bash
docker stop postgresql-codehammer
```

To remove the container:

```bash
docker rm postgresql-codehammer
```

To remove the image:

```bash
docker rmi postgresql-codehammer
```

To remove the volume:

```bash
docker volume rm postgresql_codehammer_data
```

To remove the network:

```bash
docker network rm codehammer_network
```

## Database Schema

The database follows this schema with relationships:

- Users (base table)
- Plans (base table)
- Periods (base table)
- Plan_Periods (depends on plans and periods)
- Subscriptions (depends on users and plans)
- Billings (depends on users)
- Integrations (depends on users)
