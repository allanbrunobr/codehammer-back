-- Primeiro, verificar se a tabela periods existe, se não, criá-la
CREATE TABLE IF NOT EXISTS public.periods (
    id uuid NOT NULL,
    name character varying NOT NULL,
    months integer NOT NULL,
    discount_percentage integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone,
    PRIMARY KEY (id)
);

-- Limpar registros existentes na tabela periods
TRUNCATE TABLE public.periods CASCADE;

-- Inserir os registros dos períodos do Supabase
INSERT INTO public.periods (
    id, 
    name, 
    months, 
    discount_percentage, 
    created_at, 
    updated_at
) VALUES 
(
    'ddc3f894-a68d-4763-962f-954ca3457968', 
    'monthly', 
    1, 
    0, 
    '2025-02-28 02:10:21.92911+00', 
    NULL
),
(
    '2e8e9e14-70a8-4522-908d-855216acbf29', 
    'quarterly', 
    3, 
    10, 
    '2025-02-28 02:10:21.92911+00', 
    NULL
),
(
    '97a95920-192d-4c4f-b552-3d9a59c6ca50', 
    'semiannual', 
    6, 
    20, 
    '2025-02-28 02:10:21.92911+00', 
    NULL
);

-- Verificar se os registros foram inseridos corretamente
SELECT * FROM public.periods;
