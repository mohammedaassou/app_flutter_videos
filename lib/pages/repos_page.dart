import 'package:flutter/material.dart';

import '../colors.dart';
import '../models/github_repo.dart';
import '../services/github_api.dart';

class ReposPage extends StatefulWidget {
  const ReposPage({super.key});

  @override
  State<ReposPage> createState() => _ReposPageState();
}

class _ReposPageState extends State<ReposPage> {
  final GitHubServiceApi _api = GitHubServiceApi();

  Future<List<GitHubRepo>>? _future;

  @override
  void initState() {
    super.initState();
    _future = _api.getUserRepos(username: 'mohammedaassou');
  }

  void _retry() {
    setState(() {
      _future = _api.getUserRepos(username: 'mohammedaassou');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('My GitHub Repos'),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<GitHubRepo>>(
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
                  const SizedBox(height: 12),
                  OutlinedButton(onPressed: _retry, child: const Text('Retry')),
                ],
              ),
            );
          }

          final repos = snapshot.data ?? const <GitHubRepo>[];
          if (repos.isEmpty) {
            return const Center(child: Text('No repositories found.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            itemCount: repos.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return _RepoCard(repo: repos[index]);
            },
          );
        },
      ),
    );
  }
}

class _RepoCard extends StatelessWidget {
  const _RepoCard({required this.repo});

  final GitHubRepo repo;

  @override
  Widget build(BuildContext context) {
    final description = repo.description.isEmpty
        ? 'No description provided.'
        : repo.description;

    final updatedText = repo.updatedAt == null
        ? ''
        : 'Updated: ${repo.updatedAt!.toLocal().toString().split('.').first}';

    return Card(
      color: AppColors.tertiary,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: AppColors.primary.withValues(alpha: 0.12),
              backgroundImage: repo.ownerAvatarUrl.isEmpty
                  ? null
                  : NetworkImage(repo.ownerAvatarUrl),
              child: repo.ownerAvatarUrl.isEmpty
                  ? const Icon(Icons.person, color: AppColors.primary)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    repo.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey.shade700, height: 1.2),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: [
                      _StatChip(
                        icon: Icons.star_border,
                        label: '${repo.stargazersCount}',
                      ),
                      _StatChip(
                        icon: Icons.call_split,
                        label: '${repo.forksCount}',
                      ),
                      if (repo.language.isNotEmpty) _Pill(label: repo.language),
                    ],
                  ),
                  if (updatedText.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Text(
                      updatedText,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: AppColors.secondary),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.22)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.secondary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
