#!/usr/bin/env bash

# Check if two arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <input_pdf> <pages_per_part>"
    exit 1
fi

input_pdf="$1"
pages_per_part="$2"
total_pages=$(pdfinfo "$input_pdf" | grep Pages | awk '{print $2}')

# Loop over the pages in chunks
start_page=1
part_number=1
while [ "$start_page" -le "$total_pages" ]; do
    end_page=$((start_page + pages_per_part - 1))
    if [ "$end_page" -gt "$total_pages" ]; then
        end_page="$total_pages"
    fi

    # Extract the pages
    pdfjam "$input_pdf" --outfile "part${part_number}.pdf" --pages "$start_page-$end_page"
    
    # Update for the next chunk
    start_page=$((end_page + 1))
    part_number=$((part_number + 1))
done

echo "PDF split into $((part_number - 1)) parts."
