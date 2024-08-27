import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:monopoli/models/audio/index.dart';
import 'package:monopoli/models/audio/models.dart';

const baseURL = 'https://spotify-scraper.p.rapidapi.com/v1';
const headers = {
  'Content-Type': 'application/json',
  'x-rapidapi-key': '0dec7e90f4msh1c806f9ede307efp1eeba2jsn9f6cade779d1',
  'x-rapidapi-host': 'spotify-scraper.p.rapidapi.com',
};

class MusicService {
  static Future<ResponseData> search(String query) async {
    var res = await http.get(
      Uri.parse('$baseURL/search?term=$query&type=all'),
      headers: headers,
    );

    var data = jsonDecode(res.body);
    return ResponseData.fromJson(data);
  }

  static Future<AudioApiResponse> getTrackURL(
    String trackId,
  ) async {
    var res = await http.get(
      Uri.parse('$baseURL/track/download?track=$trackId'),
      headers: headers,
    );

    var data = jsonDecode(res.body);
    return AudioApiResponse.fromJson(data);
  }
}
