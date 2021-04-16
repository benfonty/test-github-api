#!/bin/bash

path="test.txt"
content=$(cat ${path} | base64 -w 0)
#sha=$(curl -X GET https://api.github.com/repos/benfonty/test-github-api/contents/test.txt| jq .sha)
sha=$(git ls-files -s $path | awk '{print $2}')
body="{\"path\": \"${path}\", \"message\": \"updated ${path} by api\", \"content\": \"${content}\", \"branch\": \"main\",\"sha\": \"${sha}\"}"
echo $body
curl -i -X PUT -H "Authorization: token ${GIT_TOKEN}" -H 'Accept: application/vnd.github.v3+json' -d  "${body}" https://api.github.com/repos/benfonty/test-github-api/contents/${path}