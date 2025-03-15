import os
from sqlalchemy import create_engine
from dotenv import load_dotenv

# Carregar variáveis de ambiente do arquivo .env
load_dotenv()

# Obter a URL do banco de dados
DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://postgres:postgres@localhost:5433/codehammer")
print(f"URL do banco de dados: {DATABASE_URL}")

try:
    # Tentar criar uma conexão com o banco de dados
    engine = create_engine(DATABASE_URL)
    connection = engine.connect()
    print("Conexão com o banco de dados estabelecida com sucesso!")
    
    # Testar uma consulta simples
    from sqlalchemy.sql import text
    result = connection.execute(text("SELECT 1")).fetchone()
    print(f"Resultado da consulta de teste: {result}")
    
    connection.close()
except Exception as e:
    print(f"Erro ao conectar ao banco de dados: {e}")
