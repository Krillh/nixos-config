function sway --description "Launch Sway directly on standard TTY or via kmscon-launch-gui"
    if test "$TERM" = "kmscon" -o -n "$KMSCON"
        kmscon-launch-gui sway $argv
    else
        command sway $argv
    end
end