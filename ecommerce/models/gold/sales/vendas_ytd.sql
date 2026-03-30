SELECT
    ano_venda,
    mes_venda,
    -- Metricas do mes
    SUM(receita_total) AS receita_mensal,
    SUM(quantidade) AS quantidade_mensal,
    COUNT(DISTINCT id_venda) AS total_vendas_mensal,
    COUNT(DISTINCT id_cliente) AS total_clientes_mensal,
    AVG(receita_total)::NUMERIC(12,2) AS ticket_medio_mensal,
    -- Metricas acumuladas YTD (Year-To-Date)
    SUM(SUM(receita_total)) OVER (
        PARTITION BY ano_venda ORDER BY mes_venda
    ) AS receita_ytd,
    SUM(SUM(quantidade)) OVER (
        PARTITION BY ano_venda ORDER BY mes_venda
    ) AS quantidade_ytd,
    SUM(COUNT(DISTINCT id_venda)) OVER (
        PARTITION BY ano_venda ORDER BY mes_venda
    ) AS total_vendas_ytd,
    -- Crescimento mês a mês (MoM)
    LAG(SUM(receita_total)) OVER (
        PARTITION BY ano_venda ORDER BY mes_venda
    ) AS receita_mes_anterior,
    CASE
        WHEN LAG(SUM(receita_total)) OVER (
            PARTITION BY ano_venda ORDER BY mes_venda
        ) IS NOT NULL AND LAG(SUM(receita_total)) OVER (
            PARTITION BY ano_venda ORDER BY mes_venda
        ) > 0
        THEN ROUND(
            ((SUM(receita_total) - LAG(SUM(receita_total)) OVER (
                PARTITION BY ano_venda ORDER BY mes_venda
            )) / LAG(SUM(receita_total)) OVER (
                PARTITION BY ano_venda ORDER BY mes_venda
            )) * 100, 2
        )
        ELSE NULL
    END AS crescimento_mom_percentual
FROM {{ ref('silver_vendas') }}
GROUP BY ano_venda, mes_venda
ORDER BY ano_venda, mes_venda
