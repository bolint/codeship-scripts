#!/bin/bash
# Deploy the recently modified files via FTP.
#
# Add the following environment variables to your project configuration.
# Make sure your remote dir does not end with a slash unless you want your copy to live in a subdirectory called modifiedFiles.
# Also make sure your remote dir already exists before trying your first deployment.
# * FTP_USER
# * FTP_PASSWORD
# * FTP_HOST
# * TARGET_DIR

mkdir ${HOME}/modifiedFiles
git diff -z --name-only HEAD~5 HEAD | xargs -0 -IREPLACE rsync -azPR --ignore-missing-args REPLACE ${HOME}/modifiedFiles/
lftp -c "open -u $FTP_USER,$FTP_PASSWORD $FTP_HOST; set ssl:verify-certificate no; mirror -R ${HOME}/modifiedFiles/ $TARGET_DIR"
