{%- macro binary_ghost(alias, hash) -%}
    {{ adapter.dispatch('binary_ghost', 'dbtvault')(alias=alias, hash=hash) }}
{%- endmacro -%}

{%- macro default__binary_ghost(alias, hash) -%}

    {%- if hash | lower == 'md5' -%}
        {{ dbtvault.cast_binary(column_str='00000000000000000000000000000000', alias=alias, quote=true) }}
    {%- elif hash | lower == 'sha' -%}
        {{ dbtvault.cast_binary(column_str='0000000000000000000000000000000000000000000000000000000000000000', alias=alias, quote=true)}}
    {%- else -%}
        {{ dbtvault.cast_binary(column_str='00000000000000000000000000000000', alias=alias, quote=true) }}
    {%- endif -%}
{%- endmacro -%}

{%- macro sqlserver__binary_ghost(alias, hash) -%}
    {%- if hash | lower == 'md5' -%}
        CAST(REPLICATE(CAST(CAST('0' AS tinyint) AS BINARY(16)), 16) AS BINARY(16)) AS {{ alias }}
	{%- elif hash | lower == 'sha' -%}
        CAST(REPLICATE(CAST(CAST('0' AS tinyint) AS BINARY(32)), 32) AS BINARY(32)) AS {{ alias }}
    {%- else -%}
        CAST(REPLICATE(CAST(CAST('0' AS tinyint) AS BINARY(16)), 16) AS BINARY(16)) AS {{ alias }}
    {%- endif -%}
{%- endmacro -%}
