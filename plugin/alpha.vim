if exists('g:loaded_alpha') | finish | endif " prevent loading file twice

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to default

" Command to run our plugin
command! MakeWindow lua require("hello").window()
command! Mk lua require("nvim-glasses").list_projects()

let &cpo = s:save_cpo 
unlet s:save_cpo

let g:loaded_alpha = 1
