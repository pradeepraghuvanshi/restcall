#!/usr/bin/ksh
. ./conf/setenv.conf
. ./conf/setclasspath.conf
cd $DOCGENERATOR_HOME*
ant -f build.xml
cd $BRM_TOOLS_ROOT