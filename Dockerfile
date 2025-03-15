FROM postgres:15

# Set environment variables
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_DB=codehammer

# Create app directory
WORKDIR /app

# Copy the SQL script
COPY database_setup.sql /docker-entrypoint-initdb.d/

# The postgres image automatically runs scripts in /docker-entrypoint-initdb.d/
# when the container starts for the first time

# Expose PostgreSQL port
EXPOSE 5432

# Set the default command to run when starting the container
CMD ["postgres"]
