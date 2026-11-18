function sway --description "Launch Sway from a console"
    if test -n "$WAYLAND_DISPLAY"; or test -n "$DISPLAY"
        echo "Already inside a graphical session." >&2
        return 1
    end

    if test "$TERM_SESSION_TYPE" = kms
        command kmscon-launch-gui sway $argv
    else
        command sway $argv
    end
end