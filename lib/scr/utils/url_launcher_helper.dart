import 'dart:html' as html;

/// Abre una URL en una nueva pestaña (solo Flutter Web).
void launchUrl(String url) {
  if (!url.startsWith('http://') && !url.startsWith('https://')) {
    url = 'https://$url';
  }
  html.window.open(url, '_blank');
}