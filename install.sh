#!/bin/bash

OPEN='open_tasks'
CLOSED='closed_tasks'
TEMPLATE='template'
INSTALL_DIR='./'

mkdir $INSTALL_DIR$OPEN
mkdir $INSTALL_DIR$CLOSED

T_BODY="# Move Fast, Be Awesome!!!\n\n# Replace this line with a title\n\nSummary:\n\n\n\n\nAdditional info:\n\n\n\n\n"

printf "$T_BODY" > $INSTALL_DIR$TEMPLATE
