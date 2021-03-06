#!/usr/bin/env bash
cd /media/stef/teradata/analysis/machine-learning/nlp/document-classification/FT
MODELDIR=model/sup
PRETRAINMODELDIR=model/unsup
DATADIR=data
N=$1


mkdir -p "${MODELDIR}"
mkdir -p "${DATADIR}"

##	INFO
cmd="fasttext supervised -input "${DATADIR}/mlstr.all" -output "${MODELDIR}/modelsup$N" -dim 75 -lr .5 -wordNgrams 3 -minCount 1 -bucket 1000000 -epoch 20 -thread 6 -lrUpdateRate 1000 -label tag_  -ws 20  -minCountLabel 1 -minn 5 -pretrainedVectors ${PRETRAINMODELDIR}/model_skipgram.char1.vec"

echo TRAINING: 
echo $cmd
eval $cmd

echo TESTS
cmdt="fasttext test ${MODELDIR}/modelsup$N.bin ${DATADIR}/mlstr.test"
echo $cmdt
eval $cmdt

echo VALIDATION
cmdv="fasttext test ${MODELDIR}/modelsup$N.bin ${DATADIR}/mlstr.validation"
echo $cmdv
eval $cmdv



