SELECT
    v.id_venda,
    v.id_cliente,
    v.id_produto,
    v.quantidade,
    v.preco_unitario::DECIMAL(10,2) AS preco_venda,
    v.data_venda,
    v.canal_venda,
    -- Colunas calculadas
    v.quantidade * v.preco_unitario::DECIMAL(10,2) AS receita_total,
    -- Classificação de preço
    CASE
        WHEN v.preco_unitario::DECIMAL(10,2) < 50 THEN 'Barato'
        WHEN v.preco_unitario::DECIMAL(10,2) >= 50 AND v.preco_unitario::DECIMAL(10,2) < 300 THEN 'Médio'
        ELSE 'Caro'
    END AS faixa_preco,
    -- Dimensoes temporais
    DATE(v.data_venda::timestamp) AS data_venda_date,
    EXTRACT(YEAR FROM v.data_venda::timestamp) AS ano_venda,
    EXTRACT(MONTH FROM v.data_venda::timestamp) AS mes_venda,
    EXTRACT(DAY FROM v.data_venda::timestamp) AS dia_venda,
    EXTRACT(DOW FROM v.data_venda::timestamp) AS dia_semana,
    EXTRACT(HOUR FROM v.data_venda::timestamp) AS hora_venda
FROM {{ ref('bronze_vendas') }} v