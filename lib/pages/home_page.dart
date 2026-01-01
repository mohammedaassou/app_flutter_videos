import 'package:flutter/material.dart';

import '../colors.dart';
import '../widgets/staggered_fade_scale.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = const [
      _Project(
        title: 'Video Search App',
        description: 'Flutter + Provider + Pexels Video API',
      ),
      _Project(
        title: 'Portfolio Mini CV',
        description: 'Simple sections with clean UI + animations',
      ),
      _Project(
        title: 'Animated Cards',
        description: 'Smooth transitions with the animations package',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Mohamed Aassou\'s Portfolio'),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile image
          Center(
            child: Container(
              width: 108,
              height: 108,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary, width: 3),
              ),
              child: CircleAvatar(
                backgroundImage: Image.asset('assets/mohamed.png').image,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Bio
          const Text(
            'Mohamed Aassou',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(
            'Flutter developer focused on clean UI, smooth animations, and API-driven apps.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 18),

          // Skills
          const Text(
            'Skills',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _SkillChip(label: 'Flutter'),
              _SkillChip(label: 'Dart'),
              _SkillChip(label: 'Provider'),
              _SkillChip(label: 'REST APIs'),
              _SkillChip(label: 'Animations'),
            ],
          ),
          const SizedBox(height: 18),

          // Projects
          const Text(
            'Projects',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          for (var i = 0; i < projects.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: StaggeredFadeScale(
                index: i,
                child: Card(
                  color: AppColors.tertiary,
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.work,
                            color: AppColors.tertiary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                projects[i].title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(projects[i].description),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  const _SkillChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.tertiary,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.12)),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }
}

class _Project {
  const _Project({required this.title, required this.description});
  final String title;
  final String description;
}
