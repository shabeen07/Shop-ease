import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_ease/app/router/route_names.dart';
import 'package:shop_ease/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shop_ease/features/auth/presentation/bloc/auth_event.dart';
import 'package:shop_ease/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:shop_ease/features/profile/presentation/bloc/profile_event.dart';
import 'package:shop_ease/features/profile/presentation/bloc/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) =>
        ProfileBloc(authBloc: context.read<AuthBloc>())
          ..add(ProfileLoadRequested()),
    child: Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.status == ProfileStatus.success && state.user != null) {
            final user = state.user!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  _ProfileHeader(
                    name: '${user.firstName} ${user.lastName}',
                    email: user.email,
                  ),
                  const SizedBox(height: 24),
                  _ProfileMenuTile(
                    icon: Icons.person_outline,
                    title: 'Edit Profile',
                    onTap: () {},
                  ),
                  _ProfileMenuTile(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    onTap: () => context.pushNamed(RouteNames.settings),
                  ),
                  _ProfileMenuTile(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    onTap: () {},
                  ),
                  const Divider(height: 32),
                  _ProfileMenuTile(
                    icon: Icons.logout,
                    title: 'Log Out',
                    titleColor: Colors.red,
                    iconColor: Colors.red,
                    onTap: () => _showLogoutDialog(context),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    ),
  );

  void _showLogoutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log out?'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogoutRequested());
              Navigator.pop(context);
              context.goNamed(RouteNames.login);
            },
            child: const Text('Log out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final String name;
  final String email;

  const _ProfileHeader({required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            child: Text(
              name.isNotEmpty ? name[0] : 'U',
              style: const TextStyle(fontSize: 32, color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            email,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.8)),
          ),
        ],
      ),
    );
  }
}

class _ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? titleColor;
  final Color? iconColor;

  const _ProfileMenuTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.titleColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(icon, color: iconColor),
    title: Text(
      title,
      style: TextStyle(color: titleColor, fontWeight: FontWeight.w500),
    ),
    trailing: const Icon(Icons.chevron_right, size: 20),
    onTap: onTap,
  );
}
