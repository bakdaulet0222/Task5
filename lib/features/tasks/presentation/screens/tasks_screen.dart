import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task5/features/tasks/presentation/blocs/tasks_bloc.dart';
import 'package:task5/features/tasks/data/repositories/task_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TasksScreen extends StatefulWidget {
  final Function(Locale) setLocale;

  TasksScreen({required this.setLocale});

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<String> _tasks = [];
  final TextEditingController _taskController = TextEditingController();
  final TodoRepository _todoRepository = TodoRepository();

  @override
  void initState() {
    super.initState();
    _loadTodo();
  }

  void _loadTodo() async {
    try {
      var todo = await _todoRepository.getTodo();
      setState(() {
        _tasks.add(todo.title);
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _tasks.add(_taskController.text);
        _taskController.clear();
      });
    }
  }

  void _changeLanguage() async {
    final Locale? selectedLocale = await showDialog<Locale>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Выберите язык'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Locale>[Locale('en', ''), Locale('ru', '')]
                  .map((locale) => ListTile(
                        title: Text(_getLocaleName(locale)),
                        onTap: () => Navigator.pop(context, locale),
                      ))
                  .toList(),
            ),
          ),
        );
      },
    );

    if (selectedLocale != null) {
      setState(() {
        widget.setLocale(selectedLocale);
      });
    }
  }

  String _getLocaleName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'ru':
        return 'Русский';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Text(AppLocalizations.of(context)!.title),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: _changeLanguage,
            child: Text(
              AppLocalizations.of(context)!.language,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                fillColor: Color(0xFF191919),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: 'Введите задачу',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                labelText: AppLocalizations.of(context)!.newTask,
              ),
            ),
            SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: _addTask,
              child: Text(AppLocalizations.of(context)!.addTask),
            ),
            Expanded(
                child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _tasks[index],
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
