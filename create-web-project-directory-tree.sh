#!/bin/bash

tb=`tput bold`
tn=`tput sgr0`

## Is YES condition.
isyes () { [[ $1 = @(Y|y|Yes|yes) ]]; }
br () { printf "\r\n"; }
warnmsgterm () { br; printf "$tb WARNING!$tn You have terminated the process!"; br; exit; }
warnmsgcanc () { br; printf "$tb WARNING!$tn You have canceled the process!"; br; exit; }
warnmsgunex () { br; printf "$tb WARNING!$tn Something went wrong!"; br; exit; }

## Catch CTRL+C and inform about it.
trap warnmsgterm SIGINT

printf "@ Launch process?\n"
read -p "(Enter: Yes/yes/Y/y or No/no/N/n): " result

launch=0
if isyes "$result"; then
    launch=1
else
    warnmsgcanc
fi

br
printf "###########################################################\n"
printf "# Create directory tree and initial files for web project #\n"
printf "###########################################################\n"
br

if [[ ! -d "$HOME/www/projects/" ]]; then
    printf "# No initial directory found, creating...\n"
    mkdir -p "$HOME/www/projects/"
    printf "# Directory created, continuing...\n"
    br
fi

name=0
while [[ "$name" -eq 0 ]]
do
    read -p "Enter name of the project(Use only lowercase letters (a-z) and '-' symbol): " pname
    if [[ $pname = +([-[:alpha:]]) ]]; then
        name=1
    else
        printf "# You have eneterd wrong symbol in project name, try again!\n"
    fi
done



## Change ownership and set permissions to web server log files.
createall () {

    msgsuccess () { printf "\n$tb SUCCESS:$tn Directory tree and initial files for the project $tb$pname$tn has been created successfuly!\n"; }
    msgfail () { printf "\n$tb FAIL:$tn Directory tree and initial files for the project $tb$pname$tn has$tb NOT$tn been created!\n"; }

    printf "\n@ Do you want to create a project with a name $tb$pname$tn?\n"
    read -p "(Enter: Yes/yes/Y/y or No/no/N/n): " result

    if isyes "$result"; then

        cd "$HOME/www/projects"
        mkdir "$pname"/

        mkdir -p "$pname"/void/root/public/
        mkdir "$pname"/void/logs/
        touch "$pname"/void/logs/p_"$pname"_void_nginx_access.log
        touch "$pname"/void/logs/p_"$pname"_void_nginx_error.log
        touch "$pname"/void/logs/p_"$pname"_void_httpd_access.log
        touch "$pname"/void/logs/p_"$pname"_void_httpd_error.log
        printf "$pname void" > "$pname"/void/root/public/index.html

        mkdir -p "$pname"/prod/root/public/
        mkdir "$pname"/prod/logs/
        touch "$pname"/prod/logs/p_"$pname"_prod_nginx_access.log
        touch "$pname"/prod/logs/p_"$pname"_prod_nginx_error.log
        touch "$pname"/prod/logs/p_"$pname"_prod_httpd_access.log
        touch "$pname"/prod/logs/p_"$pname"_prod_httpd_error.log
        printf "$pname prod" > "$pname"/prod/root/public/index.html

        mkdir -p "$pname"/dev/root/public/
        mkdir "$pname"/dev/logs/
        touch "$pname"/dev/logs/p_"$pname"_dev_nginx_access.log
        touch "$pname"/dev/logs/p_"$pname"_dev_nginx_error.log
        touch "$pname"/dev/logs/p_"$pname"_dev_httpd_access.log
        touch "$pname"/dev/logs/p_"$pname"_dev_httpd_error.log
        printf "$pname dev" > "$pname"/dev/root/public/index.html

        mkdir -p "$pname"/test/root/public/
        mkdir "$pname"/test/logs/
        touch "$pname"/test/logs/p_"$pname"_test_nginx_access.log
        touch "$pname"/test/logs/p_"$pname"_test_nginx_error.log
        touch "$pname"/test/logs/p_"$pname"_test_httpd_access.log
        touch "$pname"/test/logs/p_"$pname"_test_httpd_error.log
        printf "$pname test" > "$pname"/test/root/public/index.html

        mkdir -p "$pname"/sbox/root/public/
        mkdir "$pname"/sbox/logs/
        touch "$pname"/sbox/logs/p_"$pname"_sbox_nginx_access.log
        touch "$pname"/sbox/logs/p_"$pname"_sbox_nginx_error.log
        touch "$pname"/sbox/logs/p_"$pname"_sbox_httpd_access.log
        touch "$pname"/sbox/logs/p_"$pname"_sbox_httpd_error.log
        printf "$pname sbox" > "$pname"/sbox/root/public/index.html

        printf "\n@ Do you want to create a folder tree for an old version of a project?\n"
        read -p "(Enter: Yes/yes/Y/y or No/no/N/n): " result

        if isyes "$result"; then
            mkdir -p "$pname"/old/root/public/
            mkdir "$pname"/old/logs/
            touch "$pname"/old/logs/p_"$pname"_old_nginx_access.log
            touch "$pname"/old/logs/p_"$pname"_old_nginx_error.log
            touch "$pname"/old/logs/p_"$pname"_old_httpd_access.log
            touch "$pname"/old/logs/p_"$pname"_old_httpd_error.log
            printf "$pname old" > "$pname"/old/root/public/index.html
        fi

        msgsuccess

    else
        msgfail
        warnmsgcanc
    fi

    flag=1

}

flag=0
while [[ "$flag" -eq 0 ]]
do
    createall
done



## Change ownership and set permissions to web server log files.
changeownership () {

    msgsuccess () { printf "\n$tb SUCCESS:$tn Ownership and permissions have been changed successfuly!\n"; }
    msgfail () {
        printf "\n$tb FAIL:$tn Ownership and permissions have$tb NOT$tn been changed.\n"
        printf "\tYou need to manualy execute this command or ask support to do it:\n"
        printf "\t$tb sudo find /home/$USER/www/projects/$pname/ -type f -name p_$pname_*.log -exec chown $USER.www {} \;$tn\n"
    }

    printf "\n# Changing ownership and permissions to web server log files, you must be in 'sudoers' file to do that!\n"
    printf "\n@ Do you have 'sudo' access?\n"
    read -p "(Enter: Yes/yes/Y/y or No/no/N/n): " result

    if isyes "$result"; then
        sudo find "$pname"/ -type f -name "p_$pname_*.log" -exec chown "$USER".www {} \;
        msgsuccess
    else
        msgfail
    fi

}

if [[ "$flag" -eq 1 ]]; then
    changeownership
else
    warnmsgunex
fi



## Display end message.
br
printf "#################################################\n"
printf "# Entire process has finished, no errors found! #\n"
printf "#################################################\n"
br