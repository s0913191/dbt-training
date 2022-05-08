{% macro limit_data_in_dev(column_name) %}
{% if target.name == 'development' %}
WHERE {{column_name}} >= dateadd('day', -30, CURRENT_TIMESTAMP)
{% endif %}
{% endmacro %}