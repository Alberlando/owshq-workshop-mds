{{ config( materialized='table' ) }}

with cleansed_user as
(
    select * from {{ ref( 'user' ) }}
)

select
    cu.user_id as user_id,
    cu.username as user_name,
    cu.gender as gender,
    json_extract_path_text(TO_JSON(cu.employment), 'title') as title,
    json_extract_path_text(TO_JSON(cu.subscription), 'payment_method') as payment_method
from cleansed_user as cu