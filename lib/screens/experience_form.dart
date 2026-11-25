import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _thumbnailController = TextEditingController();

  String _category = 'Internship';
  DateTime? _endedAt;
  bool _isOngoing = true;

  final List<String> _categories = [
    'Internship',
    'Research',
    'Volunteer',
    'Part-Time',
    'Full-Time',
    'Freelance',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _thumbnailController.dispose();
    super.dispose();
  }

  Future<void> _selectEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _endedAt = picked;
      });
    }
  }

  void _showResult() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final String title = _titleController.text.trim();
    final String description = _descriptionController.text.trim();
    final String thumbnail = _thumbnailController.text.trim();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF5F0E7),
          title: const Text(
            'Experience berhasil ditambahkan!',
            style: TextStyle(
              color: Color(0xFF292820),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Title: $title'),
                const SizedBox(height: 8),
                Text('Description: $description'),
                const SizedBox(height: 8),
                Text('Category: $_category'),
                const SizedBox(height: 8),
                Text('Thumbnail: ${thumbnail.isEmpty ? '-' : thumbnail}'),
                const SizedBox(height: 8),
                Text(
                  'Status: ${_isOngoing ? 'Sedang berlangsung' : 'Selesai'}',
                ),
                if (!_isOngoing && _endedAt != null)
                  Text(
                    'Ended At: ${MaterialLocalizations.of(context).formatMediumDate(_endedAt!)}',
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                setState(() {
                  _formKey.currentState!.reset();
                  _titleController.clear();
                  _descriptionController.clear();
                  _thumbnailController.clear();
                  _category = 'Internship';
                  _endedAt = null;
                  _isOngoing = true;
                });
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Color(0xFF3F4D30)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const ink = Color(0xFF292820);
    const paper = Color(0xFFF5F0E7);
    const accentDark = Color(0xFF3F4D30);

    return Scaffold(
      backgroundColor: paper,
      appBar: AppBar(
        title: const Text(
          'Add Experience',
          style: TextStyle(color: paper, fontWeight: FontWeight.bold),
        ),
        backgroundColor: accentDark,
        foregroundColor: paper,
      ),

      drawer: const LeftDrawer(),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Experience',
                style: TextStyle(
                  color: ink,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Fill in the details of your experience.',
                style: TextStyle(color: Color(0xFF625D54)),
              ),
              const SizedBox(height: 24),

              // Title
              _buildLabel('Title'),
              TextFormField(
                controller: _titleController,
                decoration: _inputDecoration('Nama pengalaman'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Title tidak boleh kosong!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),

              // Description
              _buildLabel('Description'),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: _inputDecoration('Deskripsikan pengalaman...'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Description tidak boleh kosong!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),

              // Category
              _buildLabel('Category'),
              DropdownButtonFormField<String>(
                initialValue: _category,
                decoration: _inputDecoration('Pilih kategori'),
                items: _categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pilih kategori pengalaman!';
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _category = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 18),

              // Thumbnail URL
              _buildLabel('Thumbnail URL (Optional)'),
              TextFormField(
                controller: _thumbnailController,
                keyboardType: TextInputType.url,
                decoration: _inputDecoration('https://example.com/image.jpg'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return null;
                  }

                  final uri = Uri.tryParse(value.trim());

                  if (uri == null ||
                      !uri.hasScheme ||
                      (uri.scheme != 'http' && uri.scheme != 'https') ||
                      uri.host.isEmpty) {
                    return 'Masukkan URL yang valid!';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 18),

              // Ongoing status
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                activeColor: accentDark,
                title: const Text(
                  'Currently Ongoing',
                  style: TextStyle(color: ink),
                ),
                value: _isOngoing,
                onChanged: (value) {
                  setState(() {
                    _isOngoing = value ?? false;

                    if (_isOngoing) {
                      _endedAt = null;
                    }
                  });
                },
              ),

              // Ended At
              if (!_isOngoing) ...[
                _buildLabel('Ended At'),
                FormField<DateTime>(
                  validator: (_) {
                    if (!_isOngoing && _endedAt == null) {
                      return 'Tanggal selesai harus dipilih!';
                    }
                    return null;
                  },
                  builder: (field) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {
                            await _selectEndDate();
                            field.didChange(_endedAt);
                          },
                          child: InputDecorator(
                            decoration:
                                _inputDecoration('Pilih tanggal selesai')
                                    .copyWith(
                                      errorText: field.errorText,
                                      suffixIcon: const Icon(
                                        Icons.calendar_today,
                                        color: accentDark,
                                      ),
                                    ),
                            child: Text(
                              _endedAt == null
                                  ? 'Belum dipilih'
                                  : MaterialLocalizations.of(context)
                                        .formatMediumDate(_endedAt!),
                              style: TextStyle(
                                color: _endedAt == null
                                    ? const Color(0xFF625D54)
                                    : ink,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],

              const SizedBox(height: 28),

              // Save button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _showResult,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentDark,
                    foregroundColor: paper,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Save Experience',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF292820),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFFFFDF8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFD8CDBD)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFFD8CDBD)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF65754B), width: 1.5),
      ),
    );
  }
}
