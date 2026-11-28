import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'package:myportofolio_mobile/models/education.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';
import 'package:myportofolio_mobile/screens/education_detail.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';

class EducationListScreen extends StatefulWidget {
  const EducationListScreen({super.key});

  @override
  State<EducationListScreen> createState() => _EducationListScreenState();
}

class _EducationListScreenState extends State<EducationListScreen> {
  late Future<List<Education>> _educationsFuture;

  @override
  void initState() {
    super.initState();
    _educationsFuture = _loadEducations();
  }

  Future<List<Education>> _loadEducations() {
    return context.read<ApiClient>().getEducations();
  }

  Future<void> _refreshEducations() async {
    setState(() {
      _educationsFuture = _loadEducations();
    });

    try {
      await _educationsFuture;
    } catch (_) {
      // Error ditampilkan oleh FutureBuilder.
    }
  }

  void _retry() {
    setState(() {
      _educationsFuture = _loadEducations();
    });
  }

  Future<void> _openEducationForm() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const EducationFormPage()),
    );

    if (result == true && mounted) {
      await _refreshEducations();
    }
  }

  void _openEducationDetail(Education education) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EducationDetailScreen(education: education),
      ),
    );
  }

  Future<void> _deleteEducation(Education education) async {
    final id = education.id;

    if (id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Education ID tidak ditemukan.')),
      );
      return;
    }

    final authState = context.read<AuthState>();
    final token = authState.token;

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan login untuk menghapus Education.'),
        ),
      );
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Education?'),
        content: Text(
          'Are you sure you want to delete "${education.institution}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    try {
      await context.read<ApiClient>().deleteEducation(id, token: token);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Education berhasil dihapus.')),
      );

      await _refreshEducations();
    } on ApiException catch (error) {
      if (!mounted) return;

      if (error.statusCode == 401) {
        try {
          await authState.logout();
        } catch (_) {
          // Token tetap dibersihkan oleh AuthState.logout().
        }

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Session expired. Silakan login kembali.'),
          ),
        );
      } else if (error.statusCode == 403) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Lu tidak punya izin untuk menghapus Education.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menghapus Education: ${error.message}'),
          ),
        );
      }
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $error')));
    }
  }

  String _formatYearRange(Education education) {
    final endYear = education.endYear?.toString() ?? 'Present';
    return '${education.startYear} - $endYear';
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Education'),
        actions: [
          IconButton(
            onPressed: _openEducationForm,
            tooltip: 'Add Education',
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshEducations,
        child: FutureBuilder<List<Education>>(
          future: _educationsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  const SizedBox(height: 150),
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 12),
                  const Center(child: Text('Failed to load education data.')),
                  const SizedBox(height: 12),
                  Center(
                    child: ElevatedButton(
                      onPressed: _retry,
                      child: const Text('Retry'),
                    ),
                  ),
                ],
              );
            }

            final educations = snapshot.data ?? [];

            if (educations.isEmpty) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 150),
                  Icon(Icons.school_outlined, size: 48),
                  SizedBox(height: 12),
                  Center(child: Text('No education data available.')),
                ],
              );
            }

            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: educations.length,
              itemBuilder: (context, index) {
                final education = educations[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    onTap: () => _openEducationDetail(education),
                    leading: const CircleAvatar(child: Icon(Icons.school)),
                    title: Text(
                      education.institution,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(education.degree),
                        Text(_formatYearRange(education)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text('${education.starCount}'),
                          ],
                        ),
                      ],
                    ),
                    isThreeLine: true,
                    trailing: isLoggedIn
                        ? IconButton(
                            tooltip: 'Delete Education',
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            onPressed: () => _deleteEducation(education),
                          )
                        : null,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
