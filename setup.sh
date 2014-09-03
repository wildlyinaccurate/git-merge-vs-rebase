#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

[[ $1 == '--force' ]] && force=1

for merge in merge rebase; do
    merge_options=''

    [[ $merge == 'merge' ]] && merge_options='--no-edit'

    if [[ -d $merge && $force == 1 ]]
    then
        rm -rf $merge
    elif [[ -d $merge && $force != 1 ]]
    then
        echo "Directory $merge already exists. Run with --force to replace it."
        exit 1
    fi

    mkdir "$DIR/$merge"
    cd "$DIR/$merge"
    git init

    touch master
    git add master
    git commit -m 'Initial commit'

    git checkout -b feature-1 master
    touch feature-1
    git add feature-1
    git commit -m 'Implement feature 1'

    git checkout -b feature-2 master
    touch feature-2
    git add feature-2
    git commit -m 'Implement feature 2'

    git checkout master
    git merge --no-ff --no-edit feature-1

    git checkout feature-2
    git $merge $merge_options master
    echo 'More feature 2' > feature-2
    git commit -m 'Add more to feature 2' feature-2

    git checkout master
    git merge --no-ff --no-edit feature-2

    git checkout -b feature-3 master
    touch feature-3
    git add feature-3
    git commit -m 'Implement feature 3'

    git checkout master
    echo 'Hotfix' > master
    git commit -m 'Hotfix' master

    git checkout feature-3
    git $merge $merge_options master
    echo 'More feature 3' > feature-3
    git commit -m 'Add more to feature 3' feature-3

    git checkout master
    git merge --no-ff --no-edit feature-3
done
