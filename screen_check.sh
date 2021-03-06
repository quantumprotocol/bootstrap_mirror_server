#!/bin/bash

source $(dirname $(readlink -f $0))/bootstrap_config

if [[ "$screen_enable" == "1" ]]; then

  screen_check=$(screen -ls | grep http_server | wc -l)
  if [[ "$screen_check" == "1" && -f /$home_dir/screen_error ]]; then
   sudo rm -rf /$home_dir/screen_error
  fi
  
  if [[ "$screen_check" == "0" && ! -f /$home_dir/screen_error ]]; then
   echo "Screen error: $(date +'%m-%d-%Y %H:%M:%S')" > /$home_dir/screen_error
   source $(dirname $(readlink -f $0))/bootstrap_config
   bash /$home_dir/bootstrap_mirror_server/discord.sh \
  --webhook-url="$web_hook_url" \
  --username "Alert" \
  --title " :warning:  \u200b  Bootstrap Server Alert" \
  --color "0xED4245" \
  --field "Server;$server_name" \
  --field "Info;Screen problem detected!" \
  --text "Ping: $user_id_list"
  fi
  
fi
