// Future<Response> loadPage(String url) async {
//   if (url.isNotEmpty) {
//     try {
//       Response response = await get(
//         Uri.parse(_formatUrl(url)),
//       );
//       if (response.statusCode == 200) {
//         return response;
//       } else {
//         return Response.bytes(utf8.encode('Page could not be loaded'), 400);
//       }
//     } catch (e) {
//       return Response.bytes(utf8.encode('Page could not be loaded'), 400);
//     }
//   } else {
//     return Response('URL is empty', 400);
//   }
// }

String formatUrl(String text) {
  if (!text.startsWith('https://')) {
    return 'https://' + text;
  }
  return text;
}
