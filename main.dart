import 'dart:convert';
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

Future<void> addTodo() async {
  // get todoName
  stdout.write('Enter your todo name: ');
  final todoName = stdin.readLineSync() ?? '';

  // get todoInfo
  stdout.write('Enter todo info: ');
  final todoInfo = stdin.readLineSync() ?? '';

  // create todo
  final createdTodo = Todo(todoName, todoInfo);

  // format todo
  final formattedTodo = {
    'todoName': todoName,
    'todoInfo': todoInfo,
    'isCompleted': false,
  };

  // get / create todos.json file
  final file = File('todos.json');
  if (!await file.exists()) {
    await file.writeAsString('[]');
  }

  // get already created todos
  final todoListJson = await file.readAsString();
  final todoList = jsonDecode(todoListJson);

  // add createdTodo to todoList
  todoList.add(formattedTodo);

  // save the new todo
  await file.writeAsString(jsonEncode(todoList));

  // inform user
  print('Todo created');
  print(createdTodo);
}

Future<void> viewTodos() async {
  final file = File('todos.json');

  if (!await file.exists()) {
    print("You haven't made any todos till now. Create one to view.");
    return;
  }

  final todoListJson = await file.readAsString();
  final todoList = jsonDecode(todoListJson);
  var todoNum = 1;

  for (var todo in todoList) {
    final todoName = todo['todoName'];
    final todoInfo = todo['todoInfo'];
    final isCompleted = todo['isCompleted'];

    print(
      '\n$todoNum. \nTodo Name: $todoName \nTodo info: $todoInfo \nCompleted: $isCompleted\n',
    );
    todoNum++;
  }
}

void deleteTodo() async {
  await viewTodos();

  stdout.write('Enter the todo number you want to delete: ');
  final todoNum = stdin.readLineSync() ?? '';
  final int todoIndex = int.parse(todoNum) - 1;

  if (todoIndex < 0 || todoIndex.isNaN) {
    print('Invalid todo number');
    deleteTodo();
    return;
  }

  // get todo list
  final file = File('todos.json');

  final todoListJson = await file.readAsString();
  final todoList = jsonDecode(todoListJson);

  // remove todo
  todoList.removeAt(todoIndex);

  // update json file
  await file.writeAsString(jsonEncode(todoList));

  // inform user
  print('Todo number $todoNum successfully deleted');
}

void exit() {
  print('Goodbye 👋');
}

void main() async {
  print('\n====== TODO APP ======\n');
  print('1. Add todo');
  print('2. View todos');
  print('3. Delete todo');
  print('4. Exit');

  stdout.write('Choose one of the options: ');
  final choice = stdin.readLineSync() ?? '';

  switch (choice) {
    case '1':
      await addTodo();
      break;
    case '2':
      await viewTodos();
      break;
    case '3':
      deleteTodo();
    case '4':
      exit();
      return;
    default:
      print('\nInvalid option');
      main();
  }
}
