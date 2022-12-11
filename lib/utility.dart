String formatUrl(String text) {
  if (!text.startsWith('https://')) {
    return 'https://' + text;
  }
  return text;
}
