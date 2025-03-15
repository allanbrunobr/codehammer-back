import psycopg2
import os
import urllib.parse

def test_connection():
    try:
        conn = psycopg2.connect(os.environ.get("DATABASE_URL"))
        print("Connection successful!")
        conn.close()
    except Exception as e:
        print(f"Connection failed: {e}")

if __name__ == "__main__":
    # Connect to the isolated PostgreSQL container
    os.environ["DATABASE_URL"] = "postgresql://postgres:postgres@localhost:5433/codehammer"
    print(f"Trying to connect with URL: postgresql://postgres:****@localhost:5433/codehammer")
    test_connection()
