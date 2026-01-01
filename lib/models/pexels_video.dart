class Video {
  Video({
    required this.id,
    required this.duration,
    required this.userName,
    required this.videoUrl,
    required this.likes,
    required this.imageUrlVideo,
    required this.userImageURL,
  });

  final int id;
  final int duration;

  final String userName;
  final String videoUrl;
  final int likes;
  final String imageUrlVideo;
  final String userImageURL;

  /// Parse a Pexels "video" object.
  factory Video.fromPexels(Map<String, dynamic> map) {
    final user = (map['user'] as Map<String, dynamic>?) ?? const {};
    final files = (map['video_files'] as List?) ?? const [];
    final pictures = (map['video_pictures'] as List?) ?? const [];

    String pickBestMp4Url(List<dynamic> fileList) {
      String best = '';
      int bestWidth = -1;

      for (final f in fileList) {
        if (f is! Map<String, dynamic>) continue;
        final link = f['link'];
        if (link is! String || link.isEmpty) continue;
        final fileType = (f['file_type'] as String?)?.toLowerCase();
        if (fileType != null && !fileType.contains('mp4')) continue;
        final width = (f['width'] as num?)?.toInt() ?? 0;
        if (width > bestWidth) {
          bestWidth = width;
          best = link;
        }
      }

      return best;
    }

    String pickThumbnailUrl(List<dynamic> pictureList) {
      for (final p in pictureList) {
        if (p is! Map<String, dynamic>) continue;
        final picture = p['picture'];
        if (picture is String && picture.isNotEmpty) return picture;
      }
      return '';
    }

    return Video(
      id: (map['id'] as num?)?.toInt() ?? 0,
      duration: (map['duration'] as num?)?.toInt() ?? 0,
      userName: (user['name'] as String?) ?? '',
      videoUrl: pickBestMp4Url(files),
      likes: 0,
      imageUrlVideo: pickThumbnailUrl(pictures),
      userImageURL: (user['image'] as String?) ?? '',
    );
  }

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      id: map['id']?.toInt() ?? 0,
      duration: map['duration']?.toInt() ?? 0,
      userName: map['user'] ?? '',
      videoUrl: map['videos']['large']['url'] ?? '',
      likes: map['likes']?.toInt() ?? 0,
      imageUrlVideo: map['videos']['large']['thumbnail'] ?? '',
      userImageURL: map['userImageURL'] ?? '',
    );
  }
}
