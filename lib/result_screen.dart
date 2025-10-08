import 'package:flutter/material.dart';
import 'start_screen.dart';
import 'package:quiziz/styles/app_color.dart';

class ResultScreen extends StatelessWidget {
  final int finalScore;
  final int totalQuestions;

  const ResultScreen({
    super.key,
    required this.finalScore,
    required this.totalQuestions,
  });

  Map<String, dynamic> get feedback {
    final percentage = (finalScore / totalQuestions) * 100;

    if (percentage == 100) {
      return {'phrase': 'Sempurna! Anda adalah Mahaguru Pengetahuan!', 'color': AppColors.successGreen};
    } else if (percentage >= 80) {
      return {'phrase': 'Luar Biasa! Pengetahuan Anda sangat luas.', 'color': AppColors.successGreen};
    } else if (percentage >= 50) {
      return {'phrase': 'Cukup Baik! Sedikit lagi menuju puncak.', 'color': AppColors.brightYellow};
    } else {
      return {'phrase': 'Terus Belajar! Jangan menyerah, coba lagi.', 'color': AppColors.wrongRed};
    }
  }

  @override
  Widget build(BuildContext context) {
    final resultFeedback = feedback;

    return Scaffold(
      backgroundColor: AppColors.deepNavy,
      appBar: AppBar(
        backgroundColor: AppColors.deepNavy,
        foregroundColor: AppColors.brightYellow,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Skor Akhir Anda:',
                  style: TextStyle(fontSize: 28, color: Colors.white70, ),
                ),
                const SizedBox(height: 10),

                TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: finalScore.toDouble()),
                    duration: const Duration(milliseconds: 1500),
                    builder: (context, value, child) {
                      final animatedScore = value.toInt();

                      return Text(
                        '$animatedScore / $totalQuestions',
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.w900,
                          color: resultFeedback['color']
                        ),
                      );
                    }
                ),
                const SizedBox(height: 30),
                Card(
                  color: AppColors.white,
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      resultFeedback['phrase'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                          color: AppColors.deepNavy,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const StartScreen()),
                    );
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Ulangi Kuis'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brightYellow,
                    foregroundColor: AppColors.darkText,
                    padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 18),
                    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}