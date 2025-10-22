session_root "~/ecom-velocity-app"

if initialize_session "work"; then
  new_window "nvim"
  split_v 20
  select_pane 0
  run_cmd "tmux resize-pane -Z"
  run_cmd "vim"

  new_window "term"
  select_window 1
fi

finalize_and_go_to_session
