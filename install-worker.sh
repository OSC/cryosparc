#!/usr/bin/env bash
trap "echo -e '\nInstalling CryoSPARC worker is terminated!\n'; exit 1" TERM INT

# Quit if any function returns an non-zero status.
set -eE
set -o pipefail

_header() {
  echo -e "\e[1;32m\n## $*\e[0m"
}

_help() {

cat <<EOF

 Usage: 

 
 VERSION=4.7.1
 LICENSE_ID=xxxx-xxxx-xxxxx
 ./install-worker.sh \$VERSION \$LICENSE_ID

EOF

exit -1

}

VERSION=$1
LICENSE_ID=$2

if [[ -z "$LICENSE_ID" ]] || [[ -z "$VERSION" ]]; then
  _help
fi

script_home="`dirname $(readlink -f $0)`"
WORKER_HOME=${script_home}/worker
mkdir -p $WORKER_HOME

_header "Preparing CryoSPARC worker $VERSION"
curl -L https://get.cryosparc.com/download/worker-v$VERSION/$LICENSE_ID -o /tmp/cryosparc_worker.tar.gz
tar -xf /tmp/cryosparc_worker.tar.gz --strip=1 -C $WORKER_HOME

_header "Installing CryoSPARC worker $VERSION"
cd $WORKER_HOME
./install.sh --license $LICENSE_ID

