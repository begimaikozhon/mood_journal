import 'package:mood_journal/features/journal/domain/entities/diary_entry.dart';

class DiaryEntryModel extends DiaryEntry {
  DiaryEntryModel({
    required super.date,
    required super.mood,
    required super.stressLevel,
    required super.selfRating,
    required super.notes,
  });

  // Пример для сохранения данных в JSON формате
  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'mood': mood,
      'stressLevel': stressLevel,
      'selfRating': selfRating,
      'notes': notes,
    };
  }

  static DiaryEntryModel fromJson(Map<String, dynamic> json) {
    return DiaryEntryModel(
      date: DateTime.parse(json['date']),
      mood: json['mood'],
      stressLevel: json['stressLevel'],
      selfRating: json['selfRating'],
      notes: json['notes'],
    );
  }
}
