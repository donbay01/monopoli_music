import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:monopoli/models/audio/album.dart';
import 'package:monopoli/models/spotify/category.dart';
import '../models/spotify/playlist.dart';

import 'package:monopoli/models/audio/track.dart' as t;

class Spotify {
  static var clientId = 'cf2c8da705094cc1a2cd0849b20c5f09';
  static var clientSecret = '82c1f9a2fa19440c98cf084e468777f8';

  static const baseURL = 'https://api.spotify.com/v1';

  static Future<String?> getSpotifyAuthToken() async {
    final credentials = base64Encode(utf8.encode('$clientId:$clientSecret'));

    final authUrl = Uri.parse('https://accounts.spotify.com/api/token');

    final response = await http.post(
      authUrl,
      headers: {
        'Authorization': 'Basic $credentials',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'client_credentials',
      },
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final token = body['access_token'];
      print('Access token: $token');
      return token;
    } else {
      print('Failed to retrieve token. Status code: ${response.statusCode}');

      return null;
    }
  }

  static Future<List<SpotifyCategory>> getCategories(String token) async {
    final url = Uri.parse('$baseURL/browse/categories');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    final body = json.decode(response.body);
    final cats = body['categories']['items']
        .map((a) => SpotifyCategory.fromJSON(a))
        .toList()
        .cast<SpotifyCategory>();

    return cats;
  }

  static Future<List<SpotifyPlaylist>> getCategoriesPlaylist(
    String token,
    String category,
  ) async {
    final url = Uri.parse('$baseURL/browse/categories/$category/playlists');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    final body = json.decode(response.body);

    final p = body['playlists']['items']
        .map((a) => SpotifyPlaylist.fromJSON(a))
        .toList()
        .cast<SpotifyPlaylist>();

    return p;
  }

  static Future<List<SpotifyPlaylistTrackResponse>> getPlaylistTracks(
    String token,
    String playlistId,
  ) async {
    final url = Uri.parse('$baseURL/playlists/$playlistId/tracks');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    final body = json.decode(response.body);
    final t = body['items']
        .map((a) => SpotifyPlaylistTrackResponse.fromJSON(a))
        .toList()
        .cast<SpotifyPlaylistTrackResponse>();

    return t;
  }

  static Future<Albums> getTrendingAlbums({
    required String accessToken,
    int limit = 25,
    int offset = 0,
  }) async {
    var uri = 'https://api.spotify.com/v1/browse/new-releases';
    if (offset > 0) {
      uri = '$uri?limit=$limit&offset=$offset';
    }

    final url = Uri.parse(
      uri,
    );
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };

    final res = await http.get(url, headers: headers);
    final data = jsonDecode(res.body);

    var a = data['albums'];

    return Albums.fromJson(a);
  }

  // static Future<List<SpotifyAlbum>> getMultipleAlbums(
  //   String accessToken,
  //   List<String> albumIds,
  // ) async {
  //   final url = Uri.parse(
  //     'https://api.spotify.com/v1/albums?ids=${albumIds.join(",")}',
  //   );
  //   final headers = {
  //     'Authorization': 'Bearer $accessToken',
  //   };

  //   final response = await http.get(url, headers: headers);

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);

  //     return data['albums']
  //         .map((a) => SpotifyAlbum.fromJSON(a))
  //         .toList()
  //         .cast<SpotifyAlbum>();
  //   } else {
  //     print(response.statusCode);
  //     throw Exception('Failed to fetch albums');
  //   }
  // }

  static Future<List> getAlbumTracks(
    String token,
    String albumID,
  ) async {
    final url = Uri.parse(
      'https://api.spotify.com/v1/albums/$albumID/tracks',
    );
    final headers = {
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);
    final data = jsonDecode(response.body);

    return data['items'];
  }

  static Future<t.Track> getSingleTrack(
    String token,
    String trackId,
  ) async {
    final url = Uri.parse(
      'https://api.spotify.com/v1/tracks/$trackId',
    );
    final headers = {
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);
    final data = jsonDecode(response.body);

    return t.Track.fromJson(data);
  }

  static Future<List<t.Track>> getMultipleTracks(
    String token,
    List<String> trackIds,
  ) async {
    final url = Uri.parse(
      'https://api.spotify.com/v1/tracks?ids=${trackIds.join(",")}',
    );
    final headers = {
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);
    final data = jsonDecode(response.body);

    return data['tracks']
        .map((a) => t.Track.fromJson(a))
        .toList()
        .cast<t.Track>();
  }
}
