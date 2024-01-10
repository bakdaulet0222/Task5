
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoService {
  Future<Map<String, dynamic>> fetchTodo() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load todo');
    }
  }
}