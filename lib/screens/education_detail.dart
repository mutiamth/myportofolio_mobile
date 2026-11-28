import 'package:material_ui/material_ui.dart';

import 'package:myportofolio_mobile/models/education.dart';

class EducationDetailScreen extends StatelessWidget {
  const EducationDetailScreen({super.key, required this.education});

  final Education education;

  String get _endYear => education.endYear?.toString() ?? 'Present';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Education Detail')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                child: Icon(Icons.school, size: 40),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                education.institution,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                education.degree,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 28),
            const Divider(),
            _buildDetail(
              icon: Icons.school_outlined,
              label: 'Institution',
              value: education.institution,
            ),
            _buildDetail(
              icon: Icons.workspace_premium_outlined,
              label: 'Degree',
              value: education.degree,
            ),
            _buildDetail(
              icon: Icons.calendar_today_outlined,
              label: 'Start Year',
              value: education.startYear.toString(),
            ),
            _buildDetail(
              icon: Icons.event_outlined,
              label: 'End Year',
              value: _endYear,
            ),
            _buildDetail(
              icon: Icons.star_outline,
              label: 'Star Count',
              value: education.starCount.toString(),
            ),
            const SizedBox(height: 12),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetail({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
