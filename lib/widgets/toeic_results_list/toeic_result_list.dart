import 'package:flutter/material.dart';
import 'package:toeic_score/models/toeic_result.dart';
import 'package:toeic_score/widgets/toeic_results_list/toeic_result_item.dart';

class ToeicResultList extends StatelessWidget {
  const ToeicResultList({
    super.key,
    required this.toeicresults,
    required this.onRemoveToeicResult
  });

  final List<ToeicResult> toeicresults;
  final void Function(ToeicResult toeicresult) onRemoveToeicResult;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: toeicresults.length,
      itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(toeicresults[index]),
          onDismissed: (direction) {
            onRemoveToeicResult(toeicresults[index]);
          },
          child: ToeicResultItem(toeicresults[index])),

    );
  }
}
