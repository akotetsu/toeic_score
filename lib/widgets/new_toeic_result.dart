import 'package:flutter/material.dart';
import 'package:toeic_score/models/toeic_result.dart';

class NewToeicResult extends StatefulWidget {
  const NewToeicResult({super.key, required this.onAddToeicResult});

  // スコアを追加するためのコールバック関数
  final void Function(ToeicResult toeic_result) onAddToeicResult;

  @override
  State<NewToeicResult> createState() => _NewToeicResultState();
}

class _NewToeicResultState extends State<NewToeicResult> {
  // 入力フィールド用のコントローラーを定義
  final _totalScoreController = TextEditingController();
  final _listeningScoreController = TextEditingController();
  final _readingScoreController = TextEditingController();

  // 日付選択用の変数
  DateTime? _selectedDate;

  // 各フィールドのエラー状態を保持
  String? _totalError;
  String? _listeningError;
  String? _readingError;

  // 日付ピッカーを表示するメソッド
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 2, now.month, now.day); // 2年前から選択可能
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate; // 選択した日付を状態に保存
    });
  }

  // 入力バリデーションを行うメソッド
  void _validateInputs() {
    setState(() {
      // 各入力値を数値に変換し、範囲チェックを行う
      final totalScore = int.tryParse(_totalScoreController.text);
      final listeningScore = int.tryParse(_listeningScoreController.text);
      final readingScore = int.tryParse(_readingScoreController.text);

      // TOTAL SCOREのバリデーション
      _totalError = (totalScore == null || totalScore < 10 || totalScore > 990)
          ? '10〜990の間で入力してください。'
          : null;

      // LISTENING SCOREのバリデーション
      _listeningError = (listeningScore == null || listeningScore < 5 || listeningScore > 495)
          ? '5〜495の間で入力してください。'
          : null;

      // READING SCOREのバリデーション
      _readingError = (readingScore == null || readingScore < 5 || readingScore > 495)
          ? '5〜495の間で入力してください。'
          : null;
    });
  }

  // 入力データを保存するメソッド
  void _submitToeicScoreData() {
    _validateInputs(); // 入力値をチェック
    if (_totalError == null &&
        _listeningError == null &&
        _readingError == null &&
        _selectedDate != null) {
      widget.onAddToeicResult(
        ToeicResult(
          total: int.parse(_totalScoreController.text),
          listening: int.parse(_listeningScoreController.text),
          reading: int.parse(_readingScoreController.text),
          date: _selectedDate!,
        ),
      );
      Navigator.pop(context); // モーダルを閉じる
    }
  }

  @override
  void dispose() {
    // 使用後にコントローラーを破棄
    _totalScoreController.dispose();
    _listeningScoreController.dispose();
    _readingScoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ダークモードかどうかを判定
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView( // 入力画面をスクロール可能に
      child: Padding(
        padding: EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16, // キーボードの高さを考慮
        ),
        child: Column(
          children: [
            const SizedBox(height: 30), // 上部に余白
            TextField(
              keyboardType: TextInputType.number, // 数値入力を指定
              controller: _totalScoreController,
              decoration: InputDecoration(
                label: const Text('TOTAL SCORE'),
                labelStyle: TextStyle(
                  color: isDarkMode ? Colors.white70 : Colors.grey, // ダークモード対応
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                errorText: _totalError, // エラー時のメッセージ表示
              ),
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black, // 入力文字の色
              ),
              onChanged: (_) => _validateInputs(),
            ),
            const SizedBox(height: 16), // 下部に余白
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _listeningScoreController,
                    decoration: InputDecoration(
                      label: const Text('LISTENING'),
                      labelStyle: TextStyle(
                        color: isDarkMode ? Colors.white70 : Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorText: _listeningError,
                    ),
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    onChanged: (_) => _validateInputs(),
                  ),
                ),
                const SizedBox(width: 16), // 左右のフィールド間に余白
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _readingScoreController,
                    decoration: InputDecoration(
                      label: const Text('READING'),
                      labelStyle: TextStyle(
                        color: isDarkMode ? Colors.white70 : Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      errorText: _readingError,
                    ),
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    onChanged: (_) => _validateInputs(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _selectedDate == null
                      ? '受験日が選択されていません'
                      : formatter.format(_selectedDate!), // 選択日付を表示
                  style: TextStyle(
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                ),
                IconButton(
                  onPressed: _presentDatePicker,
                  icon: Icon(
                    Icons.calendar_month,
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // モーダルを閉じる
                  },
                  child: Text(
                    '戻る',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white70 : Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _submitToeicScoreData, // 入力内容を保存
                  child: const Text('試験結果を保存'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
