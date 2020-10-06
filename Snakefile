##### load rules #####

include: "rules/common.smk"
include: "rules/trim.smk"
include: "rules/align.smk"
include: "rules/diffexp.smk"
#include: "rules/qc.smk"

import pandas as pd
from snakemake.utils import validate, min_version
##### set minimum snakemake version #####
min_version("5.1.2")

##### target rules #####

def all_input(wildcards):
	wanted_input = []
	wanted_input.extend(
		expand(["results/star/{sample}-{unit}Aligned.out.bam"], sample=units["sample"],unit=units["unit"])
	)
	return wanted_input

rule all:
    input: all_input
		#expand(["star/{sample}-{unit}/Aligned.out.bam"])
		#expand(["results/diffexp/{contrast}.diffexp.tsv",
        #        "results/diffexp/{contrast}.ma-plot.svg"],
        #       contrast=config["diffexp"]["contrasts"]),
        #"results/pca.svg",
        #"qc/multiqc_report.html"


##### setup singularity #####

# this container defines the underlying OS for each job when using the workflow
# with --use-conda --use-singularity
singularity: "docker://continuumio/miniconda3"


##### setup report #####

report: "report/workflow.rst"
