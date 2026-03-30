SELECT
    p.id_produto,
    p.nome_produto,
    p.categoria,
    p.marca,
    p.preco_atual::DECIMAL(10,2) AS preco_atual,
    p.data_criacao,
    -- Colunas calculadas
    CASE
        WHEN p.preco_atual::DECIMAL(10,2) > 1000 THEN 'PREMIUM'
        WHEN p.preco_atual::DECIMAL(10,2) > 500 THEN 'MEDIO'
        ELSE 'BASICO'
    END AS faixa_preco
FROM {{ ref('bronze_produtos') }} p
