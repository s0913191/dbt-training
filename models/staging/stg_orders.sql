SELECT
--FROM RAW ORDERS
{{ dbt_utils.surrogate_key(['o.orderid', 'c.customerid', 'p.productid']) }} AS sk_orders
, o.orderid
, o.orderdate
, o.shipdate
, o.shipmode
, o.ordersellingprice - o.ordercostprice AS orderprofit
, o.ordercostprice
, o.ordersellingprice
--FROM RAW CUSTOMER
, c.customerid
, c.customername
, c.segment
, c.country
--FROM RAW PRODUCT
, p.productid
, p.category
, p.productname
, p.subcategory
, {{ markup('ordersellingprice', 'ordercostprice') }} AS markup
--FROM DELIVERY TEAM
, d.delivery_team
FROM {{ ref('raw_orders') }} AS o
LEFT JOIN {{ ref('raw_customer') }} AS c
ON o.customerid = c.customerid
LEFT JOIN {{ ref('raw_product') }} AS p
ON o.productid = p.productid
LEFT JOIN {{ ref('delivery_team') }} AS d
ON o.shipmode = d.shipmode