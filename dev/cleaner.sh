#!/bin/bash
#  cleaner.sh
# ROOT_presentation
#  Created by Negoro Takumi on 2024/11/22.
##################Function###########################

#Comment
#basename:extract the base file name from a given path by removing the path up to and including the last slash(/)
#Summarize remove up to the last slash
#``(classic form): command substitution reassigns the output of a commands
#Memorize script name
CLEANER_SCRIPTNAME=`basename $0`

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
    CLEANER_DATE=`date +%F`
    CLEANER_LOGFILE=${CLEANER_DATE}_${CLEANER_SCRIPTNAME}.log
    touch $CLEANER_LOGFILE
    if [[ $? != 0 ]]; then
    echo "cannot write logfile, exiting" 1>&2
    exit 1
    
    fi
    echo "Redirecting cleaner log to $CLEANER_LOGFILE"
}

#logging utility
log(){
    if [[ "x$CLEANER_LOGFILE" == " x " ]]; then
    echo "Undefined variable CLEANER_LOGFILE, please check code: createlog() missing. Exiting" 1>&2
    
    exit 1
    fi
    CLEANER_LOGMESSAGE=$1
    CLEANER_LOGTIMESTAMP=`date -Iseconds`
# Create timestamped message
    CLEANER_OUTMESSAGE="[${CLEANER_LOGTIMESTAMP} Cleaner]: $CLEANER_LOGMESSAGE"
# Output to screen
    echo $CLEANER_OUTMESSAGE
# Output to file
    echo $CLEANER_OUTMESSAGE >> ${CLEANER_LOGFILE}
}

##################END##############


######CREATING TWO TYPES OF FILES: ORIGINAL DATA FILE AND BARE DATA FILE######
#Create logfile
createlog

#call the error function
# Define the variable
#Source: get from the command-line
DATA_RESOURCE=$1
#my own created if statement
if [[ -z "$DATA_RESOURCE" ]]; then
    echo "Missing input file parameter, exiting"
   usage
   exit 1
else
    echo "Finding input file parameter, keep doing the clean process"
fi


# original statement
#if [[ x$DATA_RESOURCE == x ]]; then
#    echo "Missing input file parameter, exiting"
#    usage
#    exit 1
#else
#
#fi


#extract filename
CLEANER_DATAFILE=$(basename $DATA_RESOURCE)
# Pre-define names for output files in variables so that they can be
# used everywhere in the code

CLEANER_ORIGINALFILENAME="original_${CLEANER_DATAFILE}"
CLEANER_BAREDATAFILENAME="baredata_${CLEANER_DATAFILE}"
FINAL_CLEANER_BAREDATAFILENAME="final_baredata_${CLEANER_DATAFILE}"
#Analyze the input parameter and copy

if [[ "x$DATA_RESOURCE" != "x" ]]; then
   #Check if the file is a directory, it should not be!
   if [[ -d $DATA_RESOURCE ]]; then
      echo -e "This script requires a data file and not a directory, exiting..." 1>&2
      exit 1
   fi
   #Copy the file in the current directory as
   #    original_$CLEANER_DATAFILE
   log "Copying input file $DATA_RESOURCE to $CLEANER_ORIGINALFILENAME"
   cp -a $DATA_RESOURCE $CLEANER_ORIGINALFILENAME
   # Capture copy errors
   CLEANER_COPY_OUTCOME=$?
fi

#Check that the input file has been copied with no errors:
if [[ $CLEANER_COPY_OUTCOME != 0 ]]; then
   echo "Error downloading or copying file, check filename or command syntax. Exiting...." 1>&2
   usage
   exit 1
fi

######CLEANING PROCESS######

#Identify the data starting line by inserting the keywords and to realize more confortable and usable script

# using read command to input the variable interactively.
    echo "------"
    echo "What key word do you want to search?:"
    read user_input
    echo "You chose the this word: $user_input"
    echo "It starts to clean your data!"

    
log "Finding the first line containing $user_input ..."

STARTLINE=$(grep -n $user_input $CLEANER_ORIGINALFILENAME | cut -d ':' -f 1)

log "Found line $STARTLINE"
echo $STARTLINE
STARTLINE=$(( $STARTLINE + 1 ))

log "Perform cleanup in one line, result in $CLEANER_BAREDATAFILENAME"

# I WANT TO CONVERT THIS CSV FILE WHICH WE HAVE CLEANED TO ROOT FILE
#ACCORDING TO ROOT, THERE ARE SOME RULES TO READ THIS FILE CORRECTOLY BY ROOT
#
tail -n +$STARTLINE $CLEANER_ORIGINALFILENAME | cut -d';' -f 1,2,3,4,5 | sed 's/,/./g' | sed 's/;/ /g' > $CLEANER_BAREDATAFILENAME

