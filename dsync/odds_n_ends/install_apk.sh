# no shebang because the location for the shell on the PC and the phone are different

# Simple script to install one or more apk files on an Android phone 
#
# The script can run either on the phone or on a PC with a connected phone
#
# Usage on a phone:
#
# install_apk.sh [apk1|dir1 ... apk#|dir#]
#
# Usage on a PC:
#
# install_apk.sh [options_for_adb --] [apk1|dir1 ... apk#|dir#]
#
# apk# is the name of an apk file to install; dir# is a directory with apk files
# If a parameter is a directory the script will install all files with the extension .apk from that directory
#
# The options for adb are optional; the script will not check the options for adb
# the number of apk files or directories is only limited by the  maxium parameter supported by the used shell.
#
# Set the variable PM_INSTALL_OPTIONS with additional options for the "pm install" command before starting the
# script if neccessary
#
# Prerequisites
#   The packages to install must exist as file either on the PC or on the phone
#   A shell on the phone or via adb command is required
#   No root access is neccessary
#
# Note
#
# The script will not check for duplicate parameter
#
# History
#   04.07.2022 /bs
#     initial release
#
#   04.08.2022 /bs
#     fixed a minor bug (ERROR: The file "" does not exist or is not readable)
#
#   08.01.2023 /bs
#     the script now ends with a return code not zero if one or more apps could not be found or could not be installed
#
#   24.12.2023 /bs
#     added a hint to the error message about how to ignore outdated SDKs if using Android 14 or newer
#
#   04.02.2024 /bs
#     replaced "LogMsg" with "echo" (the function LogMsg is not defined in this script)
#
#   02.05.2024 /bs
#     the script failed to handle symbolic links correct -- fixed
#

# constants
#
__TRUE=0
__FALSE=1

# for debugging
#
#PREFIX="echo"
#PREFIX=""

typeset THISRC=${__TRUE}

# check if we're running on a phone
#
CUR_PHONE_MODEL="$(  getprop ro.product.odm.model 2>/dev/null )"
CUR_PHONE_SERIAL="$( getprop ro.serialno 2>/dev/null )"

if [ "${CUR_PHONE_SERIAL}"x != ""x ] ; then
  SCRIPT_IS_RUNNING_ON_A_PHONE=${__TRUE}
else
  SCRIPT_IS_RUNNING_ON_A_PHONE=${__FALSE}
fi

