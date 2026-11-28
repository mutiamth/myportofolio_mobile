import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import 'package:myportofolio_mobile/models/education.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _institutionController = TextEditingController();
  final _degreeController = TextEditingController();
  final _startYearController = TextEditingController();
  final _endYearController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _institutionController.dispose();
    _degreeController.dispose();
    _startYearController.dispose();
    _endYearController.dispose();
    super.dispose();
  }

  Future<void> _submitEducation() async {
    if (!_formKey.currentState!.validate()) return;

    final loggedIn = await ensureLoggedIn(context);
    if (!mounted || !loggedIn) return;

    final token = context.read<AuthState>().token;

    if (token == null || token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan login terlebih dahulu.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final education = Education(
      institution: _institutionController.text.trim(),
      degree: _degreeController.text.trim(),
      startYear: int.parse(_startYearController.text.trim()),
      endYear: _endYearController.text.trim().isEmpty
          ? null
          : int.parse(_endYearController.text.trim()),
    );

    try {
      await context.read<ApiClient>().createEducation(education, token: token);

      if (!mounted) return;

      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Berhasil'),
          content: const Text('Education berhasil ditambahkan.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('OK'),
            ),
          ],
        ),
      );

      if (!mounted) return;
      Navigator.pop(context, true);
    } on ApiException catch (e) {
      if (!mounted) return;

      if (e.statusCode == 401) {
        await context.read<AuthState>().logout();

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Session expired. Silakan login kembali.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menambahkan education: ${e.message}')),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String? _validateYear(String? value, {bool required = false}) {
    if (value == null || value.trim().isEmpty) {
      return required ? 'Tahun wajib diisi.' : null;
    }

    final year = int.tryParse(value.trim());

    if (year == null || year < 1900 || year > 2100) {
      return 'Masukkan tahun yang valid.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Education')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _institutionController,
                decoration: const InputDecoration(
                  labelText: 'Institution',
                  hintText: 'Example: Universitas Indonesia',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.school),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Institution wajib diisi.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _degreeController,
                decoration: const InputDecoration(
                  labelText: 'Degree',
                  hintText: 'Example: Bachelor of Computer Science',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.workspace_premium),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Degree wajib diisi.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _startYearController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Start Year',
                  hintText: 'Example: 2025',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                validator: (value) => _validateYear(value, required: true),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _endYearController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'End Year (Optional)',
                  hintText: 'Leave empty if currently studying',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.event),
                ),
                validator: (value) {
                  final error = _validateYear(value);

                  if (error != null) return error;

                  final startYear = int.tryParse(
                    _startYearController.text.trim(),
                  );
                  final endYear = int.tryParse(value?.trim() ?? '');

                  if (startYear != null &&
                      endYear != null &&
                      endYear < startYear) {
                    return 'End Year tidak boleh sebelum Start Year.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 24),

              ElevatedButton.icon(
                onPressed: _isLoading ? null : _submitEducation,
                icon: _isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save),
                label: Text(_isLoading ? 'Saving...' : 'Save Education'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
