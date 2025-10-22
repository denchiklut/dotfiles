session_root "~/dotfiles"

if initialize_session "config"; then
  new_window "nvim"
  split_v 20
  select_pane 0
  run_cmd "tmux resize-pane -Z"
  run_cmd "vim"

  new_window "term"
  select_window 1
fi

finalize_and_go_to_session
