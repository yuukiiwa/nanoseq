// Import generic module functions
include { initOptions; saveFiles; getSoftwareName } from './functions'

params.options = [:]
def options    = initOptions(params.options)

process XPORE_DATAPREP {
    tag "$meta.id"
    label 'process_medium'
    publishDir "${params.outdir}",
        mode: params.publish_dir_mode,
        saveAs: { filename -> saveFiles(filename:filename, options:params.options, publish_dir:'rna_modification/dataprep', publish_id:meta.id) }

 //   conda     (params.enable_conda ? "bioconda::nanopolish==0.13.2" : null) // need to get xpore onto conda
    container "docker.io/yuukiiwa/xpore:1.0"

    input:
    tuple val(meta), path(genome), path(gtf), path(eventalign), path(nanopolish_summary)
    
    output:
    tuple val(meta), path("$meta.id"), emit: dataprep_outputs

    script:
    """
    xpore-dataprep \\
    --eventalign $eventalign \\
    --summary $nanopolish_summary \\
    --out_dir $meta.id \\
    --genome --gtf_path_or_url $gtf --transcript_fasta_paths_or_urls $genome \\
    --annotation_name $gtf --reference_name $genome
    """
}
