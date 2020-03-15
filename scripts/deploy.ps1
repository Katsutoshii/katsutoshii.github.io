"**Deploying to Github pages...**"
git stash

"Building web..."
flutter build web

"Checking out master branch..."
git checkout master

"Copying files from ./build/web..."
Copy-Item ./build/web/* . -Recurse -Force

"Commiting changes..."
git add .
git commit -m "Auto deploy commit"

"Pushing to master..."
git push

git checkout flutter-web
git stash pop
