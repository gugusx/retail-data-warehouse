{% macro create_indexes(relation, indexes) %}
    {% for index in indexes %}
        CREATE INDEX IF NOT EXISTS {{ index.name }}
        ON {{ relation }} ({{ index.column }});
    {% endfor %}
{% endmacro %}
