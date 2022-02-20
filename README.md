### DE Zoomcamp 4.3.1 - Build the First dbt Models


### Macro: create the function in sql format
1. 
- ```bash
{% macro get_payment_type_description(payment_type) -%}
    case {{ payment_type }}
        when 1 then 'Credit card'
        when 2 then 'Cash'
        when 3 then 'No charge'
        when 4 then 'Dispute'
        when 5 then 'Unknown'
        when 6 then 'Voided trip'
    end
{%- endmacro %}
```

2. 
- ```bash
{{ get_payment_type_description('payment_type') }} as payment_type_description, 
```

### Import: import the dbt library in packages.yml under root directory
1. run the command to download all the dependency from packages.yml
- ```bash dbt deps```

2. 
- ```bash {{ dbt_utils.surrogate_key(['vendorid', 'tpep_pickup_datetime']) }} as tripid```

### Seed:
1. taxi_zone_lookup.csv
2. run the command to creare the table in google big query
- ```bash dbt seed```
- ```bash dbt seed --full-refresh (full refresh the current table)```
3. define the column type in dbt_project.yml
