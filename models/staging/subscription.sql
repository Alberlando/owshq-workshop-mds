{{ config( materialized='view' ) }}

with src_subscription as 
(
    select * 
    from public.workspace_subscription
) 

select
    sb.user_id,
    sb.plan,
    sb.status,
    sb.payment_term,
    sb.payment_method,
    sb.subscription_term
from src_subscription as sb