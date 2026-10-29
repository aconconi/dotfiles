if status is-interactive
    set -g fish_prompt_pwd_dir_length 0

    if type -q starship
        starship init fish | source
    end
end
