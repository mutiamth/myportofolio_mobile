import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'package:myportofolio_mobile/screens/project_list.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/education_list.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    Navigator.pop(context);

    try {
      await context.read<AuthState>().logout();

      if (!context.mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Berhasil logout.')));
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan saat logout: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthState>();

    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Portfolio',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Explore personal projects and experiences!',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ),

          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => MyHomePage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.folder_outlined),
            title: const Text('Portfolio'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProjectListScreen()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.school_outlined),
            title: const Text('Education'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EducationListScreen()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Project'),
            onTap: () async {
              final loggedIn = await ensureLoggedIn(context);

              if (!context.mounted || !loggedIn) return;

              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProjectFormPage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Add Education'),
            onTap: () async {
              final loggedIn = await ensureLoggedIn(context);

              if (!context.mounted || !loggedIn) return;

              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EducationFormPage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.work_history_outlined),
            title: const Text('Add Experience'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ExperienceFormPage()),
              );
            },
          ),

          const Divider(),

          if (!authState.isLoggedIn)
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Login'),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
            )
          else
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () => _handleLogout(context),
            ),
        ],
      ),
    );
  }
}
