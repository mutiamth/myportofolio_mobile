import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _projectNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _technologiesController = TextEditingController();
  final _projectLinkController = TextEditingController();
  final _imageUrlController = TextEditingController();

  bool _isSubmitting = false;

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    // Pastikan pengguna sudah login.
    final loggedIn = await ensureLoggedIn(context);

    if (!mounted || !loggedIn) return;

    final authState = context.read<AuthState>();
    final token = authState.token;

    if (token == null) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final project = Project(
        title: _projectNameController.text.trim(),
        description: _descriptionController.text.trim(),
        techStack: _technologiesController.text.trim(),
        projectUrl: _projectLinkController.text.trim(),
        projectImageUrl: _imageUrlController.text.trim(),
      );

      await context.read<ApiClient>().createProject(project, token: token);

      if (!mounted) return;

      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Berhasil!'),
            content: const Text('Proyek berhasil ditambahkan ke portofolio.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      if (!mounted) return;

      _formKey.currentState!.reset();
      _projectNameController.clear();
      _descriptionController.clear();
      _technologiesController.clear();
      _projectLinkController.clear();
      _imageUrlController.clear();
    } on ApiException catch (e) {
      if (!mounted) return;

      if (e.statusCode == 401) {
        // Token tidak valid atau sesi sudah berakhir.
        try {
          await authState.logout();
        } catch (_) {
          // Tetap tampilkan pesan sesi berakhir.
        }

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sesi login berakhir. Silakan login kembali.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Gagal menambahkan proyek (${e.statusCode}): ${e.message}',
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _projectNameController.dispose();
    _descriptionController.dispose();
    _technologiesController.dispose();
    _projectLinkController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Project Form',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Field Nama Proyek
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _projectNameController,
                  decoration: InputDecoration(
                    hintText: 'Nama Proyek',
                    labelText: 'Nama Proyek',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama proyek tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),

              // Field Deskripsi
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Deskripsi Proyek',
                    labelText: 'Deskripsi Proyek',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Deskripsi proyek tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),

              // Field Teknologi
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _technologiesController,
                  decoration: InputDecoration(
                    hintText: 'Contoh: Flutter, Django, Figma',
                    labelText: 'Teknologi yang Digunakan',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Teknologi tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),

              // Field Tautan Proyek
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _projectLinkController,
                  decoration: InputDecoration(
                    hintText: 'URL Proyek',
                    labelText: 'Tautan Proyek',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'URL proyek tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),

              // Field URL Gambar (opsional)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _imageUrlController,
                  decoration: InputDecoration(
                    hintText: 'URL gambar (opsional)',
                    labelText: 'Project Image URL',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),

              // Tombol Save
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: _isSubmitting ? null : _submitForm,
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
