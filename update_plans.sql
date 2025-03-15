-- Primeiro, verificar se a tabela plans existe, se não, criá-la
CREATE TABLE IF NOT EXISTS public.plans (
    id uuid NOT NULL,
    name character varying NOT NULL,
    description character varying,
    file_limit integer,
    status character varying,
    stripe_price_id character varying,
    stripe_product_id character varying,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone,
    PRIMARY KEY (id)
);

-- Limpar registros existentes na tabela plans
TRUNCATE TABLE public.plans CASCADE;

-- Inserir os registros dos planos do Supabase
INSERT INTO public.plans (
    id, 
    name, 
    file_limit, 
    status, 
    description, 
    stripe_price_id, 
    stripe_product_id, 
    created_at, 
    updated_at
) VALUES 
(
    '4fb7a959-cd1d-40f3-a73d-e043604b3f0a', 
    'Gratuito', 
    50, 
    'active', 
    'Plano gratuito com recursos básicos para experimentar a plataforma. Inclui análise de código limitada e acesso às funcionalidades essenciais.', 
    NULL, 
    NULL, 
    '2025-02-28 02:11:51.251877+00', 
    NULL
),
(
    '4168b9bb-027d-4985-b227-0d54ed4eff96', 
    'Pro', 
    500, 
    'active', 
    'Plano premium com todos os recursos disponíveis, ideal para grandes equipes e empresas. Inclui análise de código ilimitada, suporte 24/7, todas as integrações e recursos exclusivos.', 
    'price_1Qyh7wKg8Pprice_1QzjDAKg8PaHMKkrdBDOwrh1', 
    'prod_RtWFWVM2bAf4se', 
    '2025-02-28 02:11:51.251877+00', 
    NULL
),
(
    '0bc01dd0-f3f1-48db-88ff-2120e3f68c64', 
    'Standard', 
    500, 
    'active', 
    'Plano intermediário com recursos avançados para equipes pequenas e médias. Inclui análise de código completa, suporte prioritário e integrações extras.', 
    'price_1QzjDCKg8PaHMKkrZNodMeZs', 
    'prod_RtWFJQ3fRXkiPP', 
    '2025-02-28 02:11:51.251877+00', 
    NULL
);

-- Verificar se os registros foram inseridos corretamente
SELECT * FROM public.plans;
