"Deploying to Github pages..."
"Checking out master branch..."
git checkout master

"Copying files from ./build/web..."
Copy-Item ./build/web/* . -Recurse -Force

"Commiting changes..."
git add .
git commit -m "Auto deploy commit"

"Pushing to master..."
git push
