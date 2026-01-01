import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../colors.dart';
import '../models/pexels_video.dart';
import '../services/pexels_api.dart';
import 'video_detail_page.dart';
import '../widgets/staggered_fade_scale.dart';

/// Page 2: Video Search
class VideoSearchPage extends StatefulWidget {
  const VideoSearchPage({super.key});

  @override
  State<VideoSearchPage> createState() => _VideoSearchPageState();
}

class _VideoSearchPageState extends State<VideoSearchPage> {
  final PexelsServiceApi _api = PexelsServiceApi();

  String _query = '';

  Future<List<Video>>? _future;

  @override
  void initState() {
    super.initState();
    // Default videos when search is empty.
    _future = _api.getVideos(key: '');
  }

  void _submit(String value) {
    setState(() {
      _query = value;
      _future = _api.getVideos(key: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Video Search'),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Search free videos on Pexels (e.g. nature, cars...)',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  tooltip: 'Clear',
                  onPressed: () {
                    _submit('');
                  },
                  icon: const Icon(Icons.close),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onChanged: (value) => _query = value,
              onSubmitted: _submit,
            ),
          ),

          Expanded(
            child: FutureBuilder<List<Video>>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 42),
                        const SizedBox(height: 10),
                        Text(
                          snapshot.error.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'If you see a missing key error, run with:\n--dart-define=PEXELS_API_KEY=YOUR_KEY',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: () => _submit(_query),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                final videos = snapshot.data ?? const <Video>[];
                if (videos.isEmpty) {
                  return const Center(child: Text('No videos found.'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    final video = videos[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: StaggeredFadeScale(
                        index: index,
                        child: _VideoCard(video: video),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _VideoCard extends StatelessWidget {
  const _VideoCard({required this.video});

  final Video video;

  @override
  Widget build(BuildContext context) {
    final thumb = video.imageUrlVideo;

    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 450),
      transitionType: ContainerTransitionType.fadeThrough,
      openElevation: 0,
      closedElevation: 0,
      closedColor: Colors.transparent,
      openColor: AppColors.tertiary,
      openBuilder: (context, _) => VideoDetailPage(video: video),
      closedBuilder: (context, open) {
        return InkWell(
          onTap: open,
          borderRadius: BorderRadius.circular(16),
          child: Card(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: thumb.isEmpty
                        ? Container(
                            color: AppColors.primary,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.videocam,
                              color: AppColors.tertiary,
                              size: 36,
                            ),
                          )
                        : Image.network(
                            thumb,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: AppColors.primary,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.videocam,
                                  color: AppColors.tertiary,
                                  size: 36,
                                ),
                              );
                            },
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              video.userName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${video.duration} seconds',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '${video.duration}s',
                          style: const TextStyle(
                            color: AppColors.tertiary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
