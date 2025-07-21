{% macro calculate_profit_margin(profit, revenue) %}
    ROUND(
        CASE 
            WHEN {{ revenue }} > 0 
            THEN ({{ profit }} / {{ revenue }}) * 100
            ELSE 0
        END, 2
    )
{% endmacro %}