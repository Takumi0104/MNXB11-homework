
#!/bin/bash

usage() {
    echo "----"
    echo "  To call this script please use"
    echo "   $0 '<path-to-datafile>'"
    echo "  Example:"
    echo "   $0 ../data/smhi-opendata_1_52240_20200905_163726.csv"
    echo "----"
}


DATA_RESOURCE=$1

if [[ -z "$DATA_RESOURCE" ]]; then
    echo "Missing input file parameter, exiting."
    usage
    exit 1
else 
    echo "This SHMI is correct."
fi


echo "Here are the first 5 rows of your data:"
head -n 5 "$DATA_RESOURCE"


echo "Enter the column name or number to calculate the average :"
read input


column_number=$(head -n 1 "$DATA_RESOURCE" | tr ';' '\n' | grep -n "^$input$" | cut -d: -f1)

#this script is quoted fom Chat GPT. This function can be output every column number 
if [[ -z "$column_number" ]]; then
    if [[ "$input" =~ ^[0-9]+$ ]]; then
        column_number="$input"
    else
        echo "Column '$input' not found in the CSV file."
        exit 1
    fi
fi

echo "Calculating the average of column $column_number:"


awk -v col="$column_number" -F';' 'NR > 1 { total += $col } END { if (NR > 1) print total / (NR - 1); else print "No data." }' "$DATA_RESOURCE"
