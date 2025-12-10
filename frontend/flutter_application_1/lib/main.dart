import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'providers/plan_provider.dart'; 
import 'providers/draft_plan_provider.dart';
import 'map_recommendations_page.dart';
import 'services/auth_service.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('kk'),
        Locale('ru'),
        Locale('en'),
      ],
      path: 'assets/translations', // путь к папке с json файлами
      fallbackLocale: const Locale('kk'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => PlanProvider()),
          ChangeNotifierProvider(create: (_) => DraftPlanProvider()),
        ],
        child: const MyApp(),
      ),
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
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const MyHomePage(title: 'Welcome Page'),
      routes: {
      '/main': (context) => const MainPage(), // <-- сюда добавь свой главный экран
      '/login': (context) => const LoginPage(),
      '/register': (context) => const RegisterPage(),
  },
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
            Column(
  children: const [
    Text(
      'Астананы Nomad Visit-пен бірге таны!',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    ),
    SizedBox(height: 8),
    Text(
      'Discover Astana with Nomad Visit!',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    ),
    SizedBox(height: 8),
    Text(
      'Познай Астану вместе с Nomad Visit!',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    ),
  ],
)
,
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

// =====================
// ВТОРАЯ СТРАНИЦА
// =====================

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
            Text(
              tr('choose_language'),
              style: const TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 36,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            // Кнопки выбора языка оставляем как есть
            _buildLanguageButton("Қазақша", const Locale('kk')),
            const SizedBox(height: 20),
            _buildLanguageButton("Орысша", const Locale('ru')),
            const SizedBox(height: 20),
            _buildLanguageButton("Ағылшынша", const Locale('en')),
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
                              Text(
                                tr('agreement.title'),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Inter",
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                tr('agreement.text'),
                                style: const TextStyle(
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
                                                 BlackScreen()),
                                      );
                                    },
                                    child: Text(tr('buttons.disagree')),
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
                                                const ThirdPage()),
                                      );
                                    },
                                    child: Text(tr('buttons.agree')),
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
              child: Text(
                tr('buttons.select'),
                style: const TextStyle(
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

  Widget _buildLanguageButton(String language, Locale locale) {
    bool isSelected = selectedLanguage == language;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = language;
          context.setLocale(locale);
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
          language, // оставляем название языка без перевода
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

  void _showLoginDialog(BuildContext context, String providerKey, String providerLabelKey) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            tr('dialog.title', namedArgs: {'provider': tr(providerLabelKey)}),
            style: const TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          content: Text(
            tr('dialog.content'),
            style: const TextStyle(
              fontFamily: "Inter",
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(
                tr('buttons.cancel'),
                style: const TextStyle(color: Colors.red),
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
              child: Text(
                tr('buttons.continue'),
                style: const TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _outlinedLoginButton(
      BuildContext context, String textKey, String iconPath, String providerLabelKey) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _showLoginDialog(context, providerLabelKey, providerLabelKey),
        icon: Image.asset(
          iconPath,
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
        label: Text(
          tr(textKey),
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
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tr("welcome.title"),
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      tr("welcome.subtitle"),
                      style: const TextStyle(
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr("login.title"),
                          style: const TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Кнопка входа через Email
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => LoginPage()),
                              );
                            },
                            icon: const Icon(Icons.email, size: 24),
                            label: const Text(
                              'Войти через Email',
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF78E9A9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              minimumSize: const Size(double.infinity, 52),
                              elevation: 0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Разделитель
                        Row(
                          children: [
                            Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'или',
                                style: TextStyle(color: Colors.grey[600], fontSize: 14),
                              ),
                            ),
                            Expanded(child: Divider(color: Colors.grey[300], thickness: 1)),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Социальные входы
                        _outlinedLoginButton(context, "login.apple", "assets/images/iphoneicon.png", "providers.apple"),
                        const SizedBox(height: 12),
                        _outlinedLoginButton(context, "login.google", "assets/images/googleicon.png", "providers.google"),
                        const SizedBox(height: 12),
                        _outlinedLoginButton(context, "login.facebook", "assets/images/facebookicon.png", "providers.facebook"),
                        const SizedBox(height: 20),

                        // Регистрация
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Нет аккаунта? ',
                              style: TextStyle(color: Colors.black54),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => RegisterPage()),
                                );
                              },
                              child: const Text(
                                'Зарегистрироваться',
                                style: TextStyle(
                                  color: Color(0xFF18583B),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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

class BlackScreen extends StatelessWidget {
  const BlackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          tr("stopped"),
          style: const TextStyle(color: Colors.white, fontSize: 20),
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

  final List<IconData> preferenceIcons = [
    Icons.park,
    Icons.spa,
    Icons.museum,
    Icons.nightlife,
    Icons.eco,
    Icons.diamond,
    Icons.favorite,
    Icons.restaurant,
    Icons.self_improvement,
  ];

  final List<Color> preferenceColors = [
    Colors.teal,
    Colors.purple,
    Colors.indigo,
    Colors.pink,
    Colors.green,
    Colors.amber,
    Colors.redAccent,
    Colors.brown,
    Colors.deepOrange,
  ];

  @override
  Widget build(BuildContext context) {
    final bool canContinue =
        selectedPerson != null &&
        selectedPreferences.isNotEmpty &&
        selectedSeason != null;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Progress bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: LinearProgressIndicator(
                  value: 0.33,
                  minHeight: 10,
                  backgroundColor: const Color(0xFFD9D9D9),
                  valueColor:
                      const AlwaysStoppedAnimation(Color(0xFF78E9A9)),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Заголовки
                    Text(
                      tr("travel.title"),
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tr("travel.subtitle"),
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Color(0xFF737272),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Person
                    Text(
                      tr("travel.person.title"),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _buildChoiceButton(
                            0, selectedPerson == 0, tr("travel.person.alone"), Icons.person, Colors.blue,
                            onTap: () => setState(() => selectedPerson = 0)),
                        _buildChoiceButton(
                            1, selectedPerson == 1, tr("travel.person.couple"), Icons.people, Colors.red,
                            onTap: () => setState(() => selectedPerson = 1)),
                        _buildChoiceButton(
                            2, selectedPerson == 2, tr("travel.person.friend"), Icons.group, Colors.green,
                            onTap: () => setState(() => selectedPerson = 2)),
                        _buildChoiceButton(
                            3, selectedPerson == 3, tr("travel.person.family"), Icons.family_restroom, Colors.orange,
                            onTap: () => setState(() => selectedPerson = 3)),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Preferences
                    Text(
                      tr("travel.preferences.title"),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(preferenceIcons.length, (index) {
                        return _buildChoiceButton(
                          index,
                          selectedPreferences.contains(index),
                          tr("travel.preferences.${[
                            "adventure",
                            "relax",
                            "cultural",
                            "night",
                            "eco",
                            "lux",
                            "romantic",
                            "food",
                            "rest"
                          ][index]}"),
                          preferenceIcons[index],
                          preferenceColors[index],
                          onTap: () => togglePreference(index),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),

                    // Seasons
                    Text(
                      tr("travel.season.title"),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _buildChoiceButton(
                            0,
                            selectedSeason == 0,
                            tr("travel.season.spring"),
                            Icons.local_florist,
                            Colors.green,
                            onTap: () => setState(() => selectedSeason = 0)),
                        _buildChoiceButton(
                            1,
                            selectedSeason == 1,
                            tr("travel.season.summer"),
                            Icons.wb_sunny,
                            Colors.yellow,
                            onTap: () => setState(() => selectedSeason = 1)),
                        _buildChoiceButton(
                            2,
                            selectedSeason == 2,
                            tr("travel.season.autumn"),
                            Icons.park,
                            Colors.orange,
                            onTap: () => setState(() => selectedSeason = 2)),
                        _buildChoiceButton(
                            3,
                            selectedSeason == 3,
                            tr("travel.season.winter"),
                            Icons.ac_unit,
                            Colors.blueAccent,
                            onTap: () => setState(() => selectedSeason = 3)),
                      ],
                    ),
                    const SizedBox(height: 100), // отступ для кнопки Continue
                  ],
                ),
              ),
            ),

            // Кнопка Continue (Жалғастыру)
            GestureDetector(
              onTap: canContinue
                  ? () {
                      final planData = {
                        "title": tr("travel.plan.title"),
                        "subtitle": tr("travel.plan.subtitle"),
                        "person": selectedPerson,
                        "preferences": selectedPreferences,
                        "season": selectedSeason,
                      };
                      Provider.of<DraftPlanProvider>(context, listen: false)
                          .merge(planData);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FifthPage(),
                        ),
                      );
                    }
                  : null,
              child: Container(
                height: 54,
                width: double.infinity,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: canContinue ? const Color(0xFF78E9A9) : Colors.grey,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Center(
                  child: Text(
                    tr("buttons.continue"),
                    style: const TextStyle(
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

  Widget _buildChoiceButton(int index, bool isSelected, String text, IconData icon,
      Color iconColor,
      {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF78E9A9) : const Color(0xFFE6E5E5),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: isSelected ? const Color(0xFF18583B) : Colors.transparent,
              width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: iconColor),
            const SizedBox(width: 6),
            Text(text, style: const TextStyle(fontSize: 14, color: Colors.black)),
          ],
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

    final cuisines = [
      {"key": "travel.cuisine.options.kazakh", "icon": "kazakh"},
      {"key": "travel.cuisine.options.italian", "icon": "italian"},
      {"key": "travel.cuisine.options.japanese", "icon": "japan"},
      {"key": "travel.cuisine.options.russian", "icon": "russian"},
      {"key": "travel.cuisine.options.turkish", "icon": "turkish"},
      {"key": "travel.cuisine.options.chinese", "icon": "chinese"},
      {"key": "travel.cuisine.options.korean", "icon": "korean"},
      {"key": "travel.cuisine.options.indian", "icon": "indian"},
      {"key": "travel.cuisine.options.georgian", "icon": "gruzinskaya"},
      {"key": "travel.cuisine.options.french", "icon": "french"},
      {"key": "travel.cuisine.options.mexican", "icon": "mexican"},
      {"key": "travel.cuisine.options.american", "icon": "american"},
    ];

    final drinks = [
      {"key": "travel.drinks.options.coffee", "icon": "coffee"},
      {"key": "travel.drinks.options.tea", "icon": "tea"},
      {"key": "travel.drinks.options.wine", "icon": "wine"},
      {"key": "travel.drinks.options.beer", "icon": "beer"},
      {"key": "travel.drinks.options.smoothie", "icon": "smoothie"},
      {"key": "travel.drinks.options.cocktail", "icon": "cocktail"},
      {"key": "travel.drinks.options.soda", "icon": "soda"},
      {"key": "travel.drinks.options.juice", "icon": "juice"},
      {"key": "travel.drinks.options.whiskey", "icon": "whiskey"},
      {"key": "travel.drinks.options.champagne", "icon": "champagne"},
      {"key": "travel.drinks.options.milkshake", "icon": "milkshake"},
      {"key": "travel.drinks.options.kymyz", "icon": "kymyz"},
      {"key": "travel.drinks.options.bubbletea", "icon": "bubbletea"},
      {"key": "travel.drinks.options.shubat", "icon": "shubat"},
      {"key": "travel.drinks.options.water", "icon": "water"},
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: LinearProgressIndicator(
                  value: 0.66,
                  minHeight: 10,
                  backgroundColor: const Color(0xFFD9D9D9),
                  valueColor:
                      const AlwaysStoppedAnimation(Color(0xFF78E9A9)),
                ),
              ),
              const SizedBox(height: 20),

              // Заголовок
              Text(
                tr("travel.cuisine.title"),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),

              // Подзаголовок
              Text(
                tr("travel.cuisine.subtitle"),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Color(0xFF737272),
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Вопрос про кухню
                      Text(
                        tr("travel.cuisine.question"),
                        style: const TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                          fontSize: 18, // увеличен размер
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Кнопки кухни
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(cuisines.length, (index) {
                          final item = cuisines[index];
                          return _buildChoiceButton(
                              index,
                              selectedCuisines.contains(index),
                              tr(item["key"]!),
                              item["icon"]!,
                              isCuisine: true);
                        }),
                      ),
                      const SizedBox(height: 30),

                      // Вопрос про напитки
                      Text(
                        tr("travel.drinks.question"),
                        style: const TextStyle(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                          fontSize: 18, // увеличен размер
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Кнопки напитков
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(drinks.length, (index) {
                          final item = drinks[index];
                          return _buildChoiceButton(
                              index,
                              selectedDrinks.contains(index),
                              tr(item["key"]!),
                              item["icon"]!,
                              isCuisine: false);
                        }),
                      ),
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
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: canContinue ? const Color(0xFF78E9A9) : Colors.grey,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Center(
                    child: Text(
                      tr("buttons.continue"),
                      style: const TextStyle(
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

  Widget _buildChoiceButton(int index, bool isSelected, String text, String iconName,
      {bool isCuisine = true}) {
    return GestureDetector(
      onTap: () => isCuisine ? toggleCuisine(index) : toggleDrink(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), // увеличен padding
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF78E9A9) : const Color(0xFFE6E5E5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF18583B) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/$iconName.png", width: 24, height: 24), // увеличен размер
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                  fontFamily: "Inter", fontSize: 16, color: Colors.black), // увеличен шрифт
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

  final List<Map<String, String>> activities = [
    {"key": "travel.activities.options.beach", "icon": "beach"},
    {"key": "travel.activities.options.city", "icon": "city"},
    {"key": "travel.activities.options.countryside", "icon": "countryside"},
    {"key": "travel.activities.options.lake", "icon": "lake"},
    {"key": "travel.activities.options.historical", "icon": "historical"},
    {"key": "travel.activities.options.river", "icon": "river"},
    {"key": "travel.activities.options.garden", "icon": "garden"},
    {"key": "travel.activities.options.recreation", "icon": "recreation"},
    {"key": "travel.activities.options.spa", "icon": "spa"},
    {"key": "travel.activities.options.gorge", "icon": "gorge"},
    {"key": "travel.activities.options.shopping", "icon": "shopping"},
    {"key": "travel.activities.options.sport", "icon": "sport"},
    {"key": "travel.activities.options.theatre", "icon": "theatre"},
    {"key": "travel.activities.options.walking", "icon": "walking"},
    {"key": "travel.activities.options.museum", "icon": "museum"},
    {"key": "travel.activities.options.cooking", "icon": "cooking"},
    {"key": "travel.activities.options.concert", "icon": "concert"},
    {"key": "travel.activities.options.yoga", "icon": "yoga"},
    {"key": "travel.activities.options.religion", "icon": "religion"},
    {"key": "travel.activities.options.skydiving", "icon": "skydiving"},
    {"key": "travel.activities.options.fishing", "icon": "fishing"},
    {"key": "travel.activities.options.diving", "icon": "diving"},
    {"key": "travel.activities.options.aquapark", "icon": "aquapark"},
    {"key": "travel.activities.options.entertainmentarea", "icon": "entertainmentarea"},
  ];

  final List<Map<String, String>> accommodations = [
    {"key": "travel.accommodations.options.hotel", "icon": "hotel"},
    {"key": "travel.accommodations.options.resort", "icon": "resort"},
    {"key": "travel.accommodations.options.cottage", "icon": "cottage"},
    {"key": "travel.accommodations.options.camping", "icon": "camping"},
    {"key": "travel.accommodations.options.hostel", "icon": "hostel"},
    {"key": "travel.accommodations.options.villa", "icon": "villa"},
    {"key": "travel.accommodations.options.flat", "icon": "flat"},
    {"key": "travel.accommodations.options.glamping", "icon": "glamping"},
  ];

  @override
  Widget build(BuildContext context) {
    final bool canContinue =
        selectedActivities.isNotEmpty && selectedAccommodations.isNotEmpty;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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

                Text(
                  tr("travel.title"),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  tr("travel.subtitle"),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Color(0xFF737272),
                  ),
                ),
                const SizedBox(height: 25),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    tr("travel.activities.question"),
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 15),

                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(activities.length, (index) {
                    final item = activities[index];
                    return _buildActivityButton(
                        index,
                        selectedActivities.contains(index),
                        tr(item["key"]!),
                        item["icon"]!);
                  }),
                ),
                const SizedBox(height: 25),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    tr("travel.accommodations.question"),
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 15),

                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(accommodations.length, (index) {
                    final item = accommodations[index];
                    return _buildAccommodationButton(
                        index,
                        selectedAccommodations.contains(index),
                        tr(item["key"]!),
                        item["icon"]!);
                  }),
                ),
                const SizedBox(height: 15),

                GestureDetector(
                  onTap: canContinue
                      ? () {
                          final activityData = {
                            "activities": selectedActivities,
                            "accommodations": selectedAccommodations,
                          };
                          Provider.of<DraftPlanProvider>(context, listen: false)
                              .merge(activityData);
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
                      color: canContinue
                          ? const Color(0xFF78E9A9)
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: Center(
                      child: Text(
                        tr("buttons.continue"),
                        style: const TextStyle(
                            fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivityButton(int index, bool isSelected, String text, String iconName) {
    return GestureDetector(
      onTap: () => toggleActivity(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF78E9A9) : const Color(0xFFE6E5E5),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? const Color(0xFF18583B) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/$iconName.png", width: 18, height: 18),
            const SizedBox(width: 6),
            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccommodationButton(int index, bool isSelected, String text, String iconName) {
    return GestureDetector(
      onTap: () => toggleAccommodation(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF78E9A9) : const Color(0xFFE6E5E5),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? const Color(0xFF18583B) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/$iconName.png", width: 18, height: 18),
            const SizedBox(width: 6),
            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
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
    {'icon': Icons.flight, 'key': 'plane'},
    {'icon': Icons.train, 'key': 'train'},
    {'icon': Icons.pedal_bike, 'key': 'bike'},
    {'icon': Icons.directions_car, 'key': 'car'},
    {'icon': Icons.directions_bus, 'key': 'bus'},
    {'icon': Icons.motorcycle, 'key': 'motorcycle'},
    {'icon': Icons.flight_takeoff, 'key': 'helicopter'},
    {'icon': Icons.directions_transit, 'key': 'minivan'},
    {'icon': Icons.electric_scooter, 'key': 'scooter'},
    {'icon': Icons.kayaking, 'key': 'kayak'},
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
                    // Вопрос 1: Транспорт
                    Text(
                      tr("travel.transport.question"),
                      style: const TextStyle(
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
                        final isSelected = selectedTransport == t['key'];
                        final label = tr("travel.transport.options.${t['key']}");
                        return ChoiceChip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(t['icon'] as IconData, size: 20),
                              const SizedBox(width: 5),
                              Text(label),
                            ],
                          ),
                          selected: isSelected,
                          selectedColor: const Color(0xFF78E9A9),
                          onSelected: (_) {
                            setState(() {
                              selectedTransport = t['key'] as String;
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 30),

                    // Вопрос 2: Бюджет
                    Text(
                      tr("travel.budget.question"),
                      style: const TextStyle(
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
                          ? "1 000 000+ ${tr("travel.budget.text")}"
                          : "$budgetValue ${tr("travel.budget.text")}",
                      style: const TextStyle(
                        fontFamily: "Inter",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Вопрос 3: Дата поездки
                    Text(
                      tr("travel.duration.question"),
                      style: const TextStyle(
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
  locale: context.locale.languageCode, // <-- добавлено для динамической локали
  focusedDay: focusedDay,
  firstDay: DateTime.utc(2020, 1, 1),
  lastDay: DateTime.utc(2030, 12, 31),
  calendarFormat: CalendarFormat.month,
  availableCalendarFormats: const {
    CalendarFormat.month: 'Month', // можно локализовать через tr()
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

            // Кнопка "Продолжить"
            GestureDetector(
              onTap: canContinue
                  ? () {
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
                child: Center(
                  child: Text(
                    tr("buttons.continue"),
                    style: const TextStyle(
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
  }}


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

            // Текст с переводом
            Text(
              tr("loading.message"),
              textAlign: TextAlign.center,
              style: const TextStyle(
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
      MapRecommendationsPage(),
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
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Карта"),
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

  @override
  Widget build(BuildContext context) {
    // Локализованные дни
    final days = tr("eighthPage.days").split(',');
    final currentDay = days[selectedDayIndex];

    final draft = Provider.of<DraftPlanProvider>(context).draft;

    // План мероприятий с ключами для локализации
    final plan = {
      days[0]: [
        {"time": "09:00", "activityKey": "22_1", "image": "assets/images/airport.jpg"},
        {"time": "09:30", "activityKey": "22_2", "image": "assets/images/hotel.jpg"},
        {"time": "10:00", "activityKey": "22_3", "image": "assets/images/room.jpg"},
        {"time": "12:00", "activityKey": "22_4", "image": "assets/images/breakfast.jpg"},
        {"time": "13:00", "activityKey": "22_5", "image": "assets/images/river.jpg"},
        {"time": "14:30", "activityKey": "22_6", "image": "assets/images/bayterek.jpg"},
        {"time": "16:00", "activityKey": "22_7", "image": "assets/images/lunch.jpg"},
        {"time": "18:00", "activityKey": "22_8", "image": "assets/images/opera.jpg"},
        {"time": "20:30", "activityKey": "22_9", "image": "assets/images/dinner.jpg"},
        {"time": "22:00", "activityKey": "22_10", "image": "assets/images/night.jpg"},
      ],
      days[1]: [
        {"time": "09:00", "activityKey": "23_1", "image": "assets/images/breakfast.jpg"},
        {"time": "10:00", "activityKey": "23_2", "image": "assets/images/mosque.jpg"},
        {"time": "11:30", "activityKey": "23_3", "image": "assets/images/square.jpg"},
        {"time": "13:00", "activityKey": "23_4", "image": "assets/images/sandyq.jpg"},
        {"time": "14:30", "activityKey": "23_5", "image": "assets/images/shopping.jpg"},
        {"time": "17:00", "activityKey": "23_6", "image": "assets/images/museum.jpg"},
        {"time": "19:00", "activityKey": "23_7", "image": "assets/images/boulevard.jpg"},
        {"time": "20:30", "activityKey": "23_8", "image": "assets/images/metis.jpg"},
        {"time": "22:00", "activityKey": "23_9", "image": "assets/images/night.jpg"},
      ],
      days[2]: [
        {"time": "09:00", "activityKey": "24_1", "image": "assets/images/breakfast.jpg"},
        {"time": "10:00", "activityKey": "24_2", "image": "assets/images/garden.jpg"},
        {"time": "12:00", "activityKey": "24_3", "image": "assets/images/shopping2.jpg"},
        {"time": "14:00", "activityKey": "24_4", "image": "assets/images/linebrew.jpg"},
        {"time": "16:00", "activityKey": "24_5", "image": "assets/images/airport.jpg"},
        {"time": "18:00", "activityKey": "24_6", "image": "assets/images/plane.jpg"},
      ],
    };

    return Scaffold(
      appBar: AppBar(title: Text(tr("eighthPage.title"))),
      body: Column(
        children: [
          // Дни
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
                    child: Center(
                      child: Text(
                        day,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Список активностей
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
                        child: Image.asset(
                          activity["image"]!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(activity["time"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              // Локализованный текст активности
                              Text(tr("eighthPage.activities.${activity["activityKey"]}")),
                            ],
                          ),
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
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF18583B),
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: () {
            final finalPlan = <String, dynamic>{
              "title": draft["title"] ?? tr("eighthPage.title"),
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
          child: Text(
            tr("eighthPage.saveButton"),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}



// ========================
// PlanDetailPage (локализация исправлена)
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
          // Подзаголовок
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              widget.planData["subtitle"] ?? "",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),

          // Список дней
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
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF78E9A9) : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        day,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Список активностей
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
                          child: Image.asset(
                            a["image"],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                a["time"] ?? "",
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              // Локализация активности
                              Text(tr("eighthPage.activities.${a["activityKey"]}")),
                            ],
                          ),
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
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF18583B),
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: () {
            Provider.of<PlanProvider>(context, listen: false).addPlan(widget.planData);
            Provider.of<DraftPlanProvider>(context, listen: false).clear();

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainPage(initialIndex: 3)),
              (route) => false,
            );
          },
          child: Text(
            tr("eighthPage.saveButton"),
            style: const TextStyle(color: Colors.white),
          ),
        ),
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
        automaticallyImplyLeading: false,
        title: const Text(
          "Nomad Visit",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔹 Приветствие от AI-аватара
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChatPage()),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/mascot.png",
                        height: 60,
                        width: 60,
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Text(
                          "Привет! 👋 Я твой гид по Астане.\nНажми, чтобы пообщаться со мной!",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// 🔹 Ближайшие события (карточка)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EventsPage()),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.asset(
                        "assets/images/events.jpg",
                        fit: BoxFit.cover,
                        height: 140,
                        width: double.infinity,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        "Ближайшие события в Астане 🎉\nНажми, чтобы узнать подробности!",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// 🔹 Квест дня
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.map, color: Colors.blue, size: 40),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        "Квест дня: найди Байтерек 🌟\nСделай фото и получи бейдж!",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text("Квест дня пока в разработке 🚀")),
                        );
                      },
                      child: const Text("Начать"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final events = [
      {
        "image": "assets/images/exhibition.jpg",
        "title": "Выставка HOLA-SALEM",
        "date": "до 9 ноября",
        "time": "10:00 – 20:00",
        "desc":
            "Будут представлены работы таких талантов, как: Алан Састрэ, Алехандра Фрейманн, Алехандро Ботуболь, Виктория Ирансо, Уго Фонтела, Хулия Санта-Олайя, Алибек Мергенов, Зура Асылгазина, Сауле Мадиева.",
        "location": "O FORTE KULANSHI, ул. Достык, 8/1",
        "price": "Вход бесплатный",
      },
      {
        "image": "assets/images/standup.jpg",
        "title": "Сольный стендап-концерт Славы Никифорова",
        "date": "27 сентября",
        "time": "19:00",
        "desc":
            "Слава — частый гость YouTube шоу «Setaptar», «Поговорим откровенно», «Или чо». Автор персонажей Кимуры Грейси и «паук родной».",
        "location": "Harat's Irish Pub",
        "price": "от 10 000 ₸",
      },
      {
        "image": "assets/images/jazz.jpg",
        "title": "Джазовый вечер c Nasiafromasia",
        "date": "27 сентября",
        "time": "20:00",
        "desc":
            "Nasiafromasia — независимый артист, певица, автор песен. Выпускница Миланской академии Accademia del suono.",
        "location": "The Walls, Менгілік ел, 38",
        "price": "15 000 ₸",
      },
      {
        "image": "assets/images/show.jpg",
        "title": "Комедийное шоу «Чотам?»",
        "date": "26 сентября",
        "time": "19:30 и 21:30",
        "desc":
            "Комики обсуждают культовые аниме: в 19:30 — Наруто, в 21:30 — Ван Пис, Demon Slayer, ДанДадан. Возрастное ограничение: 18+.",
        "location": "Bar Wien",
        "price": "от 3 000 ₸",
      },
      {
        "image": "assets/images/musicnight.jpg",
        "title": "Вечер музыки Harmony Beyond Borders",
        "date": "27 сентября",
        "time": "19:00",
        "desc":
            "Казахско-Американский дуэт на домбре исполнит традиционные и современные произведения, стирая границы и соединяя сердца.",
        "location": "ÓzgeEpic creative hub",
        "price": "6 000 ₸",
      },
      {
        "image": "assets/images/kurara.jpg",
        "title": "Концерт группы «Курара»",
        "date": "24 сентября",
        "time": "20:00",
        "desc":
            "Группа «Курара» — одна из визитных карточек современной уральской сцены. В 2024 коллектив отпраздновал своё 20-летие.",
        "location": "The Bus",
        "price": "от 15 000 ₸",
      },
      {
        "image": "assets/images/picasso.jpg",
        "title": "Выставка «Пабло Пикассо. Параграфы»",
        "date": "26 сентября – 9 ноября",
        "time": "10:00 – 20:00",
        "desc":
            "Будут представлены ключевые работы мастера, включая эскизы к «Гернике» и серии позднего творчества.",
        "location": "LM Kulanshi Art, ул. Аманжолова, 22а",
        "price": "от 2 500 ₸",
      },
      {
        "image": "assets/images/english.jpg",
        "title": "Стендап на английском",
        "date": "27 сентября",
        "time": "19:00",
        "desc":
            "13-й открытый микрофон английского стендапа в Астане. Организаторы — English Comedy Kz и Comedy Point.",
        "location": "Bar Wien",
        "price": "от 4 000 ₸",
      },
      {
        "image": "assets/images/aula.jpg",
        "title": "Концерт AUKA",
        "date": "28 сентября",
        "time": "19:00",
        "desc":
            "Auka за 10 лет на сцене завоевал сердца тысяч слушателей. Песни: «Толкыным», «Унсіз сезім», «Жараладын».",
        "location": "Филармония, Кенесары, 32",
        "price": "от 5 000 ₸",
      },
      {
        "image": "assets/images/hockey.jpg",
        "title": "Хоккейный матч «Барыс» — «Сибирь»",
        "date": "27 сентября",
        "time": "17:00",
        "desc": "Регулярный чемпионат КХЛ. «Барыс» сыграет против «Сибири».",
        "location": "Барыс Арена",
        "price": "от 1 800 ₸",
      },
      {
        "image": "assets/images/yusef.jpg",
        "title": "Выставка «Линогравюрный мир Юзефа Гельняка»",
        "date": "до 3 октября",
        "time": "10:00 – 19:00",
        "desc":
            "Галерея Has Sanat представляет персональную выставку польского художника Юзефа Гельняка.",
        "location": "Has Sanat",
        "price": "от 1 500 ₸",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
  elevation: 0,
  backgroundColor: Colors.white,
  leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.black),
    onPressed: () => Navigator.pop(context),
  ),
  title: const Text(
    "Актуальные события в Астане",
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 20,
    ),
  ),
),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final e = events[index];
          return _buildEventCard(
            e["image"]!,
            e["title"]!,
            e["date"]!,
            e["time"]!,
            e["desc"]!,
            e["location"]!,
            e["price"]!,
          );
        },
      ),
    );
  }

  Widget _buildEventCard(
    String image,
    String title,
    String date,
    String time,
    String desc,
    String location,
    String price,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // картинка
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(image,
                fit: BoxFit.cover, height: 180, width: double.infinity),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.calendar_today,
                        size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(date, style: const TextStyle(color: Colors.grey)),
                    const SizedBox(width: 12),
                    Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(time, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(desc, style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.place, size: 16, color: Colors.red),
                    const SizedBox(width: 4),
                    Expanded(child: Text(location)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.attach_money,
                        size: 18, color: Colors.green),
                    const SizedBox(width: 4),
                    Text(price,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.black)),
                  ],
                ),
              ],
            ),
          ),
        ],
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
          "Сообщество",
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
            "Была в Бурабае на выходных, природа просто потрясающая! 🌲🏞️",
            "assets/images/burabay.jpg",
          ),
          _buildPost(
            "Айбек",
            "Сегодня посетил Байтерек, вид с вершины просто невероятный! 🌟",
            "assets/images/touristreview.jpg",
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
            // ignore: deprecated_member_use
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
            subtitle: const Text("2 часа назад"),
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
    {"isUser": false, "text": "Привет! Я твой AI-гид по Казахстану. Чем могу помочь? 😊"},
  ];
  
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  // Замените на адрес вашего backend сервера
  final String apiUrl = 'http://localhost:3006/api/v1/api/chat/message';

  Future<void> _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    final userMessage = _controller.text.trim();
    _controller.clear();

    setState(() {
      messages.add({"isUser": true, "text": userMessage});
      _isLoading = true;
    });

    _scrollToBottom();

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'message': userMessage}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        
        setState(() {
          if (data['success'] == true) {
            messages.add({
              "isUser": false,
              "text": data['response'],
            });
          } else {
            messages.add({
              "isUser": false,
              "text": "Извините, произошла ошибка. Попробуйте еще раз. 😔",
            });
          }
          _isLoading = false;
        });
      } else {
        throw Exception('Ошибка сервера: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        messages.add({
          "isUser": false,
          "text": "Не удалось связаться с сервером. Проверьте подключение. 🔌",
        });
        _isLoading = false;
      });
      print('Ошибка: $e');
    }

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
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
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == messages.length && _isLoading) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: const Color(0xFF18583B),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text("Думаю...", style: TextStyle(fontSize: 15)),
                        ],
                      ),
                    ),
                  );
                }

                final msg = messages[index];
                return Align(
                  alignment: msg["isUser"] ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: msg["isUser"]
                          ? const Color(0xFF78E9A9)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      msg["text"],
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      enabled: !_isLoading,
                      decoration: const InputDecoration(
                        hintText: "Хабарлама жазыңыз...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: _isLoading
                          ? Colors.grey
                          : const Color(0xFF18583B),
                    ),
                    onPressed: _isLoading ? null : _sendMessage,
                  )
                ],
              ),
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
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text("История планов"),
              onTap: () {
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Выйти"),
              onTap: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}
