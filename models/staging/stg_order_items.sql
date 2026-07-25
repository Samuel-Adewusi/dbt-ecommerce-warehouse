-- Staging model: light cleaning of raw order line items.

with source as (
    select * from {{ ref('raw_order_items') }}
),

cleaned as (
    select
        order_item_id,
        order_id,
        product_id,
        cast(quantity as integer) as quantity
    from source
)

select * from cleaned
