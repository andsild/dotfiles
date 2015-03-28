source ~/.vim/plugin/tail.vim

execute "TabTail" escape('~/irc/hjem.carlsen.nl/outfile ~/irc/irc.freenode.net/outfile', '#')

execute "wincmd w"
execute "wincmd w"
execute "wincmd J"

" map af :.w escape('~/irc/hjem.carlsen.nl/\#asciifag/in, '#') "<CR>dd"
map af :.w >> ~/irc/hjem.carlsen.nl/\#asciifag/in<CR>dd
map iu :.w >> ~/irc/irc.freenode.net/\#iugntnu/in<CR>dd

set updatetime=1500

autocmd CursorHold * call Timer()
function! Timer()
  call feedkeys("f\e")
  call tail#Refresh()
  " K_IGNORE keycode does not work after version 7.2.025)
  " there are numerous other keysequences that you can use
endfunction
