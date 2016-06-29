#!/bin/bash

log () {
    message="$1"
    local logfile="/var/log/stevedore-packages.log"
    if [[ ! -f  ${logfile} ]]
        then touch ${logfile}
        chmod a+r ${logfile}
    fi

    echo "$(date '+%Y-%m-%dT%H:%M') - ${message}" >> $logfile
}


main () {
    local appdir="${1}"
    local ubuntu_packages="${appdir}/.stevedore/ubuntu_packages"
    local r_packages="${appdir}/.stevedore/r_packages"

    unset packages

    if [[ -f ${ubuntu_packages} ]]
        then declare -a packages
        log "Found ${ubuntu_packates}"
        for package in $(cat ${ubuntu_packages})
            do log "Adding ${package} to install job"
            packages+=(${package})
      done
      if  [[ ${#packages[@]} != 0 ]]
          then apt-get update | tee "/var/log/stevedore-packages.log" \
          || exit 1
          apt-get install -y ${packages[@]} | tee "/var/log/stevedore-packages.log" \
          || exit 1 
      fi
    fi

    unset packages

    if [[ -f ${r_packages} ]]
        then declare -a packages
        log "Found ${r_packates}"
        for package in $(cat ${r_packages})
            do log "Adding ${package} to install job"
            packages+=(${package})
        done
        # TODO: Should we somehow take extra R repositories?  Below is just CRAN set from Dockerfile
        if  [[ ${#packages[@]} != 0 ]]
            then R -e "install.packages(c('${r_packages}'),repos=${R_REPOS})" \
            || exit 1
        fi
    fi
}


main "$1"
