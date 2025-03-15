import os
import psycopg2
from urllib.parse import quote_plus
from dotenv import load_dotenv

# Carregar variáveis de ambiente do arquivo .env
load_dotenv()

# Obter a URL do banco de dados
db_url = os.getenv("DATABASE_URL")
print(f"URL do banco de dados: {db_url}")

# Parâmetros de conexão
host = "aws-0-us-west-1.pooler.supabase.com"
port = "5432"
dbname = "postgres"
user = "postgres.rwptfpwqnjaghvkzjukx"
password = quote_plus("M3t4tr0nArcanjo")  # Codificar a senha

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
    
    # Verificar se o usuário existe na tabela users
    cursor = conn.cursor()
    cursor.execute("SELECT id, email FROM users WHERE email = %s", ("allanbruno@gmail.com",))
    user_result = cursor.fetchone()
    
    if user_result:
        print(f"Usuário encontrado na tabela users:")
        print(f"  ID: {user_result[0]}")
        print(f"  Email: {user_result[1]}")
        
        # Verificar se o usuário tem uma assinatura
        cursor.execute("SELECT id, plan_id, remaining_file_quota FROM subscriptions WHERE user_id = %s", (user_result[0],))
        subscription_result = cursor.fetchone()
        
        if subscription_result:
            print(f"Assinatura encontrada:")
            print(f"  ID: {subscription_result[0]}")
            print(f"  Plano ID: {subscription_result[1]}")
            print(f"  Quota restante: {subscription_result[2]}")
            
            # Verificar detalhes do plano
            cursor.execute("SELECT id, name, file_limit FROM plans WHERE id = %s", (subscription_result[1],))
            plan_result = cursor.fetchone()
            
            if plan_result:
                print(f"Plano encontrado:")
                print(f"  ID: {plan_result[0]}")
                print(f"  Nome: {plan_result[1]}")
                print(f"  Limite de arquivos: {plan_result[2]}")
            else:
                print("Plano não encontrado!")
        else:
            print("Usuário não tem assinatura!")
    else:
        print("Usuário não encontrado na tabela users!")
        
        # Listar todos os usuários para verificar
        print("\nListando todos os usuários:")
        cursor.execute("SELECT id, email FROM users LIMIT 10")
        users = cursor.fetchall()
        
        for user in users:
            print(f"  ID: {user[0]}, Email: {user[1]}")
    
    cursor.close()
    conn.close()
except Exception as e:
    print(f"Erro: {str(e)}")
