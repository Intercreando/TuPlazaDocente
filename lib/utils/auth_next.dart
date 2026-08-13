/// Destinos internos permitidos tras login (`?next=`).
/// Evita redirecciones abiertas a URLs externas.
const _allowedNext = {
  '/premium',
  '/app/premium',
  '/app',
  '/onboarding',
};

/// Devuelve una ruta interna segura o `null` si el valor no es de confianza.
String? sanitizeNextPath(String? raw) {
  if (raw == null || raw.isEmpty) return null;
  final decoded = Uri.decodeComponent(raw).trim();
  if (!decoded.startsWith('/') || decoded.startsWith('//')) return null;
  if (decoded.contains('://')) return null;
  final path = decoded.split('?').first.split('#').first;
  if (!_allowedNext.contains(path)) return null;
  return path;
}
