#!/bin/bash
cd "`dirname "$0"`"
../../../bin/mxmlc ./Main.as -static-link-runtime-shared-libraries -managers=flash.fonts.AFEFontManager -use-network=false -debug=true
ERRORLEVEL=$?
if [ $ERRORLEVEL -eq 0 ]
then
  echo 
  echo ----------------------INSTRUCTIONS----------------------
  echo Compiled, now running...
  echo Type \"continue\" - no quotes - followed by return to start
  echo   Note: May need to entry \"continue\" command twice
  echo Type \"quit\" - no quotes - followed by return key to exit
  echo 
  echo
  ../../../bin/fdb ./Main.swf
else
  echo 
  echo -------------------INSTRUCTIONS-------------------
  if [ $ERRORLEVEL -eq 1 ]
  then
    echo Found $ERRORLEVEL error during compilation
  else
    echo Found $ERRORLEVEL errors during compilation
  fi
  echo Fix the errors indicated above then try this again.
  echo 
  echo
fi

echo
echo Done. Feel free to close this window.
echo