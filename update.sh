#!/bin/bash

OLD_VERSION=$1
NEW_VERSION=$2

if [[ -z ${OLD_VERSION} || -z ${NEW_VERSION} ]]; then
  echo "Usage: update.sh [OLD_VERSION] [NEW_VERSION]"
  exit 1
fi

if [ -n "`git diff --staged`" ]; then
  echo "Error: Commit or unstage staged files"
  exit 1
fi

declare -a files=("README.md" "Dockerfile" "onbuild/Dockerfile")

for file in "${files[@]}"; do
  sed -i '' "s/${OLD_VERSION}/${NEW_VERSION}/g" ${file}
  git add ${file}
done

if [ -z "`git diff --staged`" ]; then
  echo "Sorry, version ${OLD_VERSION} was not found."
  exit 1
fi

git commit -m "Tag release v${NEW_VERSION}"
git tag -a "v${NEW_VERSION}" -m "v${NEW_VERSION}" -s
