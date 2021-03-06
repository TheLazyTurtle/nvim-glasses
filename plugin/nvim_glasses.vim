function! ReloadAlpha()
lua << EOF
	for k in pairs(package.loaded) do
		if k:match("^nvim-glasses") then
			package.loaded[k] = nil
		end
	end
EOF
endfunction

nnoremap <Leader>pra :call ReloadAlpha()<CR>
"nnoremap gm :lua require('utils.window').open_window()<CR>
nnoremap gm :lua require('menu').glasses_menu()<CR>
" nnoremap glpp :lua require("nvim-glasses").list_projects()<CR>
" nnoremap grp :lua require("nvim-glasses").remove_project()<CR>
" nnoremap gap :lua require("nvim-glasses").add_project()<CR>
" nnoremap glpr :lua require("nvim-glasses").list_project_reference()<CR>
" nnoremap gcp :lua require("projects.create").create_project()<CR>
