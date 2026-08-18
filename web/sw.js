/* Service Worker de TuPlazaDocente.
 *
 * Problema que resuelve: al abrir desde el acceso directo del celular, el
 * navegador volvía a pedir el motor completo (main.dart.js ~4 MB, CanvasKit
 * ~7 MB, fuentes y banco de ítems). Eran decenas de peticiones antes del
 * primer cuadro: splash rápido y luego varios segundos en blanco.
 *
 * Estrategia:
 *  - cache-first para lo que no cambia dentro de un mismo build (motor,
 *    CanvasKit, assets, iconos).
 *  - la navegación (index.html) prioriza la red, con la copia guardada como
 *    respaldo si la red tarda más de 2,5 s o no hay conexión.
 *  - no se interceptan: version.json, /api/**, otros dominios ni nada que no
 *    sea GET (analítica, Firebase, CAPI siguen igual).
 *
 * El nombre de la caché lleva el id del build, que sella
 * tools/stamp_service_worker.js en el predeploy. No se usa skipWaiting: una
 * versión nueva toma el control en la siguiente apertura, así nunca se borra
 * la caché mientras la app está abierta.
 */
'use strict';

const BUILD_ID = '__TPD_BUILD_ID__';
const CACHE_PREFIX = 'tpd-app-';
const CACHE_NAME = CACHE_PREFIX + BUILD_ID;
const NAVIGATION_TIMEOUT_MS = 2500;

/// Rutas estables dentro de un mismo build: se sirven desde caché.
const CACHE_FIRST = [
  /^\/main\.dart\.js$/,
  /^\/flutter\.js$/,
  /^\/flutter_bootstrap\.js$/,
  /^\/canvaskit\//,
  /^\/assets\//,
  /^\/icons\//,
  /\.wasm$/,
];

/// Siempre contra la red: son el mecanismo de actualización y la API.
const NETWORK_ONLY = [
  /^\/build-id\.json$/,
  /^\/version\.json$/,
  /^\/sw\.js$/,
  /^\/api\//,
];

function matchesAny(patterns, path) {
  for (const pattern of patterns) {
    if (pattern.test(path)) return true;
  }
  return false;
}

self.addEventListener('activate', (event) => {
  event.waitUntil((async () => {
    try {
      const keys = await caches.keys();
      await Promise.all(
        keys
          .filter((key) => key.startsWith(CACHE_PREFIX) && key !== CACHE_NAME)
          .map((key) => caches.delete(key)),
      );
    } catch (e) {
      // Si falla la limpieza, la app sigue resolviendo contra la red.
    }
    try {
      await self.clients.claim();
    } catch (e) {
      // Sin control inmediato: lo tomará en la siguiente apertura.
    }
  })());
});

self.addEventListener('fetch', (event) => {
  const request = event.request;
  if (request.method !== 'GET') return;

  let url;
  try {
    url = new URL(request.url);
  } catch (e) {
    return;
  }
  if (url.origin !== self.location.origin) return;
  if (matchesAny(NETWORK_ONLY, url.pathname)) return;

  if (request.mode === 'navigate') {
    event.respondWith(navigationResponse(request));
    return;
  }
  if (matchesAny(CACHE_FIRST, url.pathname)) {
    event.respondWith(cacheFirst(request));
  }
});

/// Solo se guardan respuestas propias y completas (no 206 ni opacas).
function isStorable(response) {
  return !!response && response.status === 200 && response.type === 'basic';
}

/// Devuelve la copia guardada; si no existe, la descarga y la guarda.
async function cacheFirst(request) {
  let cache;
  try {
    cache = await caches.open(CACHE_NAME);
    const hit = await cache.match(request, { ignoreSearch: true });
    if (hit) return hit;
  } catch (e) {
    return fetch(request);
  }
  const response = await fetch(request);
  if (isStorable(response)) {
    // clone() antes de devolverla: el cuerpo solo se puede leer una vez.
    cache.put(request, response.clone()).catch(() => {});
  }
  return response;
}

/// HTML fresco cuando la red responde a tiempo; copia guardada si tarda.
/// El chequeo de version.json en index.html se encarga de recargar cuando
/// se sirvió una copia de un build anterior.
async function navigationResponse(request) {
  let cache = null;
  let cached = null;
  try {
    cache = await caches.open(CACHE_NAME);
    cached = await cache.match(request, { ignoreSearch: true });
  } catch (e) {
    cache = null;
  }

  const fromNetwork = fetch(request).then((response) => {
    if (cache && isStorable(response)) {
      cache.put(request, response.clone()).catch(() => {});
    }
    return response;
  });

  if (!cached) return fromNetwork;

  return Promise.race([
    fromNetwork.catch(() => cached),
    new Promise((resolve) => {
      setTimeout(() => resolve(cached), NAVIGATION_TIMEOUT_MS);
    }),
  ]);
}
