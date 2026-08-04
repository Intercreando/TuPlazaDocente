import '../models/testimonial.dart';

/// Voces iniciales honestas (feedback temprano del producto, no reseñas falsas).
abstract final class SeedTestimonials {
  static const List<Testimonial> all = [
    Testimonial(
      id: 'seed-1',
      displayName: 'Carolina R.',
      roleLabel: 'Docente · Primaria',
      source: 'seed',
      approved: true,
      text:
          'Lo que más me sirve es la explicación después de cada ítem: no solo me dice '
          'si fallé, sino el criterio. Así dejo de memorizar a ciegas.',
    ),
    Testimonial(
      id: 'seed-2',
      displayName: 'Andrés M.',
      roleLabel: 'Aspirante a rector',
      source: 'seed',
      approved: true,
      text:
          'Entreno 10 minutos en la noche con la racha. El plan diario me ordena qué '
          'tocar cuando el tiempo aprieta cerca de la convocatoria.',
    ),
    Testimonial(
      id: 'seed-3',
      displayName: 'Juliana P.',
      roleLabel: 'Ciencias naturales',
      source: 'seed',
      approved: true,
      text:
          'Los casos de aula se sienten cercanos al colegio. Me ayuda a pensar el '
          'debido proceso, no solo la respuesta “bonita”.',
    ),
    Testimonial(
      id: 'seed-4',
      displayName: 'Diego H.',
      roleLabel: 'Educación física',
      source: 'seed',
      approved: true,
      text:
          'Empecé en gratis y se nota qué está limitado. Cuando pasé a Premium pude '
          'practicar especialidad sin pelearme con los cupos del día.',
    ),
  ];
}
