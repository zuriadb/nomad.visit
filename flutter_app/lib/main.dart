import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'providers/plan_provider.dart'; 
import 'providers/draft_plan_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlanProvider()),
        ChangeNotifierProvider(create: (_) => DraftPlanProvider()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nomad Visit',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF6F6F8),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Welcome Page'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/mascot.png',
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 30),
            const Text(
              'Астананы Nomad Visit-пен бірге таны!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(254, 58),
                backgroundColor: const Color(0xFF18583B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
              ),
              child: const Text(
                "Жаңа сапар жоспарлау",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});
  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 206),
            const Text(
              "Тілді таңдаңыз:",
              style: TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 36,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            _buildLanguageButton("Қазақша"),
            const SizedBox(height: 20),
            _buildLanguageButton("Орысша"),
            const SizedBox(height: 20),
            _buildLanguageButton("Ағылшынша"),
            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                if (selectedLanguage != null) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Container(
                          width: 313,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFB0F1FB),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Пайдаланушылар келісімі",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Inter",
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Cіз аналитика үшін деректерді жинауға келісім бересіз бе?\n"
                                "Бұл деректер қызмет сапасын арттыру үшін қолданылады.",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Inter",
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: const Color(0xFFD85C4B),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const BlackScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text("Келіспеу"),
                                  ),
                                  const SizedBox(width: 10),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: const Color(0xFF18583B),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ThirdPage(),
                                        ),
                                      );
                                    },
                                    child: const Text("Келісу"),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(254, 58),
                backgroundColor: const Color(0xFF18583B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
              ),
              child: const Text(
                "Таңдау",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageButton(String language) {
    bool isSelected = selectedLanguage == language;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = language;
        });
      },
      child: Container(
        width: 291,
        height: 60,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFB0F1FB) : const Color(0xFFEBEBEB),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          language,
          style: const TextStyle(
            fontSize: 24,
            fontFamily: "Inter",
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}


// -------------------- ThirdPage --------------------

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  void _showLoginDialog(BuildContext context, String provider) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            '«Nomad Visit» хочет использовать $provider для входа',
            style: const TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          content: const Text(
            'При этом приложению и сайту будет разрешено делиться информацией о Вас.',
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text(
                "Отменить",
                style: TextStyle(color: Colors.red),
              ),
            ),
           TextButton(
  onPressed: () {
    Navigator.of(ctx).pop();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainPage()),
    );
  },
  child: const Text(
    "Продолжить",
    style: TextStyle(color: Colors.blue),
  ),
            ),
          ],
        );
      },
    );
  }

  
  Widget _outlinedLoginButton(
      BuildContext context, String text, String iconPath, String provider) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _showLoginDialog(context, provider),
        icon: Image.asset(
          iconPath,
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
        label: Text(
          text,
          style: const TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: Colors.black, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          minimumSize: const Size(double.infinity, 52),

          alignment: Alignment.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF18583B),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          
          // ignore: unused_local_variable
          final panelWidth = screenWidth >= 420 ? 393.0 : screenWidth * 0.92;

          return Column(
            children: [
              Expanded(
                flex: 4,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        "Қош келдіңіз!",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 28,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Саяхатыңызды бүгін жоспарлаңыз!",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

Expanded(
  flex: 6,
  child: Container(
    width: double.infinity, 
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Кіру:",
            style: TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          _outlinedLoginButton(context, "Apple ID",
              "assets/images/iphoneicon.png", "Apple ID"),
          const SizedBox(height: 12),
          _outlinedLoginButton(context, "Google Account",
              "assets/images/googleicon.png", "Google"),
          const SizedBox(height: 12),
          _outlinedLoginButton(context, "Facebook Account",
              "assets/images/facebookicon.png", "Facebook"),
        ],
      ),
    ),
  ),
),

            ],
          );
        }),
      ),
    );
  }
}



// -------------------- BlackScreen --------------------

