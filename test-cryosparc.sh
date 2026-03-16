#!/usr/bin/env bash

_header() {
  echo -e "\e[1;32m\n## $*\e[0m"
}

_help() {

cat <<EOF

 Usage: 

 ./test-cryosparc.sh <email> <project_dir>

EOF

exit -1

}


EMAIL=$1
PROJECT_DIR=$2

if [[ -z "$EMAIL" ]] || [[ -z "$PROJECT_DIR" ]]; then
  _help	
fi


_header "Test checklist"
cryosparcm test install

_header "Create a project"
email_address=$1
user_id=$(cryosparcm cli "get_id_by_email('$email_address')")
echo "User ID is: $user_id"

project_container_dir=$2
mkdir -p ${project_container_dir}
project_title='Test Workers'
project_uid=$(cryosparcm cli "create_empty_project(owner_user_id='$user_id', project_container_dir='$project_container_dir', title='$project_title')")
echo "Created project with UID: $project_uid"

_header "Test workers"
cryosparcm test workers $project_uid
