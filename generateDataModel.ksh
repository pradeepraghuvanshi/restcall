#!/usr/bin/ksh
. ./conf/setenv.conf
. ./conf/setclasspath.conf
cd $DATAMODEL_HOME*
ant user -f build.xml
cd $BRM_TOOLS_ROOT

