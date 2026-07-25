-- dim_products: one row per product, ready for BI joins.

with products as (
    select * from {{ ref('stg_products') }}
)

select
    product_id,
    product_name,
    category,
    unit_price
from products
