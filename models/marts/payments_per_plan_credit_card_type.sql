{{ config(materialized='table') }}

with cleansed_subscription as 
(
    select * from {{ ref( 'cleansed_subscription' ) }}
),

cleansed_payments as
(
    select * from {{ ref( 'cleansed_payments' ) }}
),

payments_per_plan_credit_card_type as
(
    select
        subs.plan,
        pmts.credit_card_type,
        sum(pmts.subscription_price) as total_price
    from cleansed_payments as pmts
    inner join cleansed_subscription as subs
        on pmts.user_id = subs.user_id
    group by 1, 2
    order by 1 asc, 3 desc
)

select * from payments_per_plan_credit_card_type