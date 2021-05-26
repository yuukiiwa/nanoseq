// Import generic module functions
include { initOptions; saveFiles; getSoftwareName } from './functions'

params.options       = [:]
def options          = initOptions(params.options)

process GET_JAFFAL_REF {
    output:    
    path "28168755"  , emit: ch_jaffal_ref

    script:
    """
    wget https://ndownloader.figshare.com/files/28168755
    """
}
