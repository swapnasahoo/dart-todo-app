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

void addTodo() {
  // get todoName
  stdout.write('Enter your todo name: ');
  final todoName = stdin.readLineSync() ?? '';

  // get todoInfo
  stdout.write('Enter todo info: ');
  final todoInfo = stdin.readLineSync() ?? '';

  // create and store todo
  final createdTodo = Todo(todoName, todoInfo);

  // inform user
  print('Todo created');
  print(createdTodo);
}

void exit() {
  print('Goodbye 👋');
}

void main() {
  print('\n====== TODO APP ======\n');
  print('1. Add todo');
  print('2. Exit');

  stdout.write('Choose one of the options: ');
  final choice = stdin.readLineSync() ?? '';

  switch (choice) {
    case '1':
      addTodo();
      break;
    case '2':
      exit();
      return;
    default:
      print('\nInvalid option');
      main();
  }
}
