#    /\_/\  
#   ( o.o )  
#    > ^ <        
# this is a simple git prompt.

add_git_prompt() {

  # Color definitions
  local NC="\[\033[0m\]" # No Color
  local GIT_BRANCH_COLOR="\[\033[33m\]" # yellow
  local GIT_PATH_COLOR="\[\033[0;31m\]" # red~orange ?
  local GIT_M_COLOR="\[\033[1;33m\]" # yellow
  local GIT_D_COLOR="\[\033[1;31m\]" # red
  local GIT_U_COLOR="\[\033[1;34m\]" # blue
  local USER_COLOR="\[\033[01;32m\]" # green
  local DIR_COLOR="\[\033[01;34m\]" # blue

  local status_count_modified=0
  local status_count_untracked=0
  local status_count_deleted=0

  # Function to get the count of edited, deleted, and untracked files
  get_git_status_count() {
    while IFS= read -r line; do
      case "$line" in 
        ' M'*) ((status_count_modified++)) ;;
        '??'*) ((status_count_untracked++)) ;;
        ' D'*) ((status_count_deleted++)) ;;
      esac
    done < <(git status -s --porcelain 2> /dev/null)
  }

  # function to show edited files count
  get_git_status_m() {
    if [ "$status_count_modified" -gt 0 ]; then
        echo -n $GIT_M_COLOR'[~'$status_count_modified']'$NC
    fi
  }

  # function to show deleted files count
  get_git_status_d() {
    if [ "$status_count_deleted" -gt 0 ]; then
        echo -n $GIT_D_COLOR'[-'$status_count_deleted']'$NC
    fi
  }

  # function to show new files count
  get_git_status_u() {
    if [ "$status_count_untracked" -gt 0 ]; then
        echo -n $GIT_U_COLOR'[+'$status_count_untracked']'$NC
    fi
  }

  # function to show branch name
  get_git_branch_name() {
    echo -n $GIT_BRANCH_COLOR'(* '$branch_name')'$NC
  }

  # function to get repo tag
  get_git_tag() {
    echo -n $USER_COLOR'['$(git remote -v | awk '{print $2}' | sed -E 's#(git@|https://|git://)([^@]+@)?([^:/]+).*#\3#' | uniq)']'$NC
  }

  # function to show relative path from git repo base
  get_git_path() {
    echo -n $GIT_PATH_COLOR'@'$(basename `git rev-parse --show-toplevel`)'/'$(git rev-parse --show-prefix)$NC
  }

  # ps1 base
  PS1='${debian_chroot:+($debian_chroot)}'

  # get branch name, assume all function are call after this line
  local branch_name=$(git branch --show-current 2> /dev/null)
  if [ -n "$branch_name" ]; then
    # get status 
    get_git_status_count
    # Override PS1 value
    PS1+=$(get_git_tag)' '
    PS1+=$(get_git_path)' '
    PS1+=$(get_git_branch_name)' '
    PS1+=$(get_git_status_u)$(get_git_status_m)$(get_git_status_d)
    PS1+='\n$ '
  else 
    PS1+=$USER_COLOR'\u@\h'$NC':'$DIR_COLOR'\w'$NC'\$ '
  fi
}

PROMPT_COMMAND=add_git_prompt
