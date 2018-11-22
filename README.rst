Example scripts illustrating the use of dtool
=============================================

Generate an *E. coli* reference genome dataset::

    bash create_reference_genome_dataset.sh U00096.3

The above generates the dataset ``Escherichia-coli-ref-genome``.

Generate a *E. coli* reads dataset::

    bash create_ecoli_reads_dataset.sh

The above generates the dataset ``Escherichia-coli-reads-ERR022075``.

Generate a "minified" version of the reads dataset for testing out the
processing script::

    bash minify.sh Escherichia-coli-reads-ERR022075 .

The above generates the dataset ``Escherichia-coli-reads-ERR022075-minified``.

Generate "overlays" to enable processing of the reads (requires the Python packages ``click``, ``dtoolcore`` and ``dtool-cli``)::

    python create_paired_read_overlays_from_fname.py Escherichia-coli-reads-ERR022075
    python create_paired_read_overlays_from_fname.py Escherichia-coli-reads-ERR022075-minified

A simple processing example::

    bash simple_processing.sh Escherichia-coli-reads-ERR022075-minified

A more complex processing example (requires bowtie2)::

    bash bowtie2_align.sh Escherichia-coli-reads-ERR022075-minified Escherichia-coli-ref-genome ./

The above generates the dataset ``bash create_ecoli_reads_dataset.sh``.
