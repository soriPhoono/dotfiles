function inform_user {
  prompt=$1

  echo -e "\n> $1"
}

function debug_print {
  prompt=$1

  if [[ $(whoami) == "soriphoono" ]]; then
    inform_user $prompt
  fi
}
