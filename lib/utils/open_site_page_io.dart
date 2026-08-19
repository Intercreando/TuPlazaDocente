import 'open_external_url.dart';

const newsHubUrl = 'https://www.tuplazadocente.com/noticias/';

Future<void> openSitePage(String url, {bool newTab = false}) async {
  await openExternalUrl(url);
}

Future<void> openNewsHub({bool newTab = false}) =>
    openSitePage(newsHubUrl, newTab: newTab);
