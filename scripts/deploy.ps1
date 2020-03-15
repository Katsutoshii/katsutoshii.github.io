"**Deploying to Github pages...**"

"Building web..."
flutter build web

"Copying files from ./build/web..."
Copy-Item ./build/web/* ./deployment -Recurse -Force

"Commiting changes..."
pushd deployment
git add .
git commit -m "Auto deploy commit"

"Pushing to master..."
git push
popd
