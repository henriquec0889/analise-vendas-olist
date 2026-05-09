-- ================================================
-- ANÁLISE DE VENDAS — E-COMMERCE OLIST
-- Queries de análise exploratória
-- Banco: SQLite | Tabela: olist (dataset mesclado)
-- ================================================

-- Pergunta 1: Quais os 10 produtos mais vendidos?
SELECT
    product_category_name,
    COUNT(*) as total_vendas
FROM olist
WHERE order_status = 'delivered'
GROUP BY product_category_name
ORDER BY total_vendas DESC
LIMIT 10;

-- Pergunta 2: Qual cliente mais gastou?
SELECT
    customer_id,
    ROUND(SUM(payment_value), 2) as total_gasto
FROM olist
WHERE order_status = 'delivered'
GROUP BY customer_id
ORDER BY total_gasto DESC
LIMIT 10;

-- Pergunta 3: Qual mês teve o maior faturamento?
SELECT
    strftime('%Y-%m', order_purchase_timestamp) as ano_mes,
    ROUND(SUM(payment_value), 2) as faturamento
FROM olist
WHERE order_status = 'delivered'
GROUP BY ano_mes
ORDER BY faturamento DESC
LIMIT 10;

-- Pergunta 4: Qual vendedor tem maior ticket médio?
SELECT
    seller_id,
    COUNT(DISTINCT order_id) as total_pedidos,
    ROUND(SUM(payment_value) / COUNT(DISTINCT order_id), 2) as ticket_medio
FROM olist
WHERE order_status = 'delivered'
GROUP BY seller_id
HAVING total_pedidos >= 10
ORDER BY ticket_medio DESC
LIMIT 10;

-- Pergunta 5: Qual o estado com maior número de pedidos?
SELECT
    customer_state,
    COUNT(DISTINCT order_id) as total_pedidos,
    ROUND(SUM(payment_value), 2) as faturamento_total
FROM olist
WHERE order_status = 'delivered'
GROUP BY customer_state
ORDER BY total_pedidos DESC;

-- Pergunta 6: Qual a forma de pagamento mais utilizada?
-- Usa CTE para desduplicar: um pedido pode ter múltiplos métodos de pagamento
WITH pagamentos_unicos AS (
    SELECT DISTINCT order_id, payment_type, payment_value, payment_installments
    FROM olist
    WHERE order_status = 'delivered'
)
SELECT
    payment_type,
    COUNT(*) as total_pedidos,
    ROUND(SUM(payment_value), 2) as valor_total,
    ROUND(AVG(payment_installments), 1) as media_parcelas
FROM pagamentos_unicos
GROUP BY payment_type
ORDER BY total_pedidos DESC;

-- Pergunta 7: Qual a nota média de avaliação por categoria?
SELECT
    product_category_name,
    COUNT(DISTINCT order_id)          as total_pedidos,
    ROUND(AVG(review_score_medio), 2) as nota_media
FROM olist
WHERE order_status = 'delivered'
  AND review_score_medio IS NOT NULL
GROUP BY product_category_name
ORDER BY nota_media DESC
LIMIT 15;

-- Pergunta 8: Qual a performance de entrega? (no prazo vs atrasado)
WITH entregas AS (
    SELECT DISTINCT
        order_id,
        order_delivered_customer_date,
        order_estimated_delivery_date
    FROM olist
    WHERE order_status = 'delivered'
      AND order_delivered_customer_date IS NOT NULL
      AND order_estimated_delivery_date IS NOT NULL
)
SELECT
    CASE
        WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 'No prazo'
        ELSE 'Atrasado'
    END as status_entrega,
    COUNT(*) as total_pedidos,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) as percentual,
    ROUND(AVG(
        julianday(order_delivered_customer_date) - julianday(order_estimated_delivery_date)
    ), 1) as media_dias_variacao
FROM entregas
GROUP BY status_entrega
ORDER BY total_pedidos DESC;