# check for the usage parameter
#  
if [ "$1"x = "-h"x -o "$1"x = "--help"x  -o $# -eq 0 ] ; then
  if [ ${SCRIPT_IS_RUNNING_ON_A_PHONE} = ${__TRUE} ] ; then
    echo "Script Usage on a phone: $0 [apk1|dir# ... apk#|dir#]"
  else
    echo "Script Usage on a PC: $0 [options_for_adb --] [apk1|dir1 ... apk#|dir#]"
  fi
 
  exit 1
fi

# default : Android Version unknown
#
ANDROID_VERSION=0
 
if [ ${SCRIPT_IS_RUNNING_ON_A_PHONE} = ${__TRUE} ] ; then
  echo "Running on a phone"

  ADB_COMMAND=""

  if [[ $* == *--* ]] ; then
    echo "ERROR: adb parameter are not supported if running on a phone"
    exit 6
  fi

  ANDROID_VERSION="$( getprop ro.build.version.release )"

else
  echo "Running on a PC"
  ADB="$( which adb 2>/dev/null )"
  if [ "${ADB}"x = ""x ] ; then
    echo "ERROR: adb executable not found"
    exit 5
  fi

  ADB_OPTIONS=""

  ANDROID_VERSION="$( adb shell getprop ro.build.version.release )"
  
# get the parameter for adb if any 
#
  if [[ $* == *--* ]] ; then
    while [ $# -ne 0 ] ; do
      CUR_PARAMETER="$1"
      shift
      [ "${CUR_PARAMETER}"x = "--"x ] && break
      
      ADB_OPTIONS="${ADB_OPTIONS} ${CUR_PARAMETER}"
    done
  fi

  if [ "${ADB_OPTIONS}"x != ""x ] ; then
    echo "Using adb with the options \"${ADB_OPTIONS} \" to install the packages "
  else
    echo "Using adb to install the packages"
  fi    
  
  ADB_COMMAND="${ADB} ${ADB_OPTIONS} shell "
  
  CUR_OUTPUT="$( ${ADB_COMMAND} uname -a 2>&1 )"
  if [ $? -ne 0 ] ; then
    echo "${CUR_OUTPUT}"
    echo ""
    echo "ERROR: No connected phone found"
    exit 100
  fi

  CUR_PHONE_MODEL="$( ${ADB_COMMAND} getprop ro.product.odm.model 2>/dev/null )"
  CUR_PHONE_SERIAL="$( ${ADB_COMMAND} getprop ro.serialno 2>/dev/null )"
fi

# init the global variables
#   
APKS_INSTALLED=""
NO_OF_APKS_INSTALLED=0

APKS_NOT_INSTALLED=""
NO_OF_APKS_NOT_INSTALLED=0

APKS_NOT_FOUND=""
NO_OF_APKS_NOT_FOUND=0

# check for directories in the parameter
#
APKS_TO_INSTALL=""

for CUR_PARAMETER in $* ; do
  if [ -d "${CUR_PARAMETER}"  ] ; then
    echo "Directory found in the parameter: Installing all apk files found in the directory \"${CUR_PARAMETER}\" "
    APKS_TO_INSTALL="${APKS_TO_INSTALL} $( find ${CUR_PARAMETER} -name "*.apk"  )"
  else
    APKS_TO_INSTALL="${APKS_TO_INSTALL} 
${CUR_PARAMETER}"
  fi
  shift
done

echo "The apks will be installed on the phone model ${CUR_PHONE_MODEL} with the serial number ${CUR_PHONE_SERIAL} "

echo "Installing these apks "
echo ""
echo "${APKS_TO_INSTALL}"
echo ""

if [ "${PM_INSTALL_OPTIONS}"x != ""x ] ; then
  echo "The additional parameter for the command \"pm install\" are: \"${PM_INSTALL_OPTIONS}\" "
fi

echo "${APKS_TO_INSTALL}
##EXIT##" | while read CUR_APK ; do
  
  if [ "${CUR_APK}"x = "##EXIT##"x ] ; then
#
# ##EXIT## is the end marker
#
# the while loop is running in a sub shell so that the variables used for the statistics are not available outside the sub shell
# the construct with the subshell is used to support filenames with whitespaces
#
  
    echo ""
    echo "Installation summary"
    echo "===================="

    if [ ${NO_OF_APKS_INSTALLED} != 0 ] ; then
      echo ""
      echo "${NO_OF_APKS_INSTALLED} package(s) successfully installed:"
      echo "${APKS_INSTALLED}"
      echo ""
    fi

    if [ ${NO_OF_APKS_NOT_INSTALLED} != 0 ] ; then
      echo ""
      echo "${NO_OF_APKS_NOT_INSTALLED} package(s) not installed:"
      echo "${APKS_NOT_INSTALLED}"
      echo ""

      if [  ${ANDROID_VERSION} -ge 14 ] ; then 

        echo "-" "Note:
To ignore the error about outdated SDKs, e.g.
:
\"Failure [INSTALL_FAILED_DEPRECATED_SDK_VERSION: App package must target at least SDK version 23, but found 19]\"

set the environment variable PM_INSTALL_OPTIONS to \"--bypass-low-target-sdk-block\" before starting the script.
"
      fi

      THISRC=${__FALSE}
    fi

    if [ ${NO_OF_APKS_NOT_FOUND} != 0 ] ; then
      echo ""
      echo "${NO_OF_APKS_NOT_FOUND} package(s) not found:"
      echo "${APKS_NOT_FOUND}"
      echo ""
      THISRC=${__FALSE}
    fi
  
    break
  fi
  
  echo ""
  [ "${CUR_APK}"x = ""x ] && continue
  if [ ! -r "${CUR_APK}" ] ; then
    echo "ERROR: The file \"${CUR_APK}\" does not exist or is not readable"
    APKS_NOT_FOUND="${APKS_NOT_FOUND} 
${CUR_APK}"
    (( NO_OF_APKS_NOT_FOUND = NO_OF_APKS_NOT_FOUND +1 ))
    continue
  fi

  CUR_APK_SIZE="$( ls -lL "${CUR_APK}" | awk '{ print $5 }' )"
  echo "Installing the apk \"${CUR_APK}\" ..."
  cat "${CUR_APK}" | ${PREFIX} ${ADB_COMMAND} pm install ${PM_INSTALL_OPTIONS} -S ${CUR_APK_SIZE}
#
  if [ $? -eq 0 ] ; then
    echo "\"${CUR_APK}\" succcessfully installed"

    APKS_INSTALLED="${APKS_INSTALLED} 
${CUR_APK}"
    (( NO_OF_APKS_INSTALLED = NO_OF_APKS_INSTALLED +1 ))
  else
    echo "ERROR: Error installing the apk  \"${CUR_APK}\" "

    APKS_NOT_INSTALLED="${APKS_NOT_INSTALLED} 
${CUR_APK}"
    (( NO_OF_APKS_NOT_INSTALLED = NO_OF_APKS_NOT_INSTALLED +1 ))

  fi
  
done

echo ""

exit ${THISRC}
