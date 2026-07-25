-- fct_orders: one row per order, aggregating its line items into
-- order-level totals. Grain: one row per order_id.

with priced_items as (
    select * from {{ ref('int_order_items_priced') }}
),

aggregated as (
    select
        order_id,
        customer_id,
        order_date,
        status,
        sum(line_amount) as total_amount,
        sum(quantity) as total_items,
        count(distinct product_id) as distinct_products
    from priced_items
    group by order_id, customer_id, order_date, status
)

select * from aggregated
