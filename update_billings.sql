-- Primeiro, verificar se a tabela billings existe, se não, criá-la
CREATE TABLE IF NOT EXISTS public.billings (
    id uuid NOT NULL,
    user_id uuid,
    plan_id character varying,
    amount character varying NOT NULL,
    currency character varying,
    transaction_id character varying,
    payment_status character varying,
    payment_method character varying,
    payment_date character varying,
    stripe_payment_intent_id character varying,
    stripe_invoice_id character varying,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone,
    PRIMARY KEY (id),
    CONSTRAINT billings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users (id)
);

-- Limpar registros existentes na tabela billings
TRUNCATE TABLE public.billings;

-- Inserir os registros de billings do Supabase
INSERT INTO public.billings (
    id, 
    amount, 
    currency, 
    payment_date, 
    payment_method, 
    payment_status, 
    transaction_id, 
    plan_id, 
    user_id, 
    stripe_invoice_id, 
    stripe_payment_intent_id, 
    created_at, 
    updated_at
) VALUES (
    'a1c7f547-cb84-47b4-8f77-8c7db0b5a193', 
    '99.90', 
    NULL, 
    '2025-03-02 03:13:35.153458+00', 
    NULL, 
    'completed', 
    NULL, 
    '4168b9bb-027d-4985-b227-0d54ed4eff96', 
    'f70cf81c-3d1d-4cf0-8598-91be25d49b1e', 
    NULL, 
    NULL, 
    '2025-03-02 03:13:35.153458+00', 
    NULL
);

-- Verificar se os registros foram inseridos corretamente
SELECT * FROM public.billings;
