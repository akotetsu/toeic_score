import 'package:flutter/material.dart';
import 'package:toeic_score/models/toeic_result.dart';

class NewToeicResult extends StatefulWidget {
  const NewToeicResult({super.key, required this.onAddToeicResult});

  final void Function(ToeicResult toeic_result) onAddToeicResult;

  @override
  State<NewToeicResult> createState() => _NewToeicResultState();
}

class _NewToeicResultState extends State<NewToeicResult> {
  final _enteredTotalScore = TextEditingController(); //自分の予想だとデータ型が理由でエラーが起こるかも
  final _enteredListeningScore = TextEditingController();
  final _enteredReadingScore = TextEditingController();
  DateTime? _selectedData;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 2, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
      //locale: const Locale('ja'), // 追加、日本語のロケールを設定
    );
    setState(() {
      _selectedData = pickedDate;
    });
  }

  void _showValidationError(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('入力エラー'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('戻る'),
          ),
        ],
      ),
    );
  }

  void _submitToeicScoreDate() {
    final enteredTotalScore = int.tryParse(_enteredTotalScore.text);
    final enteredListeningScore = int.tryParse(_enteredListeningScore.text);
    final enteredReadingScore = int.tryParse(_enteredReadingScore.text);

    if (enteredTotalScore == null ||
        enteredTotalScore < 10 || enteredTotalScore > 990) {
      _showValidationError('TOTAL SCOREは10〜990の間で入力してください。');
      return;
    }

    if (enteredListeningScore == null ||
        enteredListeningScore < 5 || enteredListeningScore > 495) {
      _showValidationError('LISTENINGは5〜495の間で入力してください。');
      return;
    }

    if (enteredReadingScore == null ||
        enteredReadingScore < 5 || enteredReadingScore > 495) {
      _showValidationError('READINGは5〜495の間で入力してください。');
      return;
    }

    if (_selectedData == null) {
      _showValidationError('受験日を選択してください。');
      return;
    }

    widget.onAddToeicResult(
      ToeicResult(
          total: enteredTotalScore.toString(),
          reading: enteredReadingScore.toString(),
          listening: enteredListeningScore.toString(),
          date: _selectedData!
      ),
    );
    Navigator.pop(context);
  }


  @override
  void dispose() {
    _enteredTotalScore.dispose();
    _enteredListeningScore.dispose();
    _enteredReadingScore.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            controller: _enteredTotalScore,
            decoration: const InputDecoration(
              label: Text('TOTAL SCORE'),
            ),
          ),
          const SizedBox(width: 16,),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _enteredListeningScore,
                  decoration: const InputDecoration(
                    label: Text('LISTENING'),
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _enteredReadingScore,
                  decoration: const InputDecoration(
                    label: Text('READING'),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _selectedData == null
                    ? '受験日が選択されていません'
                    : formatter.format(_selectedData!),
              ),
              IconButton(
                onPressed: _presentDatePicker,
                icon: const Icon(
                  Icons.calendar_month,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,//追加
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('戻る'),
              ),
              ElevatedButton(
                  onPressed: _submitToeicScoreDate,
                  child: const Text('試験結果を保存'))
            ],
          )
        ],
      ),

    );
  }
}
