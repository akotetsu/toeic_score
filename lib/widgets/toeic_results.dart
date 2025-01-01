import 'package:flutter/material.dart';
import 'package:toeic_score/models/toeic_result.dart';
import 'package:toeic_score/widgets/toeic_results_list/toeic_result_list.dart';
import 'package:toeic_score/widgets/new_toeic_result.dart';

class ToeicResults extends StatefulWidget {
  const ToeicResults({super.key});

  @override
  State<ToeicResults> createState() => _ToeicResultsState();
}

class _ToeicResultsState extends State<ToeicResults> {

  final List<ToeicResult> _registerToeicResults = [];

  void _openAddToeicResultOverlay() {
    showModalBottomSheet(
      isScrollControlled: true, // モーダルを画面全体で表示可能に
      context: context,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, // キーボードの高さを考慮
          ),
          child: NewToeicResult(
            onAddToeicResult: _addToeicResult,
          ),
        ),
      ),
    );
  }

  void _addToeicResult(ToeicResult toeic_result) {
    setState(() {
      _registerToeicResults.add(toeic_result);
    });
  }

  void _removeToeicResult(ToeicResult toeic_result) {
    final resultIndex = _registerToeicResults.indexOf(toeic_result);
    setState(() {
      _registerToeicResults.remove(toeic_result);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('結果を削除'),
        action: SnackBarAction(
          label: '戻す',
          onPressed: () {
            setState(() {
              _registerToeicResults.insert(resultIndex, toeic_result);
            });
          },
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    Widget mainContent = const Center(
      child: Text('No Toeic Scores found. Start adding some!'),
    );

    if (_registerToeicResults.isNotEmpty) {
      mainContent = ToeicResultList(
        toeicresults: _registerToeicResults,
        onRemoveToeicResult: _removeToeicResult,
      );
    }
    //記録追加をAppBarのアイコンからfloatingactionbuttonに変更
    return Scaffold(
      appBar: AppBar(
        title: const Text('TOEIC 受験記録'),
          centerTitle: true //追加
      ),
      body: Column(
        children: [
          const Text('結果一覧'),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: _openAddToeicResultOverlay,
          icon: const Icon(Icons.add),
          label: const Text("追加する"),
      ),
    );
  }
}
