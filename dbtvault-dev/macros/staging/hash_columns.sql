{%- macro hash_columns(columns=none, columns_to_escape=none) -%}

    {{- adapter.dispatch('hash_columns', 'dbtvault')(columns=columns, columns_to_escape=columns_to_escape) -}}

{%- endmacro %}

{%- macro default__hash_columns(columns=none, columns_to_escape=none) -%}

{%- if columns is mapping and columns is not none -%}

    {%- for col in columns -%}

        {%- if columns[col] is mapping and columns[col].is_hashdiff -%}

            {{- dbtvault.hash(columns=columns[col]['columns'],
                              alias=col,
                              is_hashdiff=columns[col]['is_hashdiff'],
                              columns_to_escape=columns_to_escape) -}}

        {%- elif columns[col] is not mapping -%}

            {{- dbtvault.hash(columns=columns[col],
                              alias=col,
                              is_hashdiff=false,
                              columns_to_escape=columns_to_escape) -}}

        {%- elif columns[col] is mapping and not columns[col].is_hashdiff -%}

            {%- if execute -%}
                {%- do exceptions.warn("[" ~ this ~ "] Warning: You provided a list of columns under a 'columns' key, but did not provide the 'is_hashdiff' flag. Use list syntax for PKs.") -%}
            {% endif %}

            {{- dbtvault.hash(columns=columns[col]['columns'], alias=col, columns_to_escape=columns_to_escape) -}}

        {%- endif -%}

        {{- ",\n\n" if not loop.last -}}
    {%- endfor -%}

{%- endif %}
{%- endmacro -%}
