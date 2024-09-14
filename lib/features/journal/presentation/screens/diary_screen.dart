// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:intl/intl.dart';
import 'package:mood_journal/core/utils/constants.dart';
import 'package:mood_journal/features/journal/presentation/widgets/table_complex_example.dart';
import 'package:mood_journal/features/journal/presentation/widgets/statistics_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  int selectedIndex = 0;
  int selectedMood = -1;
  String? mood;
  double stressLevel = 0;
  double selfRating = 0;
  final TextEditingController notesController = TextEditingController();
  // Текущая дата и время
  DateTime _currentDateTime = DateTime.now();
  Map<DateTime, List<String>> savedNotes = {};

  // Метод для форматирования даты и времени
  String _formatDateTime(DateTime dateTime) {
    return DateFormat('d MMMM HH:mm', 'ru_RU').format(dateTime);
  }

// Проверка, заполнены ли все значения
  bool get isFormComplete => stressLevel > 0 || selfRating > 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                // Действие при нажатии на левую кнопку
              },
            ),
            title: Text(
              _formatDateTime(
                  _currentDateTime), // Отображение форматированной даты и времени,
              style: TextStyle(
                color: AppColors.seriy2,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ), // Стиль для текста
            ),
            centerTitle: true, // Чтобы текст был по центру
            actions: [
              IconButton(
                  icon: const Icon(
                    Icons.calendar_month,
                    color: AppColors.seriy2,
                  ),
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                EventsCalendarScreen(savedNotes: savedNotes)),
                      )),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
                delegate: SliverChildListDelegate([
              // Переключатель "Дневник настроения" и "Статистика"
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.seriy4,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Кнопка "Дневник настроения"
                      TabSwitchingWidget(
                        selectedIndex: selectedIndex,
                        flex: 3,
                        onTap: () {
                          setState(() {
                            selectedIndex = 0;
                          });
                        },
                        color: selectedIndex == 0
                            ? AppColors.mandarinColor
                            : AppColors.seriy4,
                        image: 'assets/Group 1532540041.png',
                        color1: selectedIndex == 0
                            ? AppColors.white
                            : AppColors.seriy2,
                      ),
                      // Кнопка "Статистика"
                      TabSwitchingWidget(
                        selectedIndex: selectedIndex,
                        flex: 2,
                        onTap: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                        color: selectedIndex == 1
                            ? AppColors.mandarinColor
                            : AppColors.seriy4,
                        image: 'assets/Icons.png',
                        color1: selectedIndex == 1
                            ? AppColors.white
                            : AppColors.seriy2,
                      ),
                    ],
                  ),
                ),
              ),
              // Контент экрана
              IndexedStack(
                index: selectedIndex,
                children: [
                  MoodDiaryWidget(
                    selectedMood: selectedMood,
                    stressLevel: stressLevel,
                    label: '$stressLevel',
                    onChanged: (value) {
                      setState(() {
                        stressLevel = value;
                      });
                    },
                    assetPath1: 'assets/Rectangle 2440 (1).png',
                    mood1: 'Радость',
                    assetPath2: 'assets/Rectangle 2440 (2).png',
                    mood2: 'Страх',
                    assetPath3: 'assets/Rectangle 2440 (3).png',
                    mood3: 'Бешенство',
                    assetPath4: 'assets/Rectangle 2440 (4).png',
                    mood4: 'Грусть',
                    assetPath5: 'assets/Rectangle 2440 (5).png',
                    mood5: 'Спокойствие',
                    assetPath6: 'assets/Rectangle 2440 (6).png',
                    mood6: 'Сила',
                    onTap1: () {
                      setState(() {
                        selectedMood = 0;
                      });
                    },
                    onTap2: () {
                      setState(() {
                        selectedMood = 1;
                      });
                    },
                    onTap3: () {
                      setState(() {
                        selectedMood = 2;
                      });
                    },
                    onTap4: () {
                      setState(() {
                        selectedMood = 3;
                      });
                    },
                    onTap5: () {
                      setState(() {
                        selectedMood = 4;
                      });
                    },
                    onTap6: () {
                      setState(() {
                        selectedMood = 5;
                      });
                    },
                    color1: selectedMood == 0
                        ? AppColors.mandarinColor
                        : AppColors.white,
                    color2: selectedMood == 1
                        ? AppColors.mandarinColor
                        : AppColors.white,
                    color3: selectedMood == 2
                        ? AppColors.mandarinColor
                        : AppColors.white,
                    color4: selectedMood == 3
                        ? AppColors.mandarinColor
                        : AppColors.white,
                    color5: selectedMood == 4
                        ? AppColors.mandarinColor
                        : AppColors.white,
                    color6: selectedMood == 5
                        ? AppColors.mandarinColor
                        : AppColors.white,
                    notesController: notesController,
                    onSave: (selectedSubMood) {
                      setState(() {
                        savedNotes[_currentDateTime] = [
                          'Настроение: ${selectedMood == 0 ? selectedSubMood : selectedMood}',
                          'Уровень стресса: $stressLevel',
                          'Самооценка: $selfRating',
                          'Заметка: ${notesController.text}'
                        ];
                      });
                    },
                    selfRating: selfRating,
                  ),
                  //Экран "Статистика"
                  const StatisticsWidget()
                ],
              ),
            ])),
          ),
        ],
      ),
    );
  }
}

