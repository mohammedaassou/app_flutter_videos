import 'package:flutter/material.dart';

/// App drawer navigation.
class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Navigation',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            _item(context, index: 0, icon: Icons.home, label: 'Home / Mini CV'),
            _item(
              context,
              index: 1,
              icon: Icons.video_library,
              label: 'Video Search',
            ),
            _item(
              context,
              index: 2,
              icon: Icons.person,
              label: 'Profile / Settings',
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
  }) {
    final selected = selectedIndex == index;
    return ListTile(
      selected: selected,
      leading: Icon(icon),
      title: Text(label),
      onTap: () => onSelected(index),
    );
  }
}
