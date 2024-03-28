function inform_user {
  p=$1

  echo -e "\n> $1"
}

function debug_print {
  p=$1

  if [[ $(whoami) == "soriphoono" ]]; then
    inform_user $p
  fi
}

function confirm_installation {
  p=$1
  callback=$2

  inform_user $p
  read -n 1 -p "(Y/n) >> " response

  if [[ $response ~= [Yy ] ]]; then
    echo -e "\nInstallation confirmed. Proceeding...\n"

    command $callback
  else
    echo -e "\nInstallation cancelled. Skipping...\n"
  fi
}
