#!/usr/bin/env bash
if ! command -v git &> /dev/null
then
    echo "Git binary could not be found in \$PATH\n"
    echo "Exiting..."
    exit 1
fi

GITHUB_USER_NAME="tarjoilija"

echo "Downloading zgen...."


tmpdir=$(mktemp -d)
cd $tmpdir

git clone "https://github.com/$GITHUB_USER_NAME/zgen.git" "${HOME}/.zgen"

echo "Installation finished"
