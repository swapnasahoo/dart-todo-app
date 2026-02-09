import 'dart:io';

class Todo {
  String todoName;
  String todoInfo;
  bool isCompleted;

  Todo(this.todoName, this.todoInfo, {this.isCompleted = false});

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }

  @override
  String toString() {
    return 'Todo name: $todoName \nTodo info: $todoInfo \nCompleted: $isCompleted';
  }
}

final List<Todo> todos = [];

void addTodo() {
  // get todoName
  stdout.write('Enter your todo name: ');
  final todoName = stdin.readLineSync() ?? '';

  // get todoInfo
  stdout.write('Enter todo info: ');
  final todoInfo = stdin.readLineSync() ?? '';

  // create and store todo
  final createdTodo = Todo(todoName, todoInfo);
  todos.add(createdTodo);

  // inform user
  print('Todo created');
  print(createdTodo);
}
