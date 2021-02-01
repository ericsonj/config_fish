set __fish_git_prompt_show_informative_status
set __fish_git_prompt_showcolorhints
set __fish_git_prompt_showupstream "informative"

set -g __fish_git_prompt_char_upstream_prefix " "


set __fish_git_prompt_color_dirtystate -o red
set __fish_git_prompt_color_upstream_behind -o yellow


# Icons
set __fish_git_prompt_char_cleanstate ' ✔ '
set __fish_git_prompt_char_conflictedstate ' ⚠️  '
set __fish_git_prompt_char_dirtystate ' ✚ '
set __fish_git_prompt_char_invalidstate ' 🤮  '
set __fish_git_prompt_char_stagedstate ' 🚥  '
set __fish_git_prompt_char_stashstate ' 📦  '
set __fish_git_prompt_char_stateseparator ' | '
set __fish_git_prompt_char_untrackedfiles ' • '
set __fish_git_prompt_char_upstream_ahead ' ↑ '
set __fish_git_prompt_char_upstream_behind ' ↓ '
set __fish_git_prompt_char_upstream_diverged ' 🚧  '
set __fish_git_prompt_char_upstream_equal ' 💯 ' 


set __fish_git_prompt_color_branch white --italics
set -g __fish_promot_clock (set_color brblack)

set -g fish_prompt_pwd_dir_length 16

function fish_prompt --description 'Write out the prompt'
	#Save the return status of the previous command
    set stat $status

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q __fish_color_blue
        set -g __fish_color_blue (set_color -o blue)
    end

    #Set the color for the status depending on the value
    set __fish_color_status (set_color -o green)
    if test $stat -gt 0
        set __fish_color_status (set_color -o red)
    end

    switch "$USER"

        case root toor

            if not set -q __fish_prompt_cwd
                if set -q fish_color_cwd_root
                    set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
                else
                    set -g __fish_prompt_cwd (set_color -o $fish_color_cwd)
                end
            end

            printf '%s@%s %s%s%s# ' $USER (prompt_hostname) "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal"

        case '*'

            if not set -q __fish_prompt_cwd
                set -g __fish_prompt_cwd (set_color -o $fish_color_cwd )
            end


            set -g __fish_var_git_prompt (fish_git_prompt)
            set -g __fish_var_git_prompt (string trim "$__fish_var_git_prompt")

            if not string length -q -- "$__fish_var_git_prompt"
                printf '──%s%s@%s%s:%s%s%s%s%s \f\r$ ' "$__fish_prompt_cwd" $USER (prompt_hostname) "$__fish_prompt_normal" "$__fish_color_blue" (prompt_pwd) "$__fish_color_status" "$__fish_prompt_normal" "$__fish_var_git_prompt"
            else
                printf '┬─%s%s@%s%s:%s%s\f\r%s╰─%s%s \f\r$ ' "$__fish_prompt_cwd" $USER (prompt_hostname) "$__fish_prompt_normal" "$__fish_color_blue" (prompt_pwd) "$__fish_prompt_normal" "$__fish_prompt_normal" "$__fish_var_git_prompt"
            end

            #printf '%s[%s] %s%s@%s%s:%s%s%s%s%s \f\r$ ' "$__fish_promot_clock" (date "+%H:%M:%S") "$__fish_prompt_cwd" $USER (prompt_hostname) "$__fish_prompt_normal" "$__fish_color_blue" (prompt_pwd) "$__fish_color_status" "$__fish_prompt_normal" (fish_git_prompt)
            #printf '%s%s@%s%s:%s%s%s%s%s \f\r$ ' "$__fish_prompt_cwd" $USER (prompt_hostname) "$__fish_prompt_normal" "$__fish_color_blue" (prompt_pwd) "$__fish_color_status" "$__fish_prompt_normal" (fish_git_prompt)
    
    end
end
