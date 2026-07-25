-- dim_customers: one row per customer, ready for BI joins.

with customers as (
    select * from {{ ref('stg_customers') }}
)

select
    customer_id,
    first_name,
    last_name,
    first_name || ' ' || last_name as full_name,
    email,
    region,
    signup_date
from customers
