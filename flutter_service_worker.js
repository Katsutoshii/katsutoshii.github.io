'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "/assets/AssetManifest.json": "4a3da2d08ab4eb24e87de49fe0c387ae",
"/assets/assets/fonts/GoogleSansRegular.ttf": "b5c77a6aed75cdad9489effd0d5ea411",
"/assets/assets/images/avatar.jpg": "cd4f58f9bc4d4d45ed73f684c77ff3b5",
"/assets/assets/images/facebook.png": "021ada146ffb7c1753557ff29618d04c",
"/assets/assets/images/github.png": "d22ee3727a7216019c3848df6eafa024",
"/assets/assets/images/instagram.png": "26631a4043b14dff84180bdf51c3cacb",
"/assets/assets/images/linkedin.png": "926e2dcf5ab4220a359867614556df68",
"/assets/assets/images/moon.png": "a270b8a10d1a9a52441bf5a322dd1b86",
"/assets/assets/images/projects/plr.png": "aa0bc5f3dc9550e6a66e58ee4cf103e3",
"/assets/assets/images/soundcloud.png": "5bda2f8fbe6376bcbd5408803929b863",
"/assets/assets/images/twitter.png": "8f35a40403a84631c4125c4f1859c7a6",
"/assets/FontManifest.json": "bb05d491d63534b264dea8213a4a50be",
"/assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"/assets/LICENSE": "3497085789be69824fc4475a02ce3684",
"/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"/favicon.png": "5dcef449791fa27946b3d35ad8803796",
"/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"/index.html": "3ce066785709cdc2ba7f1478e628da28",
"/main.dart.js": "aceea8746821f0e647e44de5abdb9e60",
"/manifest.json": "e5adb07b030ed756623f0902a128e36b"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
