

"syntax match ClassName display '\<\([A-Z][a-z0-9]*\)\+\>'
"syntax match ClassName display '\.\@<=\*'
"highlight link ClassName Special
	

"syntax match   FuncCall       /\<\K\k*\ze\s*(/
"highlight link FuncCall Constant

"syntax match Operator display '[!%^&|+=.<>,:;?-]'
"syntax match Operator display '//\@!'
"syntax match Operator display '/\@<!\*/\@!'

"syntax match Constructor display '\(\(public\|protected\|private\)\s\+\)\@<=\([A-Z][a-z0-9]*\)\+\( *(\)\@='
"highlight link Constructor PreProc

"syntax match Final '\<[A-Z][A-Z0-9]\+\%(_[A-Z0-9]\+\)*\>'
"highlight Final ctermfg=61

