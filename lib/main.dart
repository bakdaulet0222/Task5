import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:task5/features/tasks/presentation/screens/tasks_screen.dart';
import 'package:task5/features/tasks/data/repositories/task_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'injection.dart';

void main() async {
  // configureDependencies();
  await Hive.initFlutter();
  await Hive.openBox('settings');
  WidgetsFlutterBinding.ensureInitialized();

  // Создание экземпляра TodoRepository
  TodoRepository todoRepository = TodoRepository();

  // Вызов getTodo и обработка полученных данных
  try {
    var todo = await todoRepository.getTodo();
    print('Todo title: ${todo.title}');
  } catch (e) {
    print('Error fetching todo: $e');
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en', '');

  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  void _loadLocale() async {
    var box = Hive.box('settings');
    var locale = box.get('locale', defaultValue: 'en');
    setState(() {
      _locale = Locale(locale, '');
    });
  }

  void _setLocale(Locale locale) async {
    var box = Hive.box('settings');
    await box.put('locale', locale.languageCode);
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('ru'), // Spanish
      ],
      home: TasksScreen(setLocale: _setLocale),
    );
  }
}