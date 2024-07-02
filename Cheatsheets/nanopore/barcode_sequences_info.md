# Nanopore barcode sequences info
Current as of 2nd June 2024

## Native Barcode Sequences 
The first 24 unique barcodes are available in the Native Barcoding Kit 24 V14
(SQK-NBD114.24). The Native Barcoding Kit 96 V14 (SQK-NBD114.96) include the
first 24 native barcodes, with the additional 72 unique barcodes. The native
barcodes are shipped at 640 nM.

In addition to the barcodes, there are also flanking sequences which add an extra level of context during analysis.

Forward sequence: 5' - AAGGTTAA - barcode - CAGCACCT - 3'
Reverse sequence: 5' - GGTGCTG - barcode - TTAACCTTAGCAAT - 3'

Julia code to scrape barcode sequences from [nanopores website](https://community.nanoporetech.com/technical_documents/chemistry-technical-document/v/chtd_500_v1_revaq_07jul2016/barcode-sequences) and output in CSV.
```julia
using Cascadia, HTTP, DataFrames, CSV

url = "https://community.nanoporetech.com/technical_documents/chemistry-technical-document/v/chtd_500_v1_revaq_07jul2016/barcode-sequences"

http_url = HTTP.get(url)
http_string = parsehtml(String(http_url.body))
http_string_body = http_string.root[2]

tables = eachmatch(sel"table", http_string_body)

tmp_df = DataFrame(barcode=[], forward_seq=[], reverse_seq=[])

for barcodes in tables[1][2].children
    push!(tmp_df.barcode, barcodes[1][1].text)
    push!(tmp_df.forward_seq, barcodes[2][1].text)
    push!(tmp_df.reverse_seq, barcodes[3][1].text)
end

CSV.write(<output>, tmp_df)

#Confirm it's written to file
run(`head <output>`)
CSV.read(<output>, DataFrames)

# For the rapid barcode sequences just modify the dataframe slightly and change the loop

tmp_df = DataFrame(barcode=[], sequence=[])

for barcodes in tables[2][2].children
    push!(tmp_df.barcode, barcodes[1][1].text)
    push!(tmp_df.sequence, barcodes[2][1].text)
end
```


## Rapid barcode sequences

There is a full list of the rapid barcode sequences used across the rapid-based barcoding kits, with the component acronym for the specific sequencing kit. The barcodes in our rapid-based kits are shipped at 10 µM.

Note: These are not the full sequences due to proprietory information.

In addition to the barcodes, there are also flanking sequences which add an extra level of context during analysis.

## Rapid barcoding kits

Rapid Barcoding Kit 24 V14 (SQK-RBK114.24): RB01-24
Rapid Barcoding Kit 96 V14 (SQK-RBK114.96): RB01-96
Legacy: Rapid Barcoding Kit (SQK-RBK004): RB01-12
Rapid Barcoding Kit 96 (SQK-RBK110.96): RB01-96

Barcode flanking sequence:
5' - GCTTGGGTGTTTAACC - barcode - GTTTTCGCATTTATCGTGAAACGCTTTCGCGTTTTTCGTGCGCCGCTTCA - 3'

## PCR barcoding kits

PCR-cDNA Barcoding Kit 24 V14 (SQK-PCB114.24): BP01-24
Legacy PCR-cDNA Barcoding Kit 24 (SQK-PCB111.24): BP01-24
Legacy: PCR-cDNA Barcoding Kit (SQK-PCB109): BP01-12
Legacy: PCR Barcoding Kit (SQK-PBK004): BP01-12

Barcode flanking sequence:
Top strand: 5' - ATCGCCTACCGTGA - barcode - TTGCCTGTCGCTCTATCTTC - 3'
Bottom strand: 5' - ATCGCCTACCGTGA - barcode - TCTGTTGGTGCTGATATTGC - 3'

The top and bottom barcode flanking sequences are different to avoid 5' and 3' end sequences annealing to each other and forming a loop.

16S barcoding kits
16S Barcoding Kit 24 V14 (SQK-16S114.24): 16S01-24
Legacy 16S Barcoding Kit 1-24 (SQK-16S024): 16S01-24
Legacy: 16S Barcoding Kit (SQK-RAB204): 16S01-12

Barcode flanking sequence:
Forward 16S primer: 5' - ATCGCCTACCGTGAC - barcode - AGAGTTTGATCMTGGCTCAG - 3'
Reverse 16S primer: 5' - ATCGCCTACCGTGAC - barcode - CGGTTACCTTGTTACGACTT - 3'

The 3' flanking sequence of the forward primer contains a wobble base (denoted by M; in the primer the base is either an A or a C) in a variable region of the 16S gene.

## Rapid PCR barcoding kits

Rapid PCR Barcoding Kit 24 V14 (SQK-RPB114.24): RLB01-24
Legacy: Rapid PCR Barcoding Kit (SQK-RPB004): RLB01-12A

Barcode flanking sequence:
5' - ATCGCCTACCGTGAC - barcode - CGTTTTTCGTGCGCCGCTTC - 3'

PCR barcoding expansions
PCR Barcoding Expansion 1-12 (EXP-PBC001): BC01-12
PCR Barcoding Expansion 1-96 (EXP-PBC096): BC01-96

Barcode flanking sequence:
5' - GGTGCTG - barcode - TTAACCT - 3'

