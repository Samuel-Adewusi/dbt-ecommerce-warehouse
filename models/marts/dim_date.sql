-- dim_date: one row per calendar day, generated with dbt_utils.date_spine
-- so this works identically on DuckDB (local/CI) and BigQuery (production)
-- without adapter-specific date-generation syntax.

with date_spine as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2026-01-01' as date)",
        end_date="cast('2027-01-01' as date)"
    ) }}
),

final as (
    select
        cast(date_day as date) as date_day,
        extract(year from date_day) as year,
        extract(month from date_day) as month,
        extract(day from date_day) as day_of_month,
        extract(dayofweek from date_day) as day_of_week,
        case extract(dayofweek from date_day)
            when 0 then 'Sunday'
            when 1 then 'Monday'
            when 2 then 'Tuesday'
            when 3 then 'Wednesday'
            when 4 then 'Thursday'
            when 5 then 'Friday'
            when 6 then 'Saturday'
        end as day_name,
        extract(dayofweek from date_day) in (0, 6) as is_weekend
    from date_spine
)

select * from final
