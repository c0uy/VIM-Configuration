" VIMRC
" customized by th0ny

" Interface
color desert						"theme
"autocmd FocusLost * :colorscheme delek
"autocmd FocusGained * :colorscheme desert
syn on							"syntax coloration
set nu							"show lines numbers
set cursorline						"highlight current line
set hlsearch						"highlight searched patterns

" Controls
if has("mouse")
	set mouse=a					"enable mouse interaction
endif

" Edit
set tabstop=4						"size of tab
set softtabstop=0 noexpandtab				"dont replace with spaces

" - Status bar
" inspired by https://gist.github.com/ahmedelgabri/b9127dfe36ba86f4496c8c28eb65ef2b
set laststatus=2

" Func FileSize()
function! FileSize()
	let bytes = getfsize(expand('%:p'))
	if (bytes >= 1024)
		let kbytes = bytes / 1024
	endif
	if (exists('kbytes') && kbytes >= 1000)
		let mbytes = kbytes / 1000
	endif

	if bytes <= 0
		return '0'
	endif

	if (exists('mbytes'))
		return mbytes . 'MB '
	elseif (exists('kbytes'))
		return kbytes . 'KB '
	else
		return bytes . 'B '
	endif
endfunction

" Func SyntaxItem()
function! SyntaxItem()
	return synIDattr(synID(line("."),col("."),1),"name")
endfunction

if has('statusline')
	hi StatusLine ctermbg=black ctermfg=grey
	set statusline=

	set statusline+=%#CursorIM#
	set statusline+=%f\  								" file name
	set statusline+=%h%m%r%w\  							" flags
	set statusline+=%{FileSize()}

	set statusline+=%#CursorColumn#\ 
	set statusline+=%{strlen(&ft)?&ft:'none'}, 					" file type
	set statusline+=%{SyntaxItem()}							" syntax highlight group under cursor

	set statusline+=%#LineNr#\ 							" set highlighting
	set statusline+=%=\ 								" ident to the right
	set statusline+=%{(&fenc==\"\"?&enc:&fenc)}\| 					" encoding
	set statusline+=%{((exists(\"+bomb\")\ &&\ &bomb)?\"B,\":\"\")} " BOM
	set statusline+=%{&fileformat}\| 						" file format
	set statusline+=%{&spelllang}\  						" language of spelling checker
	set statusline+=0x%-8B 								" character code under cursor

	set statusline+=%#CursorIM#\ 
	set statusline+=%-7.(%l/%L,%c%V%)\ %<%P 					" cursor position/offset
endif

