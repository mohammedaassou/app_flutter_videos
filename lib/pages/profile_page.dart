import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'About'),
              Tab(text: 'Settings'),
              Tab(text: 'Links'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [_AboutTab(), _SettingsTab(), _LinksTab()],
        ),
      ),
    );
  }
}

class _AboutTab extends StatelessWidget {
  const _AboutTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          elevation: 2,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.blue.shade50,
                  child: const Icon(Icons.person, color: Colors.blue, size: 28),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Mohamed Aassou',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Flutter Developer • UI • Animations • REST APIs',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: const [
                          _Pill(label: 'Flutter'),
                          _Pill(label: 'Dart'),
                          _Pill(label: 'REST'),
                          _Pill(label: 'GitHub'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // Quick stats
        Row(
          children: const [
            Expanded(
              child: _StatCard(
                title: 'Repos',
                value: 'Public',
                icon: Icons.folder_open,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                title: 'Videos',
                value: 'Search',
                icon: Icons.video_library,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // About text
        Card(
          elevation: 2,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'About',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  'I build clean, modern Flutter apps with smooth animations and real APIs. This app includes a video search and GitHub repos page.',
                  style: TextStyle(color: Colors.grey.shade700, height: 1.25),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SettingsTab extends StatelessWidget {
  const _SettingsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          elevation: 2,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: const [
              _SettingTile(
                icon: Icons.lock_outline,
                title: 'Privacy',
                subtitle: 'Manage privacy preferences',
              ),
              Divider(height: 1),
              _SettingTile(
                icon: Icons.notifications_none,
                title: 'Notifications',
                subtitle: 'Configure alerts',
              ),
              Divider(height: 1),
              _SettingTile(
                icon: Icons.movie_filter_outlined,
                title: 'Video Playback',
                subtitle: 'Playback preferences',
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Card(
          elevation: 2,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: const [
              _SettingTile(
                icon: Icons.language,
                title: 'Language',
                subtitle: 'English (example)',
              ),
              Divider(height: 1),
              _SettingTile(
                icon: Icons.palette_outlined,
                title: 'Theme',
                subtitle: 'Light (example)',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LinksTab extends StatelessWidget {
  const _LinksTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          elevation: 2,
          shadowColor: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: const [
              _SettingTile(
                icon: Icons.code,
                title: 'GitHub',
                subtitle: 'mohammedaassou',
              ),
              Divider(height: 1),
              _SettingTile(
                icon: Icons.link,
                title: 'Portfolio',
                subtitle: 'Add your website link',
              ),
              Divider(height: 1),
              _SettingTile(
                icon: Icons.email_outlined,
                title: 'Email',
                subtitle: 'Add your email address',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingTile extends StatelessWidget {
  const _SettingTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
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
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(value, style: TextStyle(color: Colors.grey.shade700)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
