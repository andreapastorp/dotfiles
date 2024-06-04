function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    set -l normal (set_color normal)
    set -l status_color (set_color normal)
    set -l cwd_color (set_color $fish_color_cwd)
    set -l vcs_color (set_color brpurple)
    set -l prompt_status '' 
    set -l suffix '❯'

    # set git prompt variables 
    set -l git_icon ''
    set -g __fish_git_prompt_showupstream auto verbose
    set -g __fish_git_prompt_showdirtystate 1
    set -g __fish_git_prompt_showuntrackedfiles 1
    set -g __fish_git_prompt_showstashstate 1
    set -g __fish_git_prompt_char_upstream_ahead ↑
    set -g __fish_git_prompt_char_upstream_behind ↓
    set -g __fish_git_prompt_char_upstream_diverged 
    set -g __fish_git_prompt_char_untrackedfiles '?'
    set -g __fish_git_prompt_char_dirtystate '!'
    set -g fish_git_prompt_char_invalidstate 'x'

    # Color the prompt in red on error
    if test $last_status -ne 0
        set status_color (set_color $fish_color_error)
        set prompt_status $status_color " [" $last_status "]" $normal
    end

    # Add git icon when at a git repo 
    git rev-parse --is-inside-work-tree > /dev/null 2>&1
    if test $status -eq 0
        set git_icon ' '
    end


    echo -s (prompt_login) ' ' $cwd_color (prompt_pwd) $vcs_color $git_icon (fish_git_prompt)  $prompt_status ' ' $status_color $suffix ' '

end
