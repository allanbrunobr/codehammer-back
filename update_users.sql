-- Primeiro, verificar se a tabela users existe, se não, criá-la
CREATE TABLE IF NOT EXISTS public.users (
    id uuid NOT NULL,
    name character varying NOT NULL,
    email character varying NOT NULL,
    firebase_uid character varying,
    stripe_customer_id character varying,
    language character varying,
    country character varying,
    recovery_token character varying,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone,
    PRIMARY KEY (id)
);

-- Limpar registros existentes na tabela users
TRUNCATE TABLE public.users CASCADE;

-- Inserir o registro do usuário do Supabase
INSERT INTO public.users (
    id, 
    name, 
    email, 
    recovery_token, 
    country, 
    language, 
    firebase_uid, 
    stripe_customer_id, 
    created_at, 
    updated_at
) VALUES (
    'f70cf81c-3d1d-4cf0-8598-91be25d49b1e', 
    'Allan Bruno', 
    'allanbruno@gmail.com', 
    NULL, 
    NULL, 
    NULL, 
    '51uJzT0odZXaOT2wf2FCsr42GJ62', 
    NULL, 
    '2025-02-16 02:38:16.980516+00', 
    '2025-03-05 13:17:53.194545+00'
);

-- Verificar se o registro foi inserido corretamente
SELECT * FROM public.users;
