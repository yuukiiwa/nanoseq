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
    
//    output:
//    tuple val(meta), path("*.fastq.gz")   ,emit: nanolyse_fastq
//    path "*.fasta"                          ,emit: fasta
//    path "*.version.txt"                  ,emit: version

    script:
    jaffal_groovy = '/home/wanyk/Downloads/nanoseq/bin/JAFFAL.groovy'
    """
    echo "haha"
    bpipe run $jaffal_groovy /home/wanyk/Downloads/LongReadFusionSimulation/ONT_fus_sim_75err.fastq.gz
    """
}
