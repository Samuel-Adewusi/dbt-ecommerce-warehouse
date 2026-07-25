-- Intermediate model: joins order items to products and orders so each
-- line item carries its computed dollar amount, order date, customer,
-- and order status. This is the join logic that fct_orders will aggregate.

with order_items as (
    select * from {{ ref('stg_order_items') }}
),

products as (
    select * from {{ ref('stg_products') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

joined as (
    select
        order_items.order_item_id,
        order_items.order_id,
        orders.customer_id,
        orders.order_date,
        orders.status,
        order_items.product_id,
        products.category as product_category,
        order_items.quantity,
        products.unit_price,
        order_items.quantity * products.unit_price as line_amount
    from order_items
    left join products
        on order_items.product_id = products.product_id
    left join orders
        on order_items.order_id = orders.order_id
)

select * from joined
