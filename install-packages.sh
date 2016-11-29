#!/bin/bash

log () {
    message="$1"
    local logfile="/var/log/custom_setup.log"
    if [[ ! -f  ${logfile} ]]
    then 
	touch ${logfile}
        chmod a+r ${logfile}
    fi

    echo "$(date '+%Y-%m-%dT%H:%M') - ${message}" | tee $logfile
}


main () {
    local appdir="${1}"

    log "[INFO] Searching ${appdir} for custom setup files"

    local ubuntu_packages="${appdir}/ubuntu_packages"
    local r_packages="${appdir}/r_packages"
    local r_repos="${appdir}/r_repos"
    local r_script="${appdir}/r_config.R"

    local repos=()
    repos+=("${R_REPOS}")

    unset packages

    if [[ -f ${ubuntu_packages} ]]
    then 
	declare -a packages
        log "[INFO] Found ${ubuntu_packages}"
        for package in $(cat ${ubuntu_packages})
        do
            log "[INFO] Adding ${package} to install job"
            packages+=(${package})
      done
      if  [[ ${#packages[@]} != 0 ]]
      then
	  apt-get update \
	  | tee "/var/log/custom_setup.log" \
          || exit 1
          apt-get install -y ${packages[@]} \
	  | tee "/var/log/custom_setup.log" \
          || exit 1 
      fi
    fi

    if [[ -f ${r_repos} ]]
    then
        log "[INFO] Found ${r_repos}"
	for repo in $(cat ${r_repos})
        do
	  log "[INFO] Adding ${repo} to R Repo list"
	  repos+=(${repo})
	done
    fi

    if [[ -f ${r_script} ]]
    then
	log "[INFO] Found ${r_script}"
	R "${r_script}" \
	| tee "/var/log/custom_setup.log" \
	|| exit 1
    fi

    unset packages

    if [[ -f ${r_packages} ]]
    then 
        log "[INFO] Found ${r_packages}"
        log "[INFO] Using R repos: ${repos[@]}"
        for package in $(cat ${r_packages})
        do 
            log "[INFO] Installing ${package} "
            R -e "install.packages(c('${package}'),repos=${repos[@]})"  \
	    | tee "/var/log/custom_setup.log" \
	    || exit 1
        done
    fi
}


main "$1"
