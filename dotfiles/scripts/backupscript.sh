#!/bin/sh

# Setting this, so the repo does not need to be given on the commandline:
export BORG_REPO=~/isync_google_one/backup_manjaro_home/



# some helpers and error handling:
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM
 
info "Starting backup"

# Backup the most important directories into an archive named after
# the machine this script is currently running on:

borg create                         \
    --verbose                       \
    --list                          \
    --stats                         \
    --show-rc                       \
    --compression lz4               \
    --exclude-caches                \
    --exclude '/home/*/.cache/*'    \
                                    \
    ::'{hostname}-{now}'            \
    ~/UNI/                          \
    ~/Projekte/                     \
    ~/dotfiles/                     \
    ~/.config/                      \
    ~/.ipython/                     \
    ~/org/                          \
    ~/.ssh/                         \

backup_exit=$?

info "Pruning repository"

# Use the `prune` subcommand to maintain 3 daily, 6 weekly and 9 monthly
# archives of THIS machine. The '{hostname}-' prefix is very important to
# limit prune's operation to this machine's archives and not apply to
# other machines' archives also:

borg prune                          \
    --list                          \
    --prefix '{hostname}-'          \
    --show-rc                       \
    --keep-daily    3               \
    --keep-weekly   6               \
    --keep-monthly  9               \

prune_exit=$?

# use highest exit code as global exit code
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [ ${global_exit} -eq 1 ];
then
    info "Backup and/or Prune finished with a warning"
fi

if [ ${global_exit} -gt 1 ];
then
    info "Backup and/or Prune finished with an error"
fi

exit ${global_exit}