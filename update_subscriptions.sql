-- Primeiro, verificar se a tabela subscriptions existe, se não, criá-la
CREATE TABLE IF NOT EXISTS public.subscriptions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    plan_id uuid NOT NULL,
    stripe_subscription_id character varying,
    status character varying NOT NULL,
    auto_renew boolean,
    remaining_file_quota integer,
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone,
    PRIMARY KEY (id),
    CONSTRAINT subscriptions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users (id),
    CONSTRAINT subscriptions_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.plans (id)
);

-- Limpar registros existentes na tabela subscriptions
TRUNCATE TABLE public.subscriptions;

-- Inserir o registro da assinatura do Supabase
INSERT INTO public.subscriptions (
    id, 
    status, 
    start_date, 
    end_date, 
    remaining_file_quota, 
    auto_renew, 
    plan_id, 
    user_id, 
    stripe_subscription_id, 
    created_at, 
    updated_at
) VALUES (
    'a4e36568-8afa-436e-a01a-0034448125c6', 
    'active', 
    '2025-03-01 18:46:41.845742', 
    '2026-03-01 18:46:41.845742', 
    401, 
    true, 
    '4168b9bb-027d-4985-b227-0d54ed4eff96', 
    'f70cf81c-3d1d-4cf0-8598-91be25d49b1e', 
    NULL, 
    '2025-03-01 18:46:41.845742+00', 
    '2025-03-14 05:07:37.860967+00'
);

-- Verificar se o registro foi inserido corretamente
SELECT * FROM public.subscriptions;
