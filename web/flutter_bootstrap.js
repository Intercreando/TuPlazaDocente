{{flutter_js}}
{{flutter_build_config}}

// Forzar CanvasKit local (no CDN gstatic) para que producción no dependa de Google CDN.
_flutter.loader.load({
  config: {
    canvasKitBaseUrl: "/canvaskit/"
  }
});
