import 'dart:convert';

import 'package:http/http.dart' as http;

class PostRepository {
  getPosts(int page) async {
    final String _uri =
        'https://techcrunch.com/wp-json/wp/v2/posts?%22%22context=embed&per_page=20&page=$page';
    var url = Uri.parse(_uri);
    var respons = await http.get(url);
    if (respons.statusCode == 200) {
      var json = jsonDecode(respons.body) as List;
      return json;
    }
  }
}
