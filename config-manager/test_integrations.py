#!/usr/bin/env python3
import os
import sys
import psycopg2
import urllib.parse
from uuid import UUID
from dotenv import load_dotenv

# Carregar variáveis de ambiente do arquivo .env
load_dotenv()

# Obter a URL do banco de dados da variável de ambiente
db_url = os.getenv("DATABASE_URL")
if not db_url:
    print("ERROR: DATABASE_URL environment variable not found!")
    print("Make sure you have a .env file with DATABASE_URL defined.")
    sys.exit(1)

print(f"Database URL: {db_url.split(':')[0]}://{db_url.split('@')[0].split(':')[1]}:****@{db_url.split('@')[1]}")

try:
    # Extrair componentes da URL
    parts = db_url.split('@')
    if len(parts) == 2:
        auth_part = parts[0]
        host_part = parts[1]
        
        # Extrair usuário e senha
        auth_parts = auth_part.split('://')
        if len(auth_parts) == 2:
            protocol = auth_parts[0]
            user_pass = auth_parts[1]
            
            # Separar usuário e senha
            user_pass_parts = user_pass.split(':')
            if len(user_pass_parts) == 2:
                username = user_pass_parts[0]
                password = user_pass_parts[1]
                
                # Extrair host, porta e nome do banco
                host_parts = host_part.split('/')
                if len(host_parts) >= 2:
                    host_port = host_parts[0].split(':')
                    host = host_port[0]
                    port = host_port[1] if len(host_port) > 1 else "5432"
                    dbname = host_parts[1].split('?')[0]
                    
                    print(f"Connecting to PostgreSQL database:")
                    print(f"  Host: {host}")
                    print(f"  Port: {port}")
                    print(f"  Database: {dbname}")
                    print(f"  User: {username}")
                    
                    # Conectar ao banco de dados
                    conn = psycopg2.connect(
                        host=host,
                        port=port,
                        dbname=dbname,
                        user=username,
                        password=password
                    )
                    
                    print("Connection successful!")
                    
                    # Criar cursor
                    cur = conn.cursor()
                    
                    # Testar consulta simples
                    print("\nTesting simple query:")
                    cur.execute("SELECT 1")
                    result = cur.fetchone()
                    print(f"  Result: {result}")
                    
                    # Listar tabelas
                    print("\nListing tables:")
                    cur.execute("""
                        SELECT table_name 
                        FROM information_schema.tables 
                        WHERE table_schema = 'public'
                    """)
                    tables = cur.fetchall()
                    for table in tables:
                        print(f"  - {table[0]}")
                    
                    # Verificar se a tabela de integrações existe
                    if ('integrations',) in tables:
                        print("\nTable 'integrations' found!")
                        
                        # Listar colunas da tabela integrations
                        print("\nListing columns of 'integrations' table:")
                        cur.execute("""
                            SELECT column_name, data_type 
                            FROM information_schema.columns 
                            WHERE table_name = 'integrations'
                        """)
                        columns = cur.fetchall()
                        for column in columns:
                            print(f"  - {column[0]} ({column[1]})")
                        
                        # Contar registros na tabela integrations
                        print("\nCounting records in 'integrations' table:")
                        cur.execute("SELECT COUNT(*) FROM integrations")
                        count = cur.fetchone()[0]
                        print(f"  Total records: {count}")
                        
                        # Listar todas as integrações
                        if count > 0:
                            print("\nListing all integrations:")
                            cur.execute("""
                                SELECT id, name, user_id, repository, repository_url 
                                FROM integrations
                            """)
                            integrations = cur.fetchall()
                            for integration in integrations:
                                print(f"  - ID: {integration[0]}")
                                print(f"    Name: {integration[1]}")
                                print(f"    User ID: {integration[2]}")
                                print(f"    Repository: {integration[3]}")
                                print(f"    Repository URL: {integration[4]}")
                                print()
                    else:
                        print("\nTable 'integrations' not found!")
                    
                    # Fechar cursor e conexão
                    cur.close()
                    conn.close()
                    print("\nConnection closed.")
                    
except Exception as e:
    print(f"Error: {str(e)}")
    sys.exit(1)
