{% macro add_primary_key(table, column) %}
    ALTER TABLE {{ table }} ADD PRIMARY KEY ({{ column }});
{% endmacro %}
