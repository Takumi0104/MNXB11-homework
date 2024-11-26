#!/bin/bash

##################
# filter.sh
#  ROOT_presentation
#  Created by Negoro Takumi on 2024/11/22.
###################

FILTER_SCRIPTNAME=`basename $0`

#Define usage function which indicates the error
#usage
usage(){

    echo "___________"
    echo " To call this script, use:"
    echo "  $0 <path-to-datafile>"
    echo " Example:"
    echo " $0../data/smhi-opendata_1....csv"
    echo "---------"
}

#log
createlog(){
    FILTER_DATE=`date +%F`
    FILTER_LOGFILE=${FILTER_DATE}_${FILTER_SCRIPTNAME}.log
    touch $FILTER_LOGFILE
    if [[ $? != 0 ]]; then
    echo "cannot write logfile, exiting" 1>&2
    exit 1
    
    fi
    echo "Redirecting cleaner log to $FILTER_LOGFILE"
}

#logging utility
log(){
    if [[ "xFILTER_LOGFILE" == " x " ]]; then
    echo "Undefined variable FILTER_LOGFILE, please check code: createlog() missing. Exiting" 1>&2
    
    exit 1
    fi
    FILTER_LOGMESSAGE=$1
    FILTER_LOGTIMESTAMP=`date -Iseconds`
# Create timestamped message
    FILTER_OUTMESSAGE="[${FILTER_LOGTIMESTAMP} Cleaner]: $FILTER_LOGMESSAGE"
# Output to screen
    echo $FILTER_OUTMESSAGE
# Output to file
    echo $FILTER_OUTMESSAGE >> ${FILTER_LOGFILE}
}

##################END##############

#Exit immediately if the smhicleaner.sh script is not found

if [ ! -f 'cleaner.sh' ]; then
   echo "cleaner.sh script not found in $PWD. Cannot continue. Exiting"
   exit 1
fi
 
# Create logfile
createlog

# Get the first parameter from the command line:
# and put it in the variable FILTER_SOURCE
FILTER_SOURCE=$1

# Input parameter validation:
# Check that the variable FILTER_SMHIINPUT is defined, if not,
# inform the user, show the script usage by calling the usage()
# function in the library above and exit with error

if [[ "x$FILTER_SOURCE" == 'x' ]]; then
   echo "Missing input file parameter, exiting" 1>&2
   usage
   exit 1
fi

#Extract filename:

FILTER_DATAFILE=$(basename $FILTER_SOURCE)
# Call cleaner

log "Calling cleaner.sh script"
./cleaner.sh $FILTER_SOURCE

if [[ $? != 0 ]]; then
   echo "cleaner.sh failed, exiting..." 1>&2
   exit 1
fi

# smhicleaner.sh generates a filename that starts with baredata_<datafilename>
# So storing it in a variable for convenience.
CLEANER_BAREDATAFILENAME="baredata_$FILTER_DATAFILE"
CLEANER_BAREDATAFILENAME_CHOOSING_TWO_COLUMNS="final_baredata_$FILTER_DATAFILE"
log "Begin filtering..."

#the section of the choosing two columns

   echo "----------------------"
   echo "--CHOOSING COLUMN-----"
   echo "whcih column do you want to choose?"
   read user_input_column1
   echo "you also have to choose another column"
   read user_input_column2
   echo " now cleaning... you chose column $user_input_column1 and column $user_input_column2"

# construct the data that we chose the above process by using awk command

awk -v field1="$user_input_column1" -v field2="$user_input_column2" '{print $field1, $field2}' $CLEANER_BAREDATAFILENAME > $CLEANER_BAREDATAFILENAME_CHOOSING_TWO_COLUMNS

echo "This is the list of data what you chose the two columns"
cat $CLEANER_BAREDATAFILENAME_CHOOSING_TWO_COLUMNS
echo "--------------END DATA--------------------"


#define the two variables which does the data restriction
#cut command to pick up only the line info (check the output of echo command!)

    echo "----------------------"
    echo "--START LINE SECTION--"
    echo "Which year do you want to start?(Format YYYY-MM-DD):"
    read user_input_START
    echo "You chose this : $user_input_START"
    echo "--END LINE SECTION----"
    echo "Which year do you want to finish?(Format YYYY-MM-DD):"
    read user_input_END
    echo "You chose this : $user_input_END"
STARTLINE=$(grep -n $user_input_START $CLEANER_BAREDATAFILENAME_CHOOSING_TWO_COLUMNS|cut -d':' -f 1) #good working

ENDLINE=$(grep -n $user_input_END $CLEANER_BAREDATAFILENAME_CHOOSING_TWO_COLUMNS|cut -d ':' -f 1) #good working

echo "filter system will pick up the data from line $STARTLINE
to line $ENDLINE."

FILENAME=FILTER_from"$user_input_START"_to_"$user_input_END"
head -n $ENDLINE $CLEANER_BAREDATAFILENAME_CHOOSING_TWO_COLUMNS |tail +$STARTLINE > $FILENAME
# error log
#1./filter.sh: line 109: $CLEANER_BAREDATAFILENAME_CHOOSING_TWO_COLUMNS: ambiguous redirect
#I didn't define the variable $CLEANER_BAREDATAFILENAME_CHOOSING_TWO_COLUMNS

#2 awk: illegal field $(user_input_column2), name "field2"
# input record number 1, file baredata_original_Jonkoping_Airport74460.csv
# source line number 1
#
#3 command not found
#line137 > bad definition of the variable
#the difference between ",'
