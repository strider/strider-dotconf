#!/bin/sh
[ -z "$MYEMACSCLIENT" ] && MYEMACSCLIENT="emacs"
# emacsclient won't work in git mergetool
# $1=$LOCAL $2=$REMOTE $3=$BASE $4=$MERGED
if [ "$MYEMACSCLIENT" = "emacs" ]; then
    $MYEMACSCLIENT -cn -a "" -Q --eval "(setq startup-now t)" -l "$HOME/.spacemacs.d/init.el" --eval "(progn (setq ediff-quit-hook 'kill-emacs) (if (file-readable-p \"$3\") (ediff-merge-files-with-ancestor \"$1\" \"$2\" \"$3\" nil \"$4\") (ediff-merge-files \"$1\" \"$2\" nil \"$4\")))"
else
    $MYEMACSCLIENT -cn -a "" --eval "(progn (setq ediff-quit-hook 'kill-emacs) (if (file-readable-p \"$3\") (ediff-merge-files-with-ancestor \"$1\" \"$2\" \"$3\" nil \"$4\") (ediff-merge-files \"$1\" \"$2\" nil \"$4\")))"
fi
