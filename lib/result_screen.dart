import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final VoidCallback onRestart;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    double percentage =
        (score / totalQuestions) * 100; // Calculate the percentage

    // Determine the number of stars based on the percentage
    int starCount = 0;
    if (percentage >= 40) starCount = 1;
    if (percentage >= 80) starCount = 2;
    if (percentage == 100) starCount = 3;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Central larger star
                if (starCount > 0)
                  const Icon(
                    Icons.star,
                    size: 80,
                    color: Colors.yellow,
                  ),
                // Smaller stars with spacing
                if (starCount > 1)
                  Positioned(
                    left: 60, // Increased left position for spacing
                    bottom: 10,
                    child: const Icon(
                      Icons.star,
                      size: 50,
                      color: Colors.yellow,
                    ),
                  ),
                if (starCount > 2)
                  Positioned(
                    right: 60, // Increased right position for spacing
                    bottom: 10,
                    child: const Icon(
                      Icons.star,
                      size: 50,
                      color: Colors.yellow,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Your Score: $score / $totalQuestions',
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRestart,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              child: const Text(
                'Restart Quiz',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
