#! /bin/bash

ls -d */ | xargs -I %PLG% mv %PLG%.git %PLG%.gitms 
git add .
git commit -m "updates vim plugins on `date`"
git pull origin master
git push origin master
ls -d */ | xargs -I %PLG% mv %PLG%.gitms %PLG%.git
