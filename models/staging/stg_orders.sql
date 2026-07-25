-- Staging model: cleans raw order headers and standardizes status values,
-- which arrive from the source system in inconsistent casing
-- (e.g. "Completed", "completed", "PENDING").

with source as (
    select * from {{ ref('raw_orders') }}
),

cleaned as (
    select
        order_id,
        customer_id,
        cast(order_date as date) as order_date,
        lower(trim(status)) as status
    from source
)

select * from cleaned
