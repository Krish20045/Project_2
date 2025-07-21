{% macro get_current_quarter() %}
    DATE_PART('quarter', CURRENT_DATE())
{% endmacro %}