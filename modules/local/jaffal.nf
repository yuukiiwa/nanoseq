// Import generic module functions
include { initOptions; saveFiles; getSoftwareName } from './functions'

params.options = [:]
def options    = initOptions(params.options)

process JAFFAL {
//    tag "$meta.id"
    echo true
    label 'process_medium'
    publishDir "${params.outdir}",
        mode: params.publish_dir_mode,
        saveAs: { filename -> saveFiles(filename:filename, options:params.options, publish_dir:getSoftwareName(task.process), publish_id:'') }

//    conda     (params.enable_conda ? "bioconda::nanolyse=1.2.0" : null)
    container "docker.io/yuukiiwa/jaffa:2.0"

//    input:
//    tuple val(meta), path(fastq)
//    path nanolyse_fasta
    
    output:
//    tuple val(meta), path("*.fastq.gz")   ,emit: nanolyse_fastq
//    path "*.fasta"                          ,emit: fasta
//    path "*.version.txt"                  ,emit: version

    script:
    """
    echo "haha"
    bpipe run /Users/yukkei/add_mod/nanoseq/bin/JAFFAL.groovy /Users/yukkei/add_mod/demo/data/HEK293T-WT-rep1/fastq/HEK293T-WT-rep1.fastq.gz
    """
}
