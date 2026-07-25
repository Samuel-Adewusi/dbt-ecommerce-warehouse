-- Staging model: light cleaning of raw product records.

with source as (
    select * from {{ ref('raw_products') }}
),

cleaned as (
    select
        product_id,
        trim(product_name) as product_name,
        trim(category) as category,
        cast(unit_price as decimal(10, 2)) as unit_price
    from source
)

select * from cleaned
