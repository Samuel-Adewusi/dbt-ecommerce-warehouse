-- Staging model: light cleaning of raw customer records.
-- No business logic here — just type-casting, trimming, and standardizing.

with source as (
    select * from {{ ref('raw_customers') }}
),

cleaned as (
    select
        customer_id,
        trim(first_name) as first_name,
        trim(last_name) as last_name,
        nullif(trim(lower(email)), '') as email,
        cast(signup_date as date) as signup_date,
        trim(region) as region
    from source
)

select * from cleaned
