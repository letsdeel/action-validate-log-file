#!/bin/bash

registry=$1
if [ -z $registry ] ; then
  echo "missing registry argument"
  exit -1
fi
FILES=$(jq -r '.packages[] | select(.resolved != null) | .resolved' package-lock.json | grep -v eslint | grep -v "https://npm-${registry}.d.codeartifact.eu-west-1.amazonaws.com")
if [ $? != 0 ] ; then
  echo "package-lock.json file is Ok"
  exit 0
else
  IFS=" "
  echo "wrong registries appear in package-lock.json file:"
  echo $FILES
  unset IFS
  exit -1
fi
