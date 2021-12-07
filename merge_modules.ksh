#!/usr/bin/sh
if [ $# -lt 1 ]; then
     echo "usage: $0 <merge_module> <module1> [<module2> ...]\nOptions:\n<merge_module>, <module1> ...\t as absolute path "
     exit 1
fi

COMMON_RULES_XML="commonrules.xml"
COMMON_ERRORS_XML="commonerrors.xml"
COMMON_FIELDS_XML="commonfields.xml"

. ./conf/setenv.conf

HOME_DIR=$BRM_TOOLS_ROOT/brmtools
MERGE_DIR=$1
echo "Merging modules into $MERGE_DIR"
mkdir -p $MERGE_DIR
shift

# Common Files (Header)
echo '<?xml version="1.0"?>\n<rules>' > $MERGE_DIR/$COMMON_RULES_XML
echo '<?xml version="1.0"?>\n<errors>' > $MERGE_DIR/$COMMON_ERRORS_XML
echo '<?xml version="1.0"?>\n<fields>' > $MERGE_DIR/$COMMON_FIELDS_XML

#
#cp schema/specifications.xsd $MERGE_DIR

for MODULE in $*
do
    echo "Processing Module $MODULE"
    cd $MODULE
  
    for SOURCE in * ; do
  
    echo 'Scanning' $SOURCE
   
    if [ $SOURCE = $COMMON_RULES_XML ]; then
       echo 'Merging' $SOURCE
       cd $HOME_DIR      
       cat $MODULE/$COMMON_RULES_XML |  grep -v '<?xml version="1.0"' | grep -v '<rules' | grep -v 'rules>' >> $MERGE_DIR/$COMMON_RULES_XML
       cd -
    elif [ $SOURCE = $COMMON_ERRORS_XML ]; then
       echo 'Merging' $SOURCE
       cd $HOME_DIR  
       cat $MODULE/$COMMON_ERRORS_XML | grep 'error>' >> $MERGE_DIR/$COMMON_ERRORS_XML   
       cd -   
    elif [ $SOURCE = $COMMON_FIELDS_XML ]; then 
       echo 'Merging' $SOURCE
       cd $HOME_DIR  
       cat $MODULE/$COMMON_FIELDS_XML | grep -v '<?xml version="1.0"' | grep -v '<fields' | grep -v 'fields>'>> $MERGE_DIR/$COMMON_FIELDS_XML
       cd $HOME_DIR 
    else
       echo 'Copying' $SOURCE
       cd $HOME_DIR      
       cp $MODULE/$SOURCE $MERGE_DIR
       cd -
    fi

    done    

done

# Common Files (Footer)
echo '</rules>' >> $MERGE_DIR/$COMMON_RULES_XML
echo '</errors>' >>$MERGE_DIR/$COMMON_ERRORS_XML
echo '</fields>' >>$MERGE_DIR/$COMMON_FIELDS_XML
