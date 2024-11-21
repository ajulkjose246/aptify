import 'package:flutter/material.dart';

class QuizProgress extends StatefulWidget {
  const QuizProgress({super.key});

  @override
  State<QuizProgress> createState() => _QuizProgressState();
}

class _QuizProgressState extends State<QuizProgress> {
  // Sample data - replace with actual quiz progress data
  final int currentQuestion = 19;
  final Set<int> solvedQuestions = {1, 2, 3, 4, 5, 6, 7, 12, 16, 17};

  @override
  Widget build(BuildContext context) {
    final completionPercentage = (solvedQuestions.length / 30 * 100).toInt();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Quiz Progress'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Progress indicator

            // Grid of question boxes
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemCount: 30,
                itemBuilder: (context, index) {
                  final questionNumber = index + 1;
                  return QuestionBox(
                    number: questionNumber,
                    state: _getQuestionState(questionNumber),
                  );
                },
              ),
            ),

            // Legend
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildLegendItem('Solved', Colors.lime.shade200),
                  _buildLegendItem('Current', Colors.teal),
                  _buildLegendItem('Unsolved', Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  QuestionState _getQuestionState(int number) {
    if (number == currentQuestion) return QuestionState.current;
    if (solvedQuestions.contains(number)) return QuestionState.solved;
    return QuestionState.unsolved;
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

enum QuestionState { solved, current, unsolved }

class QuestionBox extends StatelessWidget {
  final int number;
  final QuestionState state;

  const QuestionBox({
    super.key,
    required this.number,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/question-screen',
          arguments: number, // Pass the question number to the next screen
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: _getColor(),
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(
              color: state == QuestionState.current
                  ? Colors.white
                  : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Color _getColor() {
    switch (state) {
      case QuestionState.solved:
        return Colors.lime.shade200;
      case QuestionState.current:
        return Colors.teal;
      case QuestionState.unsolved:
        return Colors.white;
    }
  }
}
