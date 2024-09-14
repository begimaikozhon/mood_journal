import 'package:flutter/material.dart';

class StatisticsWidget extends StatelessWidget {
  const StatisticsWidget({super.key});
  @override
  Widget build(BuildContext context) {
    // Реализация экрана "Статистика"
    return const Padding(
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Text(
          'Здесь будет отображаться статистика',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
