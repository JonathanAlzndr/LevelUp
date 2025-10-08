import 'package:flutter/material.dart';
import 'package:quiziz/models/question_data.dart';
import 'result_screen.dart';
import 'package:quiziz/styles/app_color.dart';
import 'dart:async';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _totalScore = 0;
  String? _selectedAnswer;
  bool _isAnswerLocked = false;

  int _currentTimer = 15;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();

    _currentTimer = 15;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      if (_currentTimer == 1) {
        timer.cancel();
        _answerQuestion('TIME_OUT');
      } else {
        setState(() {
          _currentTimer--;
        });
      }
    });
  }

  void _answerQuestion(String selectedAnswer) {
    if (_isAnswerLocked) return;

    _timer?.cancel();

    setState(() {
      _selectedAnswer = selectedAnswer;
      _isAnswerLocked = true;
    });

    final currentQuestion = quizData[_questionIndex];
    if (selectedAnswer != 'TIME_OUT' && selectedAnswer == currentQuestion.correctAnswer) {
      _totalScore += 1;
    }

    Future.delayed(const Duration(milliseconds: 1000), () {

      if (!mounted) return;

      if (_questionIndex + 1 >= quizData.length) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              finalScore: _totalScore,
              totalQuestions: quizData.length,
            ),
          ),
        );
      } else {
        setState(() {
          _isAnswerLocked = false;
          _selectedAnswer = null;
          _questionIndex += 1;
          _startTimer();
        });
      }
    });
  }

  Color _getButtonColor(String option) {
    if (_selectedAnswer == null) {
      return AppColors.brightYellow;
    }

    final currentQuestion = quizData[_questionIndex];

    if (option == currentQuestion.correctAnswer) {
      return AppColors.successGreen;
    } else if (option == _selectedAnswer) {
      return AppColors.wrongRed;
    }

    return AppColors.brightYellow;
  }

  @override
  Widget build(BuildContext context) {
    if (_questionIndex >= quizData.length) {
      return const Scaffold(
        backgroundColor: AppColors.deepNavy,
        body: Center(child: CircularProgressIndicator(color: AppColors.brightYellow)),
      );
    }

    final currentQuestion = quizData[_questionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('LevelUp: Uji Pengetahuan'),
        backgroundColor: AppColors.deepNavy,
        foregroundColor: AppColors.brightYellow,
        elevation: 0,
      ),
      backgroundColor: AppColors.deepNavy,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Waktu Tersisa: $_currentTimer detik',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _currentTimer <= 5 ? AppColors.wrongRed : AppColors.brightYellow,
                ),
              ),
              const SizedBox(height: 10),

              LinearProgressIndicator(
                value: (_questionIndex + 1) / quizData.length,
                backgroundColor: AppColors.deepNavy,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.brightYellow),
                minHeight: 10,
              ),
              const SizedBox(height: 20),

              Card(
                color: AppColors.white,
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Text(
                        'Pertanyaan ${_questionIndex + 1} dari ${quizData.length}',
                        style: TextStyle(fontSize: 18, color: AppColors.vibrantOrange, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        currentQuestion.questionText,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.deepNavy),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              ...currentQuestion.options.map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: _isAnswerLocked ? null : () => _answerQuestion(option),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _getButtonColor(option),
                      foregroundColor: AppColors.darkText,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      disabledBackgroundColor: _getButtonColor(option),
                      disabledForegroundColor: AppColors.disabledDarkText,
                    ),
                    child: Text(
                      option,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}