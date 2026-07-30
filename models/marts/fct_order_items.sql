-- fct_order_items: one row per order line item. This is the grain that
-- product/category-level analysis needs — fct_orders (one row per order)
-- can't answer "revenue by product" since a single order can contain
-- multiple products; this table can, because it carries product_id.

with priced_items as (
    select * from {{ ref('int_order_items_priced') }}
)

select
    order_item_id,
    order_id,
    customer_id,
    product_id,
    order_date,
    quantity,
    unit_price,
    line_amount
from priced_items
