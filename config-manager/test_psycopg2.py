import os
import psycopg2
from dotenv import load_dotenv

# Carregar variáveis de ambiente do arquivo .env
load_dotenv()

# Parâmetros de conexão
host = "localhost"
port = "5433"
dbname = "codehammer"
user = "postgres"
password = "postgres"  # Senha do container PostgreSQL isolado

print(f"Tentando conectar ao banco de dados:")
print(f"  Host: {host}")
print(f"  Port: {port}")
print(f"  Database: {dbname}")
print(f"  User: {user}")
print(f"  Password: {'*' * len(password)}")

try:
    # Conectar ao banco de dados
    conn = psycopg2.connect(
        host=host,
        port=port,
        dbname=dbname,
        user=user,
        password=password
    )
    
    print("Conexão com o banco de dados estabelecida com sucesso!")
    
    # Testar uma consulta simples
    cursor = conn.cursor()
    cursor.execute("SELECT 1")
    result = cursor.fetchone()
    print(f"Resultado da consulta de teste: {result}")
    
    cursor.close()
    conn.close()
except Exception as e:
    print(f"Erro ao conectar ao banco de dados: {e}")
