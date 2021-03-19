au BufRead,BufNewFile *.jpg,*.png,*.gif,*.jpeg, set filetype=image
au BufRead,BufNewFile *.mp3,*.flac,*.wav,*.ogg set filetype=audio
au BufRead,BufNewFile *.avi,*.mp4,*.mkv,*.mov,*.mpg set filetype=video
au FileType lua setlocal sw=2 ts=2 sts=2
au FileType vim setlocal sw=2 ts=2 sts=2