class BlackScreen extends StatelessWidget {
  const BlackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: const Center(
        child: Text(
          "Қолдану тоқтатылды",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

// =====================
// ЧЕТВЕРТАЯ СТРАНИЦА
// =====================

class FourthPage extends StatefulWidget {
  const FourthPage({super.key});

  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  int? selectedPerson;
  List<int> selectedPreferences = [];
  int? selectedSeason;

  void togglePreference(int index) {
    setState(() {
      if (selectedPreferences.contains(index)) {
        selectedPreferences.remove(index);
      } else {
        selectedPreferences.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool canContinue =
        selectedPerson != null &&
        selectedPreferences.isNotEmpty &&
        selectedSeason != null;

    return Scaffold(
      body: Stack(
        children: [
          // === Progress Bar ===
          Positioned(
            top: 40,
            left: 30,
            right: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: LinearProgressIndicator(
                value: 0.33,
                minHeight: 10,
                backgroundColor: const Color(0xFFD9D9D9),
                valueColor: const AlwaysStoppedAnimation(Color(0xFF78E9A9)),
              ),
            ),
          ),

          
          const Positioned(
            top: 74,
            left: 81,
            child: SizedBox(
              width: 232,
              child: Text(
                "Саяхат қалауыңыз:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const Positioned(
            top: 109,
            left: 30,
            child: SizedBox(
              width: 333,
              child: Text(
                "ЖИ гидке саяхатыңызды жоспарлауға бағыт берейік",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Color(0xFF737272),
                ),
              ),
            ),
          ),

        
          const Positioned(
            top: 179,
            left: 29,
            child: Text(
              "Кіммен бірге саяхаттағыңыз келеді?",
              style: TextStyle(fontSize: 16),
            ),
          ),
          _buildPersonButton(0, "Жалғыз", Icons.person, 25, 210, 89, Colors.blue),
          _buildPersonButton(1, "Жұбыммен", Icons.people, 128, 209, 113, Colors.red),
          _buildPersonButton(2, "Досыммен", Icons.group, 255, 210, 113, Colors.green),
          _buildPersonButton(3, "Отбасыммен", Icons.family_restroom, 25, 254, 124, Colors.orange),

          const Positioned(
            top: 313,
            left: 25,
            child: Text(
              "Саяхаттау талғамыңыз қандай?",
              style: TextStyle(fontSize: 16),
            ),
          ),
          _buildPreferenceButton(0, "Шытырман", Icons.park, 25, 344, 112, Colors.teal),
          _buildPreferenceButton(1, "Релакс", Icons.spa, 146, 344, 86, Colors.purple),
          _buildPreferenceButton(2, "Мәдени", Icons.museum, 241, 345, 90, Colors.indigo),
          _buildPreferenceButton(3, "Кеш", Icons.nightlife, 25, 378, 69, Colors.pink),
          _buildPreferenceButton(4, "Эко", Icons.eco, 103, 378, 62, Colors.green),
          _buildPreferenceButton(5, "Люкс", Icons.diamond, 173, 378, 76, Colors.amber),
          _buildPreferenceButton(6, "Романтикалық", Icons.favorite, 25, 412, 140, Colors.redAccent),
          _buildPreferenceButton(7, "Тамақтану", Icons.restaurant, 173, 412, 110, Colors.brown),
          _buildPreferenceButton(8, "Демалу", Icons.self_improvement, 25, 446, 100, Colors.deepOrange),

          const Positioned(
            top: 499,
            left: 32,
            child: Text(
              "Қай мезгілде саяхаттағыңыз келеді?",
              style: TextStyle(fontSize: 16),
            ),
          ),
          _buildSeasonButton(0, "Көктем", Icons.local_florist, 25, 535, 83, Colors.green),
          _buildSeasonButton(1, "Жаз", Icons.wb_sunny, 117, 535, 68, Colors.yellow),
          _buildSeasonButton(2, "Күз", Icons.park, 194, 535, 62, Colors.orange),
          _buildSeasonButton(3, "Қыс", Icons.ac_unit, 265, 535, 67, Colors.blueAccent),

          // === Кнопка "Жалғастыру" ===
          Positioned(
            top: 714,
            left: 26,
            child: GestureDetector(
              onTap: canContinue
                  ? () {
                      final planData = {
                        "title": "Жаңа жоспар",
                        "subtitle": "Таңдалған қалаулар",
                        "person": selectedPerson,
                        "preferences": selectedPreferences,
                        "season": selectedSeason,
                      };

                      
                      Provider.of<DraftPlanProvider>(context, listen: false).merge(planData);

                    
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FifthPage(),
                        ),
                      );
                    }
                  : null,
              child: Container(
                width: 331,
                height: 54,
                decoration: BoxDecoration(
                  color: canContinue ? const Color(0xFF78E9A9) : Colors.grey,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: const Center(
                  child: Text(
                    "Жалғастыру",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ====== КНОПКИ ======
  Widget _buildPersonButton(int index, String text, IconData icon, double left,
      double top, double width, Color iconColor) {
    final bool isSelected = selectedPerson == index;
    return Positioned(
      top: top,
      left: left,
      child: GestureDetector(
        onTap: () => setState(() => selectedPerson = index),
        child: Container(
          width: width,
          height: 32,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFD6F5E7) : const Color(0xFFE6E5E5),
            borderRadius: BorderRadius.circular(20),
            border: isSelected ? Border.all(color: const Color(0xFF18583B)) : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: iconColor),
              const SizedBox(width: 4),
              Text(text, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreferenceButton(int index, String text, IconData icon, double left,
      double top, double width, Color iconColor) {
    final bool isSelected = selectedPreferences.contains(index);
    return Positioned(
      top: top,
      left: left,
      child: GestureDetector(
        onTap: () => togglePreference(index),
        child: Container(
          width: width,
          height: 26,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFD6F5E7) : const Color(0xFFE6E5E5),
            borderRadius: BorderRadius.circular(15),
            border: isSelected ? Border.all(color: const Color(0xFF18583B)) : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: iconColor),
              const SizedBox(width: 4),
              Text(text, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSeasonButton(int index, String text, IconData icon, double left,
      double top, double width, Color iconColor) {
    final bool isSelected = selectedSeason == index;
    return Positioned(
      top: top,
      left: left,
      child: GestureDetector(
        onTap: () => setState(() => selectedSeason = index),
        child: Container(
          width: width,
          height: 26,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFD6F5E7) : const Color(0xFFE6E5E5),
            borderRadius: BorderRadius.circular(15),
            border: isSelected ? Border.all(color: const Color(0xFF18583B)) : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: iconColor),
              const SizedBox(width: 4),
              Text(text, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}




// =====================
// ПЯТАЯ СТРАНИЦА
// =====================

class FifthPage extends StatefulWidget {

  final Function(Map<String, dynamic>)? onCuisineSaved;

  const FifthPage({super.key, this.onCuisineSaved});

  @override
  State<FifthPage> createState() => _FifthPageState();
}

class _FifthPageState extends State<FifthPage> {
  List<int> selectedCuisines = [];
  List<int> selectedDrinks = [];

  void toggleCuisine(int index) {
    setState(() {
      if (selectedCuisines.contains(index)) {
        selectedCuisines.remove(index);
      } else {
        selectedCuisines.add(index);
      }
    });
  }

  void toggleDrink(int index) {
    setState(() {
      if (selectedDrinks.contains(index)) {
        selectedDrinks.remove(index);
      } else {
        selectedDrinks.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool canContinue =
        selectedCuisines.isNotEmpty && selectedDrinks.isNotEmpty;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: LinearProgressIndicator(
                  value: 0.66,
                  minHeight: 10,
                  backgroundColor: const Color(0xFFD9D9D9),
                  valueColor: const AlwaysStoppedAnimation(Color(0xFF78E9A9)),
                ),
              ),
              const SizedBox(height: 30),

              // Заголовок
              const Text(
                "Саяхат қалауыңыз",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),

              // Подзаголовок
              const Text(
                "ЖИ гидке саяхатыңызды жоспарлауға бағыт берейік",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Color(0xFF737272),
                ),
              ),
              const SizedBox(height: 30),

              // Вопрос про кухню
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Сізге қай елдің тағамы ұнайды?",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Кнопки выбора кухонь
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildCuisineButton(0, "Қазақ", "kazakh"),
                  _buildCuisineButton(1, "Италиян", "italian"),
                  _buildCuisineButton(2, "Жапон", "japan"),
                  _buildCuisineButton(3, "Ресей", "russian"),
                  _buildCuisineButton(4, "Түрік", "turkish"),
                  _buildCuisineButton(5, "Қытай", "chinese"),
                  _buildCuisineButton(6, "Кәріс", "korean"),
                  _buildCuisineButton(7, "Үнді", "indian"),
                  _buildCuisineButton(8, "Грузин", "gruzinskaya"),
                  _buildCuisineButton(9, "Француз", "french"),
                  _buildCuisineButton(10, "Мексикан", "mexican"),
                  _buildCuisineButton(11, "Американ", "american"),
                ],
              ),
              const SizedBox(height: 40),

              // Вопрос про напитки
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Сіздің сусындағы талғамыңыз қандай?",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Кнопки выбора напитков
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _buildDrinkButton(0, "Кофе", "coffee"),
                      _buildDrinkButton(1, "Шәй", "tea"),
                      _buildDrinkButton(2, "Вино", "wine"),
                      _buildDrinkButton(3, "Сыра", "beer"),
                      _buildDrinkButton(4, "Смузи", "smoothie"),
                      _buildDrinkButton(5, "Коктейль", "cocktail"),
                      _buildDrinkButton(6, "Газдалған сусын", "soda"),
                      _buildDrinkButton(7, "Шырын", "juice"),
                      _buildDrinkButton(8, "Виски", "whiskey"),
                      _buildDrinkButton(9, "Шампан", "champagne"),
                      _buildDrinkButton(10, "Милкшейк", "milkshake"),
                      _buildDrinkButton(11, "Қымыз", "kymyz"),
                      _buildDrinkButton(12, "Бабл-ти", "bubbletea"),
                      _buildDrinkButton(13, "Шұбат", "shubat"),
                      _buildDrinkButton(14, "Су", "water"),
                    ],
                  ),
                ),
              ),

              // Кнопка "Жалғастыру"
              GestureDetector(
                onTap: canContinue
                    ? () {
                        final cuisineData = {
                          "cuisines": selectedCuisines,
                          "drinks": selectedDrinks,
                        };

                        
                        Provider.of<DraftPlanProvider>(context, listen: false)
                            .merge(cuisineData);

                        
                        if (widget.onCuisineSaved != null) {
                          widget.onCuisineSaved!(cuisineData);
                        }

                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SixthPage(),
                          ),
                        );
                      }
                    : null,
                child: Container(
                  height: 54,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: canContinue
                        ? const Color(0xFF78E9A9)
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: const Center(
                    child: Text(
                      "Жалғастыру",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Кнопка кухни
  Widget _buildCuisineButton(int index, String text, String iconName) {
    final bool isSelected = selectedCuisines.contains(index);
    return GestureDetector(
      onTap: () => toggleCuisine(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 32,
        decoration: BoxDecoration(
          color:
              isSelected ? const Color(0xFFD6F5E7) : const Color(0xFFE6E5E5),
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? Border.all(color: const Color(0xFF18583B)) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/$iconName.png", width: 18, height: 18),
            const SizedBox(width: 4),
            Text(
              text,
              style: const TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Кнопка напитка
  Widget _buildDrinkButton(int index, String text, String iconName) {
    final bool isSelected = selectedDrinks.contains(index);
    return GestureDetector(
      onTap: () => toggleDrink(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 32,
        decoration: BoxDecoration(
          color:
              isSelected ? const Color(0xFFD6F5E7) : const Color(0xFFE6E5E5),
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? Border.all(color: const Color(0xFF18583B)) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/$iconName.png", width: 18, height: 18),
            const SizedBox(width: 4),
            Text(
              text,
              style: const TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// =====================
// ШЕСТАЯ СТРАНИЦА
// =====================
class SixthPage extends StatefulWidget {
  const SixthPage({super.key});

  @override
  State<SixthPage> createState() => _SixthPageState();
}

class _SixthPageState extends State<SixthPage> {
  List<int> selectedActivities = [];
  List<int> selectedAccommodations = [];

  void toggleActivity(int index) {
    setState(() {
      if (selectedActivities.contains(index)) {
        selectedActivities.remove(index);
      } else {
        selectedActivities.add(index);
      }
    });
  }

  void toggleAccommodation(int index) {
    setState(() {
      if (selectedAccommodations.contains(index)) {
        selectedAccommodations.remove(index);
      } else {
        selectedAccommodations.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool canContinue =
        selectedActivities.isNotEmpty && selectedAccommodations.isNotEmpty;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Прогресс бар
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: LinearProgressIndicator(
                  value: 0.83,
                  minHeight: 10,
                  backgroundColor: const Color(0xFFD9D9D9),
                  valueColor: const AlwaysStoppedAnimation(Color(0xFF78E9A9)),
                ),
              ),
              const SizedBox(height: 30),

              const Text(
                "Саяхат қалауыңыз",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),

              const Text(
                "ЖИ гидке саяхатыңызды жоспарлауға бағыт берейік",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Color(0xFF737272),
                ),
              ),
              const SizedBox(height: 25),

              // Вопрос 1
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Уақытты қалай өткізгіңіз келеді?",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              const SizedBox(height: 15),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildActivityButton(0, "Жағажай", "beach"),
                  _buildActivityButton(1, "Қала", "city"),
                  _buildActivityButton(2, "Қаланың сырты", "countryside"),
                  _buildActivityButton(3, "Көл", "lake"),
                  _buildActivityButton(4, "Тарихи жерлер", "historical"),
                  _buildActivityButton(5, "Өзен", "river"),
                  _buildActivityButton(6, "Cаябақ", "garden"),
                  _buildActivityButton(7, "Демалыс базасы", "recreation"),
                  _buildActivityButton(8, "SPA", "spa"),
                  _buildActivityButton(9, "Шатқал", "gorge"),
                  _buildActivityButton(10, "Шоппинг", "shopping"),
                  _buildActivityButton(11, "Спорт", "sport"),
                  _buildActivityButton(12, "Театр", "theatre"),
                  _buildActivityButton(13, "Қыдыру", "walking"),
                  _buildActivityButton(14, "Мұражай", "museum"),
                  _buildActivityButton(15, "Ресторан", "cooking"),
                  _buildActivityButton(16, "Концерт", "concert"),
                  _buildActivityButton(17, "Йога", "yoga"),
                  _buildActivityButton(18, "Діни", "religion"),
                  _buildActivityButton(19, "Скайдайвинг", "skydiving"),
                  _buildActivityButton(20, "Балық аулау", "fishing"),
                  _buildActivityButton(21, "Дайвинг", "diving"),
                  _buildActivityButton(22, "Аквапарк", "aquapark"),
                  _buildActivityButton(23, "Ойын-сауық алаңы", "entertainmentarea"),
                ],
              ),
              const SizedBox(height: 25),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Қайда тұрақтауды қалайсыз?",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              const SizedBox(height: 15),

              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _buildAccommodationButton(0, "Қонақүй", "hotel"),
                      _buildAccommodationButton(1, "Курорт", "resort"),
                      _buildAccommodationButton(2, "Жерүй", "cottage"),
                      _buildAccommodationButton(3, "Кемпинг", "camping"),
                      _buildAccommodationButton(4, "Хостел", "hostel"),
                      _buildAccommodationButton(5, "Вилла", "villa"),
                      _buildAccommodationButton(6, "Пәтер", "flat"),
                      _buildAccommodationButton(7, "Глэмпинг", "glamping"),
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: canContinue
                    ? () {
                        final activityData = {
                          "activities": selectedActivities,
                          "accommodations": selectedAccommodations,
                        };

                        // сохраняем в черновик (DraftPlanProvider)
                        Provider.of<DraftPlanProvider>(context, listen: false)
                            .merge(activityData);

                        // Переход на 7-ю страницу
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Page7(),
                          ),
                        );
                      }
                    : null,
                child: Container(
                  height: 54,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    color: canContinue ? const Color(0xFF78E9A9) : Colors.grey,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: const Center(
                    child: Text(
                      "Жалғастыру",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityButton(int index, String text, String iconName) {
    final bool isSelected = selectedActivities.contains(index);
    return GestureDetector(
      onTap: () => toggleActivity(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 32,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFD6F5E7) : const Color(0xFFE6E5E5),
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? Border.all(color: const Color(0xFF18583B)) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/$iconName.png", width: 18, height: 18),
            const SizedBox(width: 4),
            Text(text, style: const TextStyle(fontSize: 13, color: Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget _buildAccommodationButton(int index, String text, String iconName) {
    final bool isSelected = selectedAccommodations.contains(index);
    return GestureDetector(
      onTap: () => toggleAccommodation(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 32,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFD6F5E7) : const Color(0xFFE6E5E5),
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? Border.all(color: const Color(0xFF18583B)) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/$iconName.png", width: 18, height: 18),
            const SizedBox(width: 4),
            Text(text, style: const TextStyle(fontSize: 13, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}



// =====================
// СЕДЬМАЯ СТРАНИЦА
// =====================

class Page7 extends StatefulWidget {
  const Page7({super.key});

  @override
  State<Page7> createState() => _Page7State();
}

class _Page7State extends State<Page7> {
  String? selectedTransport;
  double budgetSlider = 0;
  DateTime? rangeStart;
  DateTime? rangeEnd;
  DateTime focusedDay = DateTime.now();

  final transports = const [
    {'icon': Icons.flight, 'label': 'Ұшақ'},
    {'icon': Icons.train, 'label': 'Пойыз'},
    {'icon': Icons.pedal_bike, 'label': 'Велосипед'},
    {'icon': Icons.directions_car, 'label': 'Көлік'},
    {'icon': Icons.directions_bus, 'label': 'Автобус'},
    {'icon': Icons.motorcycle, 'label': 'Мотоцикл'},
    {'icon': Icons.flight_takeoff, 'label': 'Тікұшақ'},
    {'icon': Icons.directions_transit, 'label': 'Минивэн'},
    {'icon': Icons.electric_scooter, 'label': 'Самокат'},
    {'icon': Icons.kayaking, 'label': 'Каяк'},
  ];

  int get budgetValue {
    if (budgetSlider == 100) return 1000000;
    return (budgetSlider * 1000).toInt();
  }

  bool get canContinue =>
      selectedTransport != null && rangeStart != null && rangeEnd != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Прогресс-бар
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: LinearProgressIndicator(
                  value: 1.0,
                  minHeight: 10,
                  backgroundColor: const Color(0xFFD9D9D9),
                  valueColor:
                      const AlwaysStoppedAnimation(Color(0xFF78E9A9)),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Вопрос 1
                    const Text(
                      "Немен саяхаттағыңыз келеді?",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: transports.map((t) {
                        final isSelected = selectedTransport == t['label'];
                        return ChoiceChip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(t['icon'] as IconData, size: 20),
                              const SizedBox(width: 5),
                              Text(t['label'] as String),
                            ],
                          ),
                          selected: isSelected,
                          selectedColor: const Color(0xFF78E9A9),
                          onSelected: (_) {
                            setState(() {
                              selectedTransport = t['label'] as String;
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 30),

                    // Вопрос 2
                    const Text(
                      "Қанша қаражат жұмсауды жоспарлайсыз?",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Slider(
                      value: budgetSlider,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      activeColor: const Color(0xFF18583B),
                      onChanged: (value) {
                        setState(() {
                          budgetSlider = value;
                        });
                      },
                    ),
                    Text(
                      budgetSlider == 100
                          ? "1 000 000+ ₸"
                          : "$budgetValue ₸",
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Вопрос 3
                    const Text(
                      "Саяхатыңыз қанша күнге созылады?",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFF18583B), width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TableCalendar(
                        focusedDay: focusedDay,
                        firstDay: DateTime.utc(2020, 1, 1),
                        lastDay: DateTime.utc(2030, 12, 31),
                        calendarFormat: CalendarFormat.month,
                        availableCalendarFormats: const {
                          CalendarFormat.month: 'Ай',
                        },
                        rangeSelectionMode: RangeSelectionMode.toggledOn,
                        rangeStartDay: rangeStart,
                        rangeEndDay: rangeEnd,
                        onRangeSelected: (start, end, focused) {
                          setState(() {
                            rangeStart = start;
                            rangeEnd = end;
                            focusedDay = focused;
                          });
                        },
                        calendarStyle: const CalendarStyle(
                          rangeHighlightColor: Color(0xFFCFFFE4),
                          selectedDecoration: BoxDecoration(
                            color: Color(0xFF78E9A9),
                            shape: BoxShape.circle,
                          ),
                          todayDecoration: BoxDecoration(
                            color: Color(0xFF18583B),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Кнопка "Жалғастыру"
            GestureDetector(
              onTap: canContinue
                  ? () {
                      // сохраняем в DraftPlanProvider
                      Provider.of<DraftPlanProvider>(context, listen: false)
                          .merge({
                        'transport': selectedTransport,
                        'budget': budgetValue,
                        'startDate': rangeStart,
                        'endDate': rangeEnd,
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoadingPage(),
                        ),
                      );
                    }
                  : null,
              child: Container(
                height: 54,
                width: double.infinity,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: canContinue
                      ? const Color(0xFF78E9A9)
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: const Center(
                  child: Text(
                    "Жалғастыру",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.black,
                    ),
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




// =====================
// LOADING PAGE
// =====================
class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
  // ignore: use_build_context_synchronously
  context,
  MaterialPageRoute(
    builder: (context) => const EighthPage(),
  ),
);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFFBF4),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Маскот
            SizedBox(
              width: 150,
              child: Image.asset("assets/images/mascot.png"),
            ),
            const SizedBox(height: 30),

            // Текст
            const Text(
              "Жеке жоспарыңыз жасалуда...",
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),

            // Индикатор загрузки
            const CircularProgressIndicator(
              color: Color(0xFF18583B),
            ),
          ],
        ),
      ),
    );
  }
}



// ======================================
// Главная страница с BottomNavigationBar
// ======================================
class MainPage extends StatefulWidget {
  final int initialIndex;
  const MainPage({super.key, this.initialIndex = 0});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _selectedIndex;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;

    _pages.addAll([
      const HomePage(),
      const SocialPage(),
      const ChatPage(),
      const PlanPage(), 
      const ProfilePage(),
    ]);
  }

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF18583B),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: "Social"),
          BottomNavigationBarItem(icon: Icon(Icons.smart_toy), label: "Baursak"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Plan"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}


// ========================
// PlanPage
// ========================
class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final planProvider = context.watch<PlanProvider>();
    final plans = planProvider.plans;

    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (c) => const FourthPage()),
                    );
                  },
                  child: Container(
                    width: 41,
                    height: 41,
                    decoration: BoxDecoration(
                      color: const Color(0xFF18583B),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.add, color: Color(0xFFC2FFDC)),
                  ),
                ),

                // Favorites
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesPage()));
                  },
                  child: Container(
                    width: 41,
                    height: 41,
                    decoration: BoxDecoration(color: const Color(0xFF18583B), borderRadius: BorderRadius.circular(20)),
                    child: const Icon(Icons.favorite, color: Color(0xFFC2FFDC)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          if (plans.isEmpty)
            const Center(child: Padding(padding: EdgeInsets.all(20), child: Text("Пока планов нет 😔")))
          else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: List.generate(plans.length, (index) {
                  final plan = plans[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.asset(plan["coverImage"] ?? "assets/images/astana.jpg", height: 180, width: double.infinity, fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(plan["title"] ?? "План путешествия", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Text(plan["subtitle"] ?? plan["description"] ?? "Даты и категории будут здесь"),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF18583B)),
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (_) => PlanDetailPage(planData: plan)));
                                      },
                                      child: const Text(
                                      "Толығырақ қарау",
                                        style: TextStyle(color: Colors.white),
                                      ),

                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: const Text("Удалить план?"),
                                          content: const Text("Вы уверены, что хотите удалить этот план?"),
                                          actions: [
                                            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Отмена")),
                                            TextButton(
                                              onPressed: () {
                                                Provider.of<PlanProvider>(context, listen: false).deletePlan(index);
                                                Navigator.pop(ctx);
                                              },
                                              child: const Text("Удалить", style: TextStyle(color: Colors.red)),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}


// ========================
// EighthPage
// ========================

class EighthPage extends StatefulWidget {
  const EighthPage({super.key});

  @override
  State<EighthPage> createState() => _EighthPageState();
}

class _EighthPageState extends State<EighthPage> {
  int selectedDayIndex = 0;

  final List<String> days = ["22 қыркүйек", "23 қыркүйек", "24 қыркүйек"];

  final Map<String, List<Map<String, String>>> plan = {
    "22 қыркүйек": [
      {"time": "09:00", "activity": "Прибытие в аэропорт", "image": "assets/images/airport.jpg"},
      {"time": "09:30", "activity": "Трансфер в Radisson Hotel Astana", "image": "assets/images/hotel.jpg"},
      {"time": "10:00", "activity": "Заселение и отдых", "image": "assets/images/room.jpg"},
      {"time": "12:00", "activity": "Завтрак в ресторане отеля", "image": "assets/images/breakfast.jpg"},
      {"time": "13:00", "activity": "Прогулка по набережной реки Ишим", "image": "assets/images/river.jpg"},
      {"time": "14:30", "activity": "Посещение Байтерек", "image": "assets/images/bayterek.jpg"},
      {"time": "16:00", "activity": "Обед в ресторане Kishlak", "image": "assets/images/lunch.jpg"},
      {"time": "18:00", "activity": "Посещение Astana Opera", "image": "assets/images/opera.jpg"},
      {"time": "20:30", "activity": "Ужин в ресторане Tary", "image": "assets/images/dinner.jpg"},
      {"time": "22:00", "activity": "Возвращение в отель и отдых", "image": "assets/images/night.jpg"},
    ],
    "23 қыркүйек": [
      {"time": "09:00", "activity": "Завтрак в отеле", "image": "assets/images/breakfast.jpg"},
      {"time": "10:00", "activity": "Посещение Мечети Хазрет Султан", "image": "assets/images/mosque.jpg"},
      {"time": "11:30", "activity": "Прогулка по Площади Республики", "image": "assets/images/square.jpg"},
      {"time": "13:00", "activity": "Обед в ресторане Sandyq", "image": "assets/images/sandyq.jpg"},
      {"time": "14:30", "activity": "Шоппинг в Khan Shatyr", "image": "assets/images/shopping.jpg"},
      {"time": "17:00", "activity": "Посещение Национального музея Казахстана", "image": "assets/images/museum.jpg"},
      {"time": "19:00", "activity": "Прогулка по Нуржол Бульвару", "image": "assets/images/boulevard.jpg"},
      {"time": "20:30", "activity": "Ужин в ресторане MÉTIS", "image": "assets/images/metis.jpg"},
      {"time": "22:00", "activity": "Возвращение в отель и отдых", "image": "assets/images/night.jpg"},
    ],
    "24 қыркүйек": [
      {"time": "09:00", "activity": "Завтрак в отеле", "image": "assets/images/breakfast.jpg"},
      {"time": "10:00", "activity": "Прогулка по Botanical Garden", "image": "assets/images/garden.jpg"},
      {"time": "12:00", "activity": "Шоппинг в Mega Silk Way", "image": "assets/images/shopping2.jpg"},
      {"time": "14:00", "activity": "Обед в ресторане Line Brew", "image": "assets/images/linebrew.jpg"},
      {"time": "16:00", "activity": "Трансфер в аэропорт", "image": "assets/images/airport.jpg"},
      {"time": "18:00", "activity": "Вылет из Нур-Султана", "image": "assets/images/plane.jpg"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final currentDay = days[selectedDayIndex];
    final draft = Provider.of<DraftPlanProvider>(context).draft;

    return Scaffold(
      appBar: AppBar(title: const Text("Сіздің жоспарыңыз")),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: days.length,
              itemBuilder: (context, index) {
                final day = days[index];
                final isSelected = index == selectedDayIndex;
                return GestureDetector(
                  onTap: () => setState(() => selectedDayIndex = index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF78E9A9) : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(child: Text(day, style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: FontWeight.bold))),
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: plan[currentDay]?.length ?? 0,
              itemBuilder: (context, index) {
                final activity = plan[currentDay]![index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                        child: Image.asset(activity["image"]!, width: 100, height: 100, fit: BoxFit.cover),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(activity["time"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(activity["activity"]!),
                          ]),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF18583B), minimumSize: const Size(double.infinity, 50)),
          onPressed: () {
            // Окончательный план
            final finalPlan = <String, dynamic>{
              "title": draft["title"] ?? "Романтикалық демалыс Астанада",
              "subtitle": draft["subtitle"] ?? "3 күн • Романтика • Пара",
              "planDetails": plan,
              "coverImage": draft["coverImage"] ?? "assets/images/astana.jpg",
              
              ...draft,
            };

            
            Provider.of<PlanProvider>(context, listen: false).addPlan(finalPlan);

           
            Provider.of<DraftPlanProvider>(context, listen: false).clear();

            
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainPage(initialIndex: 3)),
              (route) => false,
            );
          },
          child: const Text(
  "Сақтау",
  style: TextStyle(
    color: Colors.white,
  ),
),

        ),
      ),
    );
  }
}


// ========================
// PlanDetailPage
// ========================

class PlanDetailPage extends StatefulWidget {
  final Map<String, dynamic> planData;
  const PlanDetailPage({super.key, required this.planData});

  @override
  State<PlanDetailPage> createState() => _PlanDetailPageState();
}

class _PlanDetailPageState extends State<PlanDetailPage> {
  int selectedDayIndex = 0;

  @override
  Widget build(BuildContext context) {
    final planDetails = widget.planData["planDetails"] as Map<String, dynamic>?;

    if (planDetails == null) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.planData["title"] ?? "Детали плана")),
        body: Center(child: Text(widget.planData["subtitle"] ?? "Нет деталей")),
      );
    }

    final days = planDetails.keys.toList();
    final selectedDay = days[selectedDayIndex];
    final activities = List<Map<String, dynamic>>.from(planDetails[selectedDay] ?? []);

    return Scaffold(
      appBar: AppBar(title: Text(widget.planData["title"] ?? "Детали плана")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(widget.planData["subtitle"] ?? "", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: days.length,
              itemBuilder: (context, i) {
                final day = days[i];
                final isSelected = i == selectedDayIndex;
                return GestureDetector(
                  onTap: () => setState(() => selectedDayIndex = i),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(color: isSelected ? const Color(0xFF78E9A9) : Colors.grey[200], borderRadius: BorderRadius.circular(20)),
                    child: Center(child: Text(day, style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: FontWeight.bold))),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: activities.length,
              itemBuilder: (context, idx) {
                final a = activities[idx];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    children: [
                      if (a["image"] != null)
                        ClipRRect(
                          borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                          child: Image.asset(a["image"], width: 100, height: 100, fit: BoxFit.cover),
                        ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(a["time"] ?? "", style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(a["activity"] ?? ""),
                          ]),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


// ========================
// FavoritesPage
// ========================
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Избранное")),
      body: const Center(
        child: Text(
          "Пока избранного нет 💚",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}


// ========================
// HomePage
// ========================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Guiden AI",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Сәлем! 🌍",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            "Сіздің саяхат идеяларыңызға шабыт берейік!",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),

          // Карточка рекомендации
          _buildCard(
            "Ұсынылған бағыт",
            "Алматы → Бурабай",
            Icons.place,
            Colors.green,
          ),
          _buildCard(
            "Ұсынылған тур",
            "Каспий жағалауына 3 күн",
            Icons.beach_access,
            Colors.blue,
          ),
          _buildCard(
            "Ұсынылған іс-шара",
            "Наурыз мерекесі",
            Icons.celebration,
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String subtitle, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}

// ========================
// SocialPage
// ========================

class SocialPage extends StatelessWidget {
  const SocialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Қоғамдастық",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildPost(
            "Аружан",
            "Бурабайға саяхаттап қайттым 🌲🏞️ керемет жер екен!",
            "assets/images/burabay.jpg",
          ),
          _buildPost(
            "Айбек",
            "Алматыдағы Medeu мұз айдынына бардым, супер тәжірибе ⛸️",
            "assets/images/medeu.jpg",
          ),
        ],
      ),
    );
  }

  Widget _buildPost(String name, String text, String imagePath) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(child: Text(name[0])),
            title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: const Text("2 сағат бұрын"),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(text),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
// ========================
// ChatPage
// ========================

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, dynamic>> messages = [
    {"isUser": false, "text": "Сәлем! Қайда барғыңыз келеді?"},
  ];

  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      messages.add({"isUser": true, "text": _controller.text.trim()});
      messages.add({"isUser": false, "text": "Жақсы таңдау! 🌍"}); 
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "AI Чат",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return Align(
                  alignment:
                      msg["isUser"] ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: msg["isUser"]
                          ? const Color(0xFF78E9A9)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg["text"]),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Хабарлама жазыңыз...",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF18583B)),
                  onPressed: _sendMessage,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ========================
// ProfilePage
// ========================
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Профиль"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/avatar.png"), 
            ),
            const SizedBox(height: 16),
            const Text(
              "Имя пользователя",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "email@example.com",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Настройки"),
              onTap: () {
                // TODO: переход в настройки
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text("История планов"),
              onTap: () {
                // TODO: можно показать прошлые планы
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Выйти"),
              onTap: () {
                // TODO: обработать выход
              },
            ),
          ],
        ),
      ),
    );
  }
}
