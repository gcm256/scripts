#!/bin/sh

# See: https://stackoverflow.com/questions/68384486/how-do-i-properly-change-the-author-of-a-commit-for-the-past-few-commits-in-gith
# See also: https://github.com/adamdehaven/change-git-author/blob/master/changeauthor.sh

git filter-branch --env-filter '

OLD_EMAIL="your-old-email@example.com"
CORRECT_NAME="Your Correct Name"
CORRECT_EMAIL="your-correct-email@example.com"

export GIT_COMMITTER_NAME="$CORRECT_NAME"
export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"

export GIT_AUTHOR_NAME="$CORRECT_NAME"
export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
' --tag-name-filter cat -- --branches --tags
