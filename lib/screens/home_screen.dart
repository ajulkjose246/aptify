import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<SubjectData> subjects = [
    SubjectData('Geometry', Icons.person, const Color(0xFF006B5E)),
    SubjectData('Physics', Icons.blur_circular, Colors.white, true),
    SubjectData('Chemistry', Icons.science_outlined, Colors.white, true),
    SubjectData('Biology', Icons.biotech, Colors.white, true),
    SubjectData('Mathematics', Icons.functions, Colors.white, true),
    SubjectData('Literature', Icons.book, Colors.white, true),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Hello',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      const Text(
                        'Brooklyn Simmons',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.grid_view_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'What Subject do\nyou want to improve\ntoday?',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search here',
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              GridView.count(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                children: subjects
                    .map((subject) => _buildSubjectCard(
                          subject.title,
                          subject.icon,
                          subject.backgroundColor,
                          iconColor:
                              subject.isDark ? Colors.black : Colors.white,
                          textColor:
                              subject.isDark ? Colors.black : Colors.white,
                        ))
                    .toList(),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectCard(String title, IconData icon, Color backgroundColor,
      {Color iconColor = Colors.white, Color textColor = Colors.white}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/quiz-progress');
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: iconColor,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectData {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final bool isDark;

  SubjectData(this.title, this.icon, this.backgroundColor,
      [this.isDark = false]);
}
