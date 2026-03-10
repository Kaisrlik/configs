augroup __typst__
	if exists("did_load_filetypes")
		finish
	endif

	au!
	au BufNewFile,BufRead *.typ set filetype=typst
augroup end
