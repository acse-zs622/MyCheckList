#!/bin/bash

ORG_NAME="orgName"
GITHUB_TOKEN="token"
YOUR_USERNAME="name"

# 获取organization的所有仓库
repos=$(curl -s -H "Authorization: token $GITHUB_TOKEN" "https://api.github.com/orgs/$ORG_NAME/repos?type=all&per_page=100" | jq -r '.[].name')

for repo_name in $repos; do
    echo "Cloning $repo_name..."
    git clone "https://github.com/$ORG_NAME/$repo_name.git"
    cd $repo_name
    
    prefixed_repo_name="PRE-$repo_name"
    
    echo "Creating new private repository with name: $prefixed_repo_name ..."
    curl -s -H "Authorization: token $GITHUB_TOKEN" \
         -d '{"name":"'$prefixed_repo_name'", "private": true}' \
         "https://api.github.com/user/repos"

    echo "Pushing to new repository..."
    git remote set-url origin "https://github.com/$YOUR_USERNAME/$prefixed_repo_name.git"
    git push -u origin master
    git push -u origin main # 视情况选择
    cd ..
done
