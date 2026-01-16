import 'package:flutter/material.dart';

import 'app_logo.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({
    super.key,
    this.userInitial,
    this.userName,
    this.userAvatarUrl,
    this.onSettingsTap,
    this.onLogoutTap,
    this.showUserAction = true,
    this.actions,
  });

  final String? userInitial;
  final String? userName;
  final String? userAvatarUrl;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onLogoutTap;
  final bool showUserAction;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    final String? initial = userInitial?.trim().isNotEmpty == true
        ? userInitial!.trim().substring(0, 1).toUpperCase()
        : null;

    return AppBar(
      toolbarHeight: 72,
      leadingWidth: 96,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: AppLogo(height: 64),
      ),
      actions: [
        if (actions != null) ...actions!,
        if (showUserAction && initial != null)
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: PopupMenuButton<_UserMenuAction>(
              tooltip: 'User menu',
              onSelected: (action) {
                switch (action) {
                  case _UserMenuAction.settings:
                    onSettingsTap?.call();
                    break;
                  case _UserMenuAction.logout:
                    onLogoutTap?.call();
                    break;
                }
              },
              itemBuilder: (context) {
                final displayName = userName?.trim().isNotEmpty == true
                    ? userName!.trim()
                    : 'Account';
                final avatarUrl =
                    userAvatarUrl?.trim().isNotEmpty == true ? userAvatarUrl : null;
                return [
                  PopupMenuItem<_UserMenuAction>(
                    enabled: false,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.blue.shade100,
                          foregroundColor: Colors.blue.shade900,
                          backgroundImage:
                              avatarUrl != null ? NetworkImage(avatarUrl) : null,
                          child: avatarUrl == null
                              ? Text(
                                  initial ?? '?',
                                  style:
                                      const TextStyle(fontWeight: FontWeight.bold),
                                )
                              : null,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            displayName,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem(
                    value: _UserMenuAction.settings,
                    child: Row(
                      children: [
                        Icon(Icons.settings, size: 18),
                        SizedBox(width: 8),
                        Text('Settings'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: _UserMenuAction.logout,
                    child: Row(
                      children: [
                        Icon(Icons.logout, size: 18),
                        SizedBox(width: 8),
                        Text('Log out'),
                      ],
                    ),
                  ),
                ];
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue.shade100,
                foregroundColor: Colors.blue.shade900,
                backgroundImage: userAvatarUrl?.trim().isNotEmpty == true
                    ? NetworkImage(userAvatarUrl!.trim())
                    : null,
                child: userAvatarUrl?.trim().isNotEmpty == true
                    ? null
                    : Text(
                        initial,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ),
      ],
    );
  }
}

enum _UserMenuAction {
  settings,
  logout,
}
