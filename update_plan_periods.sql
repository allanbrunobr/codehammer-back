-- Primeiro, verificar se a tabela plan_periods existe, se não, criá-la
CREATE TABLE IF NOT EXISTS public.plan_periods (
    id uuid NOT NULL,
    plan_id uuid NOT NULL,
    period_id uuid NOT NULL,
    price numeric NOT NULL,
    currency character varying NOT NULL,
    stripe_price_id character varying,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone,
    PRIMARY KEY (id),
    CONSTRAINT plan_periods_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.plans (id),
    CONSTRAINT plan_periods_period_id_fkey FOREIGN KEY (period_id) REFERENCES public.periods (id)
);

-- Limpar registros existentes na tabela plan_periods
TRUNCATE TABLE public.plan_periods;

-- Inserir os registros dos plan_periods do Supabase
INSERT INTO public.plan_periods (
    id, 
    plan_id, 
    period_id, 
    price, 
    currency, 
    stripe_price_id, 
    created_at, 
    updated_at
) VALUES 
(
    '2eb29d7d-2688-4ddc-84bb-7f0ca3a462b2', 
    '4fb7a959-cd1d-40f3-a73d-e043604b3f0a', 
    'ddc3f894-a68d-4763-962f-954ca3457968', 
    0, 
    'BRL', 
    NULL, 
    '2025-02-28 02:13:28.818503+00', 
    NULL
),
(
    '01b9fb99-71f0-461c-9bf3-27c9e2a2aa63', 
    '0bc01dd0-f3f1-48db-88ff-2120e3f68c64', 
    '2e8e9e14-70a8-4522-908d-855216acbf29', 
    134.73, 
    'BRL', 
    'price_1QzjDBKg8PaHMKkrsVBnmY2B', 
    '2025-02-28 02:13:28.818503+00', 
    NULL
),
(
    '0e250b5a-e8e8-431f-aec9-796734bfe1ca', 
    '0bc01dd0-f3f1-48db-88ff-2120e3f68c64', 
    '97a95920-192d-4c4f-b552-3d9a59c6ca50', 
    239.52, 
    'BRL', 
    'price_1QzjDBKg8PaHMKkrY8lXcOTl', 
    '2025-02-28 02:13:28.818503+00', 
    NULL
),
(
    '0f1267f7-4211-4794-8386-442f0b456e9e', 
    '4168b9bb-027d-4985-b227-0d54ed4eff96', 
    'ddc3f894-a68d-4763-962f-954ca3457968', 
    99.9, 
    'BRL', 
    'price_1QzjDAKg8PaHMKkrdBDOwrh1', 
    '2025-02-28 02:13:28.818503+00', 
    NULL
),
(
    '7a2ec236-e313-4ec1-928b-4f805e71d58c', 
    '4168b9bb-027d-4985-b227-0d54ed4eff96', 
    '97a95920-192d-4c4f-b552-3d9a59c6ca50', 
    479.52, 
    'BRL', 
    'price_1QzjDAKg8PaHMKkrCyBsWF17', 
    '2025-02-28 02:13:28.818503+00', 
    NULL
),
(
    'af35c7fd-5860-414d-adfe-b23b81cc135f', 
    '0bc01dd0-f3f1-48db-88ff-2120e3f68c64', 
    'ddc3f894-a68d-4763-962f-954ca3457968', 
    49.9, 
    'BRL', 
    'price_1QzjDCKg8PaHMKkrZNodMeZs', 
    '2025-02-28 02:13:28.818503+00', 
    NULL
),
(
    'b1304631-6430-476f-91ff-2fc8547caaeb', 
    '4168b9bb-027d-4985-b227-0d54ed4eff96', 
    '2e8e9e14-70a8-4522-908d-855216acbf29', 
    269.73, 
    'BRL', 
    'price_1QzjDAKg8PaHMKkrOHlWk6QP', 
    '2025-02-28 02:13:28.818503+00', 
    NULL
);

-- Verificar se os registros foram inseridos corretamente
SELECT * FROM public.plan_periods;
