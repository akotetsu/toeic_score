import 'package:toeic_score/models/toeic_result.dart';
import 'package:flutter/material.dart';

class ToeicResultItem extends StatelessWidget {
  const ToeicResultItem(this.toeicresult, {super.key});

  final ToeicResult toeicresult;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16
        ),
        child: Column(
          children: [
            Text('TOTAL ${toeicresult.total}',
              style: const TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,),
            ),
            const SizedBox(height: 4,),
            Row(
              //デザインを変更した
              children: [
                Expanded(child: Column(
                  children: [
                    Text('LISTENING'),
                    Text(toeicresult.listening),
                  ],
                )),
                const SizedBox(width: 12,),
                Expanded(child: Column(
                  children: [
                    Text('READING'),
                    Text(toeicresult.reading),
                  ],
                )),
                const SizedBox(width: 20,),
                Expanded(child: Column(
                  children: [
                    Text('受験日'),//追加
                    Text(toeicresult.formattedDate),
                  ],
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
