# Declare variables
## source texts (ST)
# ST=~/Dropbox/PhD/TraDiCorp/ad/vrt
ST=st/vrt

## translations (TT)
# TT=~/Dropbox/PhD/TraDiCorp/tt/vrt2
TT=tt/vrt

## directory to store encoded corpus for ST
OUTST=st/encoded

## directory to store encoded corpus for ST
OUTTT=tt/encoded

## directory where the registry is located
REGISTRY=registry

## name of ST corpus in registry
STRNAME="example-st"

## name of TT corpus in registry
TTRNAME="example-tt"

## name of ST corpus
STCNAME=$(echo $STRNAME | tr "[:lower:]" "[:upper:]")

## name of TT corpus
TTCNAME=$(echo $TTRNAME | tr "[:lower:]" "[:upper:]")

## alignments
#ALIGN=./alignments.txt
ALIGN=alignments/alignments.txt

#--------------------

# encode source texts
mkdir -p $OUTST
rm $REGISTRY/$STRNAME
rm -R $OUTST/*
cwb-encode -c utf8 -d $OUTST -F $ST -R $REGISTRY/$STRNAME -xsB -S text:0+id+st+type+lang -S div:0+id -S p:0+id -S s:0+id -P pos -P lemma
cwb-make -r $REGISTRY -V $STCNAME

#--------------------

# encode translations
mkdir -p $OUTTT
rm $REGISTRY/$TTRNAME
rm -R $OUTTT/*
cwb-encode -c utf8 -d $OUTTT -F $TT -R $REGISTRY/$TTRNAME -xsB -S text:0+id+st+type+lang -S div:0+id -S p:0+id -S s:0+id -P pos -P lemma
cwb-make -r $REGISTRY -V $TTCNAME

#------------------------------

# import the sentence alignment
## from source to target
cwb-align-import -r $REGISTRY -nh -e -v -l1 $STCNAME -l2 $TTCNAME -s s -k {id} $ALIGN
## from target to source
cwb-align-import -r $REGISTRY -nh -i -e -v -l1 $STCNAME -l2 $TTCNAME -s s -k {id} $ALIGN

#------------------------------
