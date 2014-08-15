# Must be in user's home directory
# If necessary : 'chmod 644' .bashrc to make it 'rw r r'
# After changes reload with into current session : 'source .bashrc'

# Aliases
# removing an alias : 'unalias <alias_name>'

alias ls="ls -CF"						# display in columns with a file type indicator
alias ll='ls -lF'                       # long listing
alias la='ls -laF'                      # long listing with invisible files
alias ..='cd ..'                        # move up one level
alias ...='cd ../../'                   # move up two levels
alias cp='cp -p'                        # l'option -p preserve dates & rights on copy

# Prompt
# \d – Current date
# \t – Current time
# \h – Host name
# \# – Command number
# \u – User name
# \W – Current working directory (ie: Desktop/)
# \w – Current working directory

export PS1='\u@\h:\W$ '

# Don't check mail when opening terminal.

unset MAILCHECK