class TabSwitchingWidget extends StatelessWidget {
  const TabSwitchingWidget({
    super.key,
    required this.selectedIndex,
    required this.flex,
    required this.onTap,
    required this.color,
    required this.image,
    required this.color1,
  });

  final int selectedIndex;
  final int flex;
  final Function() onTap;
  final Color color, color1;

  final String image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.horizontal(
              right: Radius.circular(20),
              left: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                color: color1,
                width: 12,
                height: 12,
              ),
              const SizedBox(width: 8),
              Text(
                'Статистика',
                style: TextStyle(
                  color: color1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoodDiaryWidget extends StatefulWidget {
  final TextEditingController notesController;
  final int selectedMood;
  double stressLevel;
  double selfRating;
  final Function(double)? onChanged;
  final String label;
  final Function(String selectedSubMood) onSave;
  final Function() onTap1, onTap2, onTap3, onTap4, onTap5, onTap6;
  final Color color1, color2, color3, color4, color5, color6;
  final String assetPath1,
      assetPath2,
      assetPath3,
      assetPath4,
      assetPath5,
      assetPath6,
      mood1,
      mood2,
      mood3,
      mood4,
      mood5,
      mood6;
  MoodDiaryWidget({
    super.key,
    required this.stressLevel,
    required this.selfRating,
    this.onChanged,
    required this.label,
    required this.assetPath1,
    required this.assetPath2,
    required this.assetPath3,
    required this.assetPath4,
    required this.assetPath5,
    required this.assetPath6,
    required this.mood1,
    required this.mood2,
    required this.mood3,
    required this.mood4,
    required this.mood5,
    required this.mood6,
    required this.onTap1,
    required this.onTap2,
    required this.onTap3,
    required this.onTap4,
    required this.onTap5,
    required this.onTap6,
    required this.color1,
    required this.color2,
    required this.color3,
    required this.color4,
    required this.color5,
    required this.color6,
    required this.selectedMood,
    required this.notesController,
    required this.onSave,
  });

  @override
  State<MoodDiaryWidget> createState() => _MoodDiaryWidgetState();
}

class _MoodDiaryWidgetState extends State<MoodDiaryWidget> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // Реализация экрана "Дневник настроения"
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Что чувствуешь?',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            // Горизонтальный список эмоций
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MoodOptionWidget(
                    onTap: widget.onTap1,
                    color: widget.color1,
                    assetPath: widget.assetPath1,
                    mood: widget.mood1,
                  ),
                  MoodOptionWidget(
                    onTap: widget.onTap2,
                    color: widget.color2,
                    assetPath: widget.assetPath2,
                    mood: widget.mood2,
                  ),
                  MoodOptionWidget(
                    onTap: widget.onTap3,
                    color: widget.color3,
                    assetPath: widget.assetPath3,
                    mood: widget.mood3,
                  ),
                  MoodOptionWidget(
                    onTap: widget.onTap4,
                    color: widget.color4,
                    assetPath: widget.assetPath4,
                    mood: widget.mood4,
                  ),
                  MoodOptionWidget(
                    onTap: widget.onTap5,
                    color: widget.color5,
                    assetPath: widget.assetPath5,
                    mood: widget.mood5,
                  ),
                  MoodOptionWidget(
                    onTap: widget.onTap6,
                    color: widget.color6,
                    assetPath: widget.assetPath6,
                    mood: widget.mood6,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Дополнительный список для "Радость"
            if (widget.selectedMood == 0)
              SubMoodsList(
                selectedMood: widget.selectedMood,
              ),
            const SizedBox(height: 20),
            // Слайдер для уровня стресса
            SliderWidget(
              text: 'Уровень стресса',
              minText1: 'Низкий',
              minText2: 'Высокий',
              initialValue: widget.stressLevel, // Передаем начальное значение
              onChanged: (double value) {
                setState(() {
                  widget.stressLevel = value; // Обновляем уровень стресса
                });
              },
            ),

            const SizedBox(height: 20),
            // Слайдер для самооценки
            SliderWidget(
              text: 'Самооценка',
              minText1: 'Неуверенность',
              minText2: 'Уверенность',
              initialValue: widget.selfRating, // Передаем начальное значение
              onChanged: (double value) {
                setState(() {
                  widget.selfRating = value; // Обновляем самооценку
                });
              },
            ),
            const SizedBox(height: 20),
            // Поле для заметок
            const Text(
              'Заметки',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: widget.notesController,
              decoration: const InputDecoration(
                hintText: 'Введите заметку',
                hintStyle: TextStyle(
                  color: AppColors.seriy2,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                fillColor: AppColors.white, // Цвет фона с прозрачностью
                filled: true, // Включаем цвет фона
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    borderSide: BorderSide.none),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 30),
            // Кнопка Сохранить
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Логика сохранения
                  widget.onSave(widget.selectedMood.toString());
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.orange,
                ),
                child: const Text(
                  'Сохранить',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SliderWidget extends StatefulWidget {
  const SliderWidget({
    super.key,
    required this.text,
    required this.minText1,
    required this.minText2,
    required this.initialValue,
    required this.onChanged,
  });

  final String text, minText1, minText2;
  final double initialValue;
  final ValueChanged<double> onChanged;

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double currentValue = 0;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.text,
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                FlutterSlider(
                  values: [currentValue],
                  max: 10,
                  min: 0,
                  step: const FlutterSliderStep(step: 1),
                  handler: FlutterSliderHandler(
                    decoration: const BoxDecoration(),
                    child: Material(
                      borderOnForeground: false,
                      type: MaterialType.circle,
                      color: Colors.white,
                      elevation: 3,
                      child: Container(
                        width: 10,
                        height: 10,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                      ),
                    ),
                  ),
                  trackBar: FlutterSliderTrackBar(
                    activeTrackBar: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade300,
                    ),
                    inactiveTrackBar: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade300,
                    ),
                    activeTrackBarHeight: 6,
                    inactiveTrackBarHeight: 6,
                  ),
                  hatchMark: FlutterSliderHatchMark(
                    density: 0.5,
                    labels: [
                      FlutterSliderHatchMarkLabel(
                          percent: 0, label: const Text('')),
                      FlutterSliderHatchMarkLabel(
                          percent: 25, label: const Text('')),
                      FlutterSliderHatchMarkLabel(
                          percent: 50, label: const Text('')),
                      FlutterSliderHatchMarkLabel(
                          percent: 75, label: const Text('')),
                      FlutterSliderHatchMarkLabel(
                          percent: 100, label: const Text('')),
                    ],
                    linesAlignment: FlutterSliderHatchMarkAlignment.left,
                    displayLines: true,
                    bigLine: const FlutterSliderSizedBox(
                      width: 2,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    setState(() {
                      currentValue = lowerValue;
                    });
                    widget.onChanged(currentValue);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.minText1,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        widget.minText2,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MoodOptionWidget extends StatelessWidget {
  const MoodOptionWidget(
      {super.key,
      required this.onTap,
      required this.color,
      required this.assetPath,
      required this.mood});

  final Function() onTap;
  final Color color;
  final String assetPath, mood;
  @override
  Widget build(BuildContext context) {
    // создания эмоций
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 83,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: color,
              ),
              color: AppColors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  assetPath,
                  height: 40,
                ),
                const SizedBox(height: 3),
                Text(
                  mood,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class SubMoodsList extends StatelessWidget {
  SubMoodsList({super.key, required this.selectedMood});
  int selectedMood;
  @override
  Widget build(BuildContext context) {
    List<String> joySubMoods = [
      'Возбуждение',
      'Восторг',
      'Игривость',
      'Наслаждение',
      'Очарование',
      'Осознанность',
      'Смелость',
      'Удовольствие',
      'Чувственность',
      'Энергичность',
      'Экстравагантность',
    ];
    return Wrap(
      spacing: 5.0,
      runSpacing: -8,
      children: joySubMoods.map((subMood) {
        return ChoiceChip(
          backgroundColor: AppColors.white,
          labelStyle: const TextStyle(
            color: AppColors.black,
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
          side: const BorderSide(
            color: AppColors.white,
          ),
          label: Text(subMood),
          selected: selectedMood == subMood,
          // Выбран ли чип (можно добавить логику выделения)
          onSelected: (bool selected) {
            selectedMood = (selected ? subMood : null) as int;
            // Логика при выборе определенного суб-настроения
          },
        );
      }).toList(),
    );
  }
}
