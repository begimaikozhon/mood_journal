// lib/domain/entities/diary_entry.dart

class DiaryEntry {
  final DateTime date;
  final String mood;
  final double stressLevel;
  final double selfRating;
  final String notes;

  DiaryEntry({
    required this.date,
    required this.mood,
    required this.stressLevel,
    required this.selfRating,
    required this.notes,
  });
}
