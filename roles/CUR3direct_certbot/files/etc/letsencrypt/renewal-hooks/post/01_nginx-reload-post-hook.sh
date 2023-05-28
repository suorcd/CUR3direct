#!/usr/bin/env bash
#
# Certbot Nginx Reload
#
# Let's Encrypt Certbot post hook command for Nginx which checks the updated
# configuration files and reloads the server if everything validates.
#
# Author   : Justin Hartman <code@justinhartman.co>
# Version  : 1.0.1
# License  : MIT <https://opensource.org/licenses/MIT>
# Readme   : https://git.io/JtMvL
# Copyright: Copyright (c) 2021 Justin Hartman <https://justinhartman.co>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

#######################################
# Output coloured messages based on a
# set of arguments.
# Globals:
#   None
# Arguments:
#   String  info, success, warning,
#           danger, or none
# Returns:
#   String  printf styled message
#######################################
cprint() {
    if [ "$2" == "info" ]; then
        COLOR="96m"
    elif [ "$2" == "success" ]; then
        COLOR="92m"
    elif [ "$2" == "warning" ]; then
        COLOR="93m"
    elif [ "$2" == "danger" ]; then
        COLOR="91m"
    else #default color
        COLOR="0m"
    fi

    STARTCOLOR="\e[$COLOR"
    ENDCOLOR="\e[0m"

    printf "$STARTCOLOR%b$ENDCOLOR" "$1"
}

#######################################
# Define log file variable and check to
# see if an old file should be deleted.
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   String  cprint method output
#######################################
logfile() {
    NGINX_RELOAD_LOG=/tmp/nginx_reload.log

    if [[ -f "$NGINX_RELOAD_LOG" ]]; then
        cprint "Removing old log file.\n" "warning"
        /bin/rm -f "$NGINX_RELOAD_LOG"
    fi
}

#######################################
# Main script method to process the
# application thread.
# Globals:
#   None
# Arguments:
#   None
# Returns:
#   String  cprint method outputs
main() {
    # Cleanup and load log file.
    logfile

    # Check if the nginx config file is OK.
    nginx -t &>"$NGINX_RELOAD_LOG"

    if grep -q 'test failed' "$NGINX_RELOAD_LOG"; then
        cprint "Fail: Error with config file.\n" "danger"
        cprint "Aborting nginx restart.\n" "danger"
        cprint "Log file output:\n" "info"
        cat "$NGINX_RELOAD_LOG"
        exit 1
    elif grep -q 'test is successful' "$NGINX_RELOAD_LOG"; then
        cprint "Success: Reloading nginx server.\n" "success"
        systemctl reload nginx
    fi
}

# Load the main method.
main
# Exit gracefully.
exit 0