//https://developers.google.com/web/fundamentals/codelabs/your-first-pwapp/

//Consider using workbox if caching becomes a headache to manage
//https://developers.google.com/web/tools/workbox/


//The google example in the app used cache (This may or may not be right for us)
/*
* Gets a forecast for a specific city and updates the card with the data.
* getForecast() first checks if the weather data is in the cache. If so,
* then it gets that data and populates the card with the cached data.
* Then, getForecast() goes to the network for fresh data. If the network
* request goes through, then the card gets updated a second time with the
* freshest data.
*/
//app.getForecast = function(key, label) {
    //var statement = 'select * from weather.forecast where woeid=' + key;
    //var url = 'https://query.yahooapis.com/v1/public/yql?format=json&q=' +
        //statement;
    //// TODO add cache logic here
    //if ('caches' in window) {
      /*
       * Check if the service worker has already cached this city's weather
       * data. If the service worker has the data, then display the cached
       * data while the app fetches the latest data.
       */
      //caches.match(url).then(function(response) {
        //if (response) {
          //response.json().then(function updateFromCache(json) {
            //var results = json.query.results;
            //results.key = key;
            //results.label = label;
            //results.created = json.query.created;
            //app.updateForecastCard(results);
          //});
        //}
      //});
    //}
    //// Fetch the latest data.
    //var request = new XMLHttpRequest();
    //request.onreadystatechange = function() {
      //if (request.readyState === XMLHttpRequest.DONE) {
        //if (request.status === 200) {
          //var response = JSON.parse(request.response);
          //var results = response.query.results;
          //results.key = key;
          //results.label = label;
          //results.created = response.query.created;
          //app.updateForecastCard(results);
        //}
      //} else {
        //// Return the initial weather forecast since no data is available.
        //app.updateForecastCard(initialWeatherForecast);
      //}
    //};
    //request.open('GET', url);
    //request.send();
//};

//Providing a cache name allows us to version files, or separate data from the
//app shell so that we can easily update one but not affect the otherProviding
//a cache name allows us to version files, or separate data from the app shell
//so that we can easily update one but not affect the other
var dataCacheName = 'skeleton-v1';
var cacheName = 'skeleton-1'; 
var filesToCache = [ 
    '/', 
];

//The first time a user visits the page
self.addEventListener('install', function(e) {
  console.log('[ServiceWorker] Install');
  e.waitUntil(
    caches.open(cacheName).then(function(cache) {
      console.log('[ServiceWorker] Caching app shell');
        //Unfortunately, cache.addAll() is atomic, if any of the files fail, the entire cache step fails!
      return cache.addAll(filesToCache);
    })
  );
});

self.addEventListener('activate', function(e) {
  console.log('[ServiceWorker] Activate');
  e.waitUntil(
    caches.keys().then(function(keyList) {
      return Promise.all(keyList.map(function(key) {
        if (key !== cacheName && key !== dataCacheName) {
          console.log('[ServiceWorker] Removing old cache', key);
          return caches.delete(key);
        }
      }));
    })
  );
   //Fixes a corner case in which the app wasn't returning the latest data.
   //You can reproduce the corner case by commenting out the line below and
   //then doing the following steps: 1) load app for first time so that the
   //initial New York City data is shown 2) press the refresh button on the
   //app 3) go offline 4) reload the app. You expect to see the newer NYC
   //data, but you actually see the initial data. This happens because the
   //service worker is not yet activated. The code below essentially lets
   //you activate the service worker faster.
  return self.clients.claim();
});

self.addEventListener('fetch', function(e) {
  console.log('[Service Worker] Fetch', e.request.url);
  var dataUrl = 'https://query.yahooapis.com/v1/public/yql';
  if (e.request.url.indexOf(dataUrl) > -1) {
     //When the request URL contains dataUrl, the app is asking for fresh
     //weather data. In this case, the service worker always goes to the
     //network and then caches the response. This is called the "Cache then
     //network" strategy:
     //https://jakearchibald.com/2014/offline-cookbook/#cache-then-network
    e.respondWith(
      caches.open(dataCacheName).then(function(cache) {
        return fetch(e.request).then(function(response){
          cache.put(e.request.url, response.clone());
          return response;
        });
      })
    );
  } else {
     //The app is asking for app shell files. In this scenario the app uses the
     //"Cache, falling back to the network" offline strategy:
     //https://jakearchibald.com/2014/offline-cookbook/#cache-falling-back-to-network
    e.respondWith(
      caches.match(e.request).then(function(response) {
        return response || fetch(e.request);
      })
    );
  }
});
