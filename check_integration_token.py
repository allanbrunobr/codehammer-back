import os
import psycopg2
from dotenv import load_dotenv

# Carregar variáveis de ambiente do arquivo .env
load_dotenv("./config-manager/.env")

# Parâmetros de conexão
host = "localhost"
port = "5433"
dbname = "codehammer"
user = "postgres"
password = "postgres"  # Senha do container PostgreSQL isolado

integration_id = "7942054e-ca2f-43b6-b50b-b78f38fa1c35"

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
    
    # Consultar a integração específica
    cursor = conn.cursor()
    cursor.execute(
        "SELECT id, name, repository_url, repository_token, created_at, updated_at FROM public.integrations WHERE id = %s",
        (integration_id,)
    )
    
    integration = cursor.fetchone()
    
    if integration:
        print("\nDetalhes da Integração:")
        print(f"ID: {integration[0]}")
        print(f"Nome: {integration[1]}")
        print(f"URL do Repositório: {integration[2]}")
        print(f"Token do Repositório: {integration[3]}")
        print(f"Criado em: {integration[4]}")
        print(f"Atualizado em: {integration[5]}")
    else:
        print(f"Integração com ID {integration_id} não encontrada.")
    
    cursor.close()
    conn.close()
except Exception as e:
    print(f"Erro ao conectar ao banco de dados: {e}")
