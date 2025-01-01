import 'package:flutter/material.dart';
import 'package:toeic_score/models/toeic_result.dart';

class ToeicResultItem extends StatelessWidget {
  const ToeicResultItem(this.toeicresult, {super.key});

  final ToeicResult toeicresult;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'TOTAL: ${toeicresult.total}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildScoreSection(
                  icon: Icons.headset,
                  label: 'LISTENING',
                  value: toeicresult.listening,
                ),
                _buildScoreSection(
                  icon: Icons.menu_book,
                  label: 'READING',
                  value: toeicresult.reading,
                ),
                _buildScoreSection(
                  icon: Icons.calendar_today,
                  label: '受験日',
                  value: toeicresult.formattedDate,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreSection({
    required IconData icon,
    required String label,
    required dynamic value,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.blueAccent, size: 28),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 2),
        Text(
          value.toString(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
