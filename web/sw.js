/* Service Worker mínimo para que Chrome/Edge ofrezcan “Instalar app”.
 * No cachea recursos: todo va a red. Así no se queda la app vieja pegada.
 */
'use strict';

self.addEventListener('install', (event) => {
  self.skipWaiting();
});

self.addEventListener('activate', (event) => {
  event.waitUntil(self.clients.claim());
});

self.addEventListener('fetch', (event) => {
  event.respondWith(fetch(event.request));
});
