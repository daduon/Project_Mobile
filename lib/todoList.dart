import 'package:flutter/material.dart';
import 'todo.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}
class _TodoListState extends State<TodoList> {
  List<Todo> todos = [];
  TextEditingController controller = new TextEditingController();
  _toggleTodo(Todo todo, bool isChecked) {
    setState(() {
      todo.isDone = isChecked;
    });
  }
  Widget _buildItem(BuildContext context, int index) {
    final todo = todos[index];
    return CheckboxListTile(
      value: todo.isDone,
      title: Text(todo.title),
      onChanged: (bool isChecked) {
        _toggleTodo(todo, isChecked);
      },
    );
  }
  _addTodo(){
    showDialog<Todo>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          title: Text('Add new todo list'),
          content: TextField(
            controller: controller,
          ),
          actions: <Widget>[
            MaterialButton(
              child: Text("Cancel",style: TextStyle(color: Colors.blue),),
              onPressed: () {
                Navigator.of(context).pop();
                // use for clear text in textfield
                controller.clear();
              },
            ),
            MaterialButton(
              child: Text( "Add",style: TextStyle(color: Colors.blue),),
              onPressed: () {
                setState(() {
                  // for get values from textfield
                  final todo = new Todo(title: controller.value.text);
                  if(controller.value.text !=""){
                    Navigator.of(context).pop();
                    // for add textfield to checkbox
                    todos.add(todo);
                  }else{
                    Navigator.of(context).pop();
                  }
                  controller.clear();
                });
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project Todo List'),
      ),
      // output on the interface type list
      body: ListView.builder(
        itemBuilder: _buildItem,
        itemCount: todos.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addTodo,
      ),
    );
  }
}
