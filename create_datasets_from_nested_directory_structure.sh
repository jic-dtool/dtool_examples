#!/bin/bash

# Script to automate the generation of datasets.

# Exit on first error.
set -e

# Read in the input from the command line.
INPUT_DIR=$1
BASE_README_FILE=$2
SUBDIR_1_METADATA_KEY=$3
SUBDIR_2_METADATA_KEY=$4
OUTPUT_DIR=$5

if [ ! -d $INPUT_DIR ]; then
    echo "Not a directory: $INPUT_DIR"
    exit 1
fi

if [ ! -f $BASE_README_FILE ]; then
    echo "Not a file: $BASE_README_FILE"
    exit 1
fi

if [ ! -d $OUTPUT_DIR ]; then
    echo "Not a directory: $OUTPUT_DIR"
    exit 1
fi


for SUBDIR_1 in `ls $INPUT_DIR`; do
    SUBDIR_1_PATH=$INPUT_DIR/$SUBDIR_1

    # Skip anything that is not a directory.
    if ! [ -d $SUBDIR_1_PATH ]; then
        continue
    fi
    
    for SUBDIR_2 in `ls $SUBDIR_1_PATH`; do
        SUBDIR_2_PATH=$SUBDIR_1_PATH/$SUBDIR_2

        # Skip anything that is not a directory.
        if ! [ -d $SUBDIR_2_PATH ]; then
            continue
        fi

        DS_NAME="$SUBDIR_1-$SUBDIR_2"
        URI=`dtool create -q --symlink-path $SUBDIR_2_PATH $DS_NAME $OUTPUT_DIR`
        echo "URI $URI"

        # Create temporary readme file.
        TMP_README=$(mktemp ~/tmp-dtool-readme.XXXXXX)

        echo "description: $SUBDIR_1 $SUBDIR_2 data" > $TMP_README
        cat $BASE_README_FILE >> $TMP_README
        echo "$SUBDIR_1_METADATA_KEY: $SUBDIR_1" >> $TMP_README
        echo "$SUBDIR_2_METADATA_KEY: $SUBDIR_2" >> $TMP_README

        dtool readme write $URI $TMP_README

        # Clean up temporary readme file.
        rm $TMP_README

        dtool freeze $URI
    done
        
done

