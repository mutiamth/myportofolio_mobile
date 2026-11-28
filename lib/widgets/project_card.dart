import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_list.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/education_list.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  Future<void> _handleTap(BuildContext context) async {
    if (item.name == 'Lihat Portofolio') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ProjectListScreen()),
      );
    } else if (item.name == 'Lihat Education') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const EducationListScreen()),
      );
    } else if (item.name == 'Tambah Proyek') {
      final loggedIn = await ensureLoggedIn(context);

      if (!context.mounted || !loggedIn) return;

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ProjectFormPage()),
      );
    } else if (item.name == 'Tambah Experience') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ExperienceFormPage()),
      );
    } else if (item.name == 'Login') {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } else if (item.name == 'Logout') {
      try {
        await context.read<AuthState>().logout();

        if (!context.mounted) return;

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Logout berhasil')));
      } catch (e) {
        if (!context.mounted) return;

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Logout gagal: $e')));
      }
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text('Kamu telah menekan tombol ${item.name}!')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () => _handleTap(context),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
