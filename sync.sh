#! /bin/sh

update_vscode_settings () {
  CODE_SETTINGS_PATH="$HOME/Library/Application Support/Code/User"
  CODE_SETTINGS_FILE="$CODE_SETTINGS_PATH/settings.json"

  cp "$CODE_SETTINGS_FILE" vscode
}

update_vscode_extensions () {
  EXTENSIONS_SCRIPT_PATH="vscode/extensions.sh"
  echo "#!/bin/sh\n" > $EXTENSIONS_SCRIPT_PATH

  for i in $(code --list-extensions); do
    echo "code --install-extension $i" >> $EXTENSIONS_SCRIPT_PATH
  done
}

update_vscode () {
  echo "Copying Visual Studio Code settings file..."
  update_vscode_settings

  echo "Updating list installed extensions..."
  update_vscode_extensions
}

while getopts 'ach' opt; do
  case "$opt" in
    a)
      echo "Updating all files. Remember to review the changes 😁"
      update_vscode
      ;;

    c)
      update_vscode
      ;;
   
    ?|h)
      echo "Usage: $(basename $0) [-a] [-c]\n"
      echo "-a All of the below options together"
      echo "-c Updates Visual Studio Code settings and extensions"
      exit 1
      ;;
  esac
done

shift "$(($OPTIND -1))"