{{flutter_js}}
{{flutter_build_config}}

// El dry-run WASM a veces inyecta un build vacío `{}` que rompe el loader.
if (_flutter.buildConfig && Array.isArray(_flutter.buildConfig.builds)) {
  _flutter.buildConfig.builds = _flutter.buildConfig.builds.filter(function (b) {
    return b && b.compileTarget && (b.mainJsPath || b.mainWasmPath);
  });
}

// CanvasKit local + sin Service Worker de Flutter (usa web/sw.js para instalación PWA).
_flutter.loader.load({
  config: {
    renderer: "canvaskit",
    canvasKitBaseUrl: "/canvaskit/"
  }
});
