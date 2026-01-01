import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

/// A small helper to animate list/grid items with a staggered Fade+Scale.
class StaggeredFadeScale extends StatefulWidget {
  const StaggeredFadeScale({
    super.key,
    required this.child,
    required this.index,
    this.baseDelay = const Duration(milliseconds: 60),
    this.duration = const Duration(milliseconds: 350),
  });

  final Widget child;
  final int index;
  final Duration baseDelay;
  final Duration duration;

  @override
  State<StaggeredFadeScale> createState() => _StaggeredFadeScaleState();
}

class _StaggeredFadeScaleState extends State<StaggeredFadeScale>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    Future<void>.delayed(widget.baseDelay * widget.index, () {
      if (!mounted) return;
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeScaleTransition(
      animation: CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
      child: widget.child,
    );
  }
}
