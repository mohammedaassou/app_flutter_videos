import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/github_repo.dart';

/// Thin API client for GitHub repos.
///
/// Architecture matches your app:
/// - `models/` contains the data classes
/// - `services/` contains simple HTTP calls (no Provider/state libs)
class GitHubServiceApi {
  static const String _baseUrl = 'https://api.github.com';

  /// Fetches public repos for the given user.
  Future<List<GitHubRepo>> getUserRepos({required String username}) async {
    final url = Uri.parse('$_baseUrl/users/$username/repos');

    final response = await http.get(
      url,
      headers: {
        // GitHub recommends setting this header.
        'Accept': 'application/vnd.github+json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load repos: HTTP ${response.statusCode}');
    }

    final decoded = json.decode(response.body);
    if (decoded is! List) {
      throw Exception('Unexpected GitHub API response (expected a list).');
    }

    return decoded
        .whereType<Map<String, dynamic>>()
        .map(GitHubRepo.fromMap)
        .toList();
  }
}
