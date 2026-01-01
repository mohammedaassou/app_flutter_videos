import 'dart:convert';
import 'package:http/http.dart' as http;

import '../env.dart';
import '../models/pexels_video.dart';

/// Thin API client for Pexels Video API.
class PexelsServiceApi {
  Future<List<Video>> getVideos({required String key}) async {
    final url = Uri.parse(
      '$pexelsBaseUrl/?key=$pexelsApiKey&q=$key&pretty=true',
    );

    print(url);

    final response = await http.get(url);

    print(response.body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['hits'] as List;
      return [...results.map((json) => Video.fromMap(json))];
    } else {
      throw Exception('Failed to load photos: ${response.statusCode}');
    }
  }
}
