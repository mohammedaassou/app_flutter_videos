import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../colors.dart';
import '../models/pexels_video.dart';

/// Page 3: Video Details
class VideoDetailPage extends StatefulWidget {
  const VideoDetailPage({super.key, required this.video});

  final Video video;

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with SingleTickerProviderStateMixin {
  VideoPlayerController? _controller;
  late final AnimationController _anim;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _fade = CurvedAnimation(parent: _anim, curve: Curves.easeOutCubic);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _anim, curve: Curves.easeOutCubic));

    _initPlayer();
  }

  Future<void> _initPlayer() async {
    final url = widget.video.videoUrl;
    if (url.isEmpty) {
      _anim.forward();
      return;
    }

    final c = VideoPlayerController.networkUrl(Uri.parse(url));
    _controller = c;
    try {
      await c.initialize();
      await c.setLooping(true);
      await c.play();
    } finally {
      if (mounted) setState(() {});
      _anim.forward();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = _controller;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Video Details')),
      body: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Video player
              Card(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: c == null || !c.value.isInitialized
                        ? Container(
                            color: AppColors.secondary,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.play_circle_outline,
                              color: AppColors.tertiary,
                              size: 64,
                            ),
                          )
                        : Stack(
                            fit: StackFit.expand,
                            children: [
                              VideoPlayer(c),
                              _PlayerOverlay(controller: c),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Title & description
              Text(
                widget.video.userName.isEmpty
                    ? 'Video #${widget.video.id}'
                    : widget.video.userName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              Text('Duration: ${widget.video.duration}s'),
              const SizedBox(height: 14),

              // Extra info
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'About',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Source: Pexels • Duration: ${widget.video.duration}s',
                      ),
                      const SizedBox(height: 8),
                      Text('Creator: ${widget.video.userName}'),
                      if (widget.video.likes > 0) ...[
                        const SizedBox(height: 8),
                        Text('Likes: ${widget.video.likes}'),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlayerOverlay extends StatelessWidget {
  const _PlayerOverlay({required this.controller});

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (value.isPlaying) {
                controller.pause();
              } else {
                controller.play();
              }
            },
            child: AnimatedOpacity(
              opacity: value.isPlaying ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: const Center(
                child: Icon(
                  Icons.play_circle_fill,
                  color: AppColors.tertiary,
                  size: 72,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
