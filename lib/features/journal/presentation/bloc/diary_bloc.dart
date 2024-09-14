// lib/presentation/bloc/diary_cubit.dart

// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:mood_journal/features/journal/domain/entities/diary_entry.dart';
import '../../domain/usecases/save_diary_entry.dart';

class DiaryCubit extends Cubit<List<DiaryEntry>> {
  final SaveDiaryEntry saveDiaryEntry;

  DiaryCubit(this.saveDiaryEntry) : super([]);

  void addDiaryEntry(DiaryEntry entry) async {
    try {
      await saveDiaryEntry.call(entry);
      emit([...state, entry]); // обновляем состояние
    } catch (e) {
      // обрабатываем ошибку
      print(e.toString());
    }
  }
}
