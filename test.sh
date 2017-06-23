#!/usr/bin/env bash

for cmd in "vim --not-a-term" "nvim -n --headless"; do
  echo "running ${cmd}"
  ${cmd} --noplugin -u NONE \
    -c ':set nocp' \
    -c ':filetype plugin indent on' \
    -c ':syntax on' \
    -c ':let g:rel_test_mode = 1' \
    -c ":set rtp=$(pwd)/" \
    -c ':source ./plugin/rel.vim' \
    -c ":redir >> /tmp/rel.vim.test.$$.txt" \
    -c ':source ./test.vim' \
    -c ':redir END'
  ec=$?
  if [ ${ec} -ne 0 ]; then
    exit ${ec}
  else
    # cat /tmp/rel.vim.test.$$.txt
    echo
  fi
  rm -f /tmp/rel.vim.test.$$.txt
done

exit 0

