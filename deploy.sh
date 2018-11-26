#!/bin/bash
echo "Starting deployment"

set -o errexit -o nounset

if [ "$TRAVIS_BRANCH" != "master" ]
then 
    echo "This commit was made against the $TRAVIS_BRANCH and not the master! No deploy!" 
    exit 0
fi

rev=$(git rev-parse --short HEAD)

cd dist

git config user.name "tsrot"

git config user.email "me@xieliqun.com"

git remote add upstream "https://$GH_TOKEN@github.com/huijiesuan/huijiesuan.github.io.git"

git fetch upstream

git reset upstream/product

echo "tsrot.github.io/ebook-vue" > CNAME

git add -A

git commit -m "rebuild pages at ${rev}"

git push -q upstream HEAD:product