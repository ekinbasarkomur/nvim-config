" my filetype file
    if exists("did_load_filetypes")
        finish
    endif
    augroup filetypedetect
      au! BufRead, BufNewFile *.sdf        setfiletype xml
      au! BufRead,BufNewFile *.world       setfiletype xml
    augroup END
