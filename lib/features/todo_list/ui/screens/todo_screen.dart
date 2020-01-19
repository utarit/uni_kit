import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_kit/features/todo_list/data/models/todo.dart';
import 'package:uni_kit/features/todo_list/data/models/todo_tag.dart';
import 'package:uni_kit/features/todo_list/domain/providers/todo_provider.dart';
import 'package:uni_kit/features/todo_list/domain/providers/todo_tag_provider.dart';
import 'package:uni_kit/features/todo_list/ui/screens/todo_edit_screen.dart';
import 'package:uni_kit/features/todo_list/ui/widgets/todo_list_tile.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TodoTag todoFilter;
  String newTag;
  int _selectedColor = 0;

  final courseColors = [
    Colors.red.value,
    Colors.purple.value,
    Colors.pink.value,
    Colors.blue.value,
    Colors.green.value,
    Colors.orange.value,
    Colors.cyan.value,
    Colors.indigo.value,
    Colors.lime.value
  ];

  final Map<String, Color> colorList = {
    "lastDay": Colors.red,
    "lastWeek": Colors.orange,
    "others": Colors.green,
    "passed": Colors.grey
  };

  @override
  void initState() {
    super.initState();
    todoFilter = TodoTag("ALL", Colors.white.value);
  }

  @override
  Widget build(BuildContext context) {
    print("Todo Screen built");

    return Row(
      // mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          //color: Color(0xFFE2E6EE),
          width: MediaQuery.of(context).size.width * 4 / 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 45.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "TODOs",
                      style: TextStyle(
                          fontFamily: "Galano",
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        _navigateTodoEditScreen(context);
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "#" + todoFilter.label,
                  style: TextStyle(
                      fontFamily: "Galano",
                      fontSize: 15,
                      color: Colors.grey[700]),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 8.0),
              //   child: Text("You can swipe to delete",
              //       style: TextStyle(color: Colors.black38)),
              // ),
              Expanded(
                child: Selector<TodoProvider, List<Todo>>(
                  selector: (context, TodoProvider todoProvider) =>
                      todoProvider.todos,
                  builder: (context, List<Todo> todos, child) =>
                      buildListView(todos),
                ),
              )
            ],
          ),
        ),
        Container(
          color: Color(0xFF232429),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 1 / 5,
          child: Selector<TodoTagProvider, List<TodoTag>>(
            selector: (context, TodoTagProvider todoTagProvider) =>
                todoTagProvider.todoTags,
            builder: (context, List<TodoTag> todoTags, child) =>
                SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 32.0),
                  //   child: Icon(
                  //     Icons.sort,
                  //     color: Colors.white,
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 34.0),
                    child: Icon(
                      Icons.receipt,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  buildCourseTile(context, TodoTag("ALL", Colors.white.value)),
                  if (todoTags != null)
                    buildCourseList(context, todoTags),
                  buildCourseTile(context, TodoTag("+", Colors.white.value)),
                  // buildCourseTile(context, "+", Colors.white.value, "+")
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildCourseList(context, List<TodoTag> todoTags) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(todoTags.length, (index) {
        return buildCourseTile(context, todoTags[index]);
      }),
    );
  }

  ListView buildListView(List<Todo> todos) {
    var sorted = sortedTodos(todos);

    return ListView.builder(
      itemCount: sorted.length,
      itemBuilder: (context, index) {
        final todo = sorted[index];

        return Dismissible(
          direction: DismissDirection.endToStart,
          onDismissed: (DismissDirection direction) {
            Provider.of<TodoProvider>(context, listen: false)
                .deleteTodo(todo.key);
          },
          background: Container(
            padding: EdgeInsets.only(right: 16),
            alignment: Alignment.centerRight,
            color: Colors.grey,
            child: Icon(Icons.delete, color: Colors.white),
          ),
          key: UniqueKey(),
          child: TodoListTile(todo),
        );
      },
    );
  }

  void _showDialog(TodoTag tag) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Delete Tag"),
          content: Text("Are you sure to delete the tag?"),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                "Yes",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                await Provider.of<TodoTagProvider>(context).deleteTodoTag(tag.label);
                Provider.of<TodoProvider>(context).todos.forEach((todo){
                  todo.tags.remove(tag);
                });
                Provider.of<TodoProvider>(context).editTodoMultiple(Provider.of<TodoProvider>(context).todos);
                setState(() {
                  todoFilter = TodoTag("ALL", Colors.white.value);
                });
                Future.delayed(Duration(milliseconds: 100), () {
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildCourseTile(context, TodoTag tag) => GestureDetector(
        onTap: () {
          if (tag.label == "+") {
            showNewTagSheet(context);
          } else {
            if (todoFilter != tag) {
              setState(() {
                todoFilter = tag;
              });
            }
          }
        },
        onLongPress: (){
          if(tag.label != "ALL" && tag.label != "+"){
            _showDialog(tag);
          }
          
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width * 1 / 5 - 30,
              width: MediaQuery.of(context).size.width * 1 / 5 - 30,
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Color(0xff3A3B40),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(offset: Offset.fromDirection(3.14 / 2))],
                // border: Border.all(width: todoFilter == filter ? 1 : 0),
              ),
              alignment: Alignment.center,
              child: Text(
                tag.label[0].toUpperCase(),
                style: TextStyle(
                  fontSize: 20,
                  color: Color(
                    tag.colorValue,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            todoFilter == tag
                ? Positioned(
                    right: 5,
                    top: 13,
                    child: CircleAvatar(
                      radius: 4,
                      child: Container(),
                      backgroundColor: Color(tag.colorValue),
                    ),
                  )
                : SizedBox.shrink()
          ],
        ),
      );

  void showNewTagSheet(context) {
    Scaffold.of(context).showBottomSheet(
      (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      textCapitalization: TextCapitalization.words,
                      onChanged: (str){
                        setState(() {
                          newTag = str;
                        });
                      },
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 17),
                        hintText: 'Label (cannot be empty)',
                        // suffixIcon: Icon(Icons.search),
                        // border: InputBorder(borderSide: ),
                        contentPadding: EdgeInsets.all(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: courseColors.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          // padding: EdgeInsets.all(0),
                          onTap: () {
                            setState(() {
                              _selectedColor = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(4),
                            width: 60,
                            decoration: BoxDecoration(
                              border: _selectedColor == index
                                  ? Border.all(
                                      color: Colors.black, width: 2)
                                  : Border.all(width: 0),
                              borderRadius: BorderRadius.circular(12),
                              color: Color(courseColors[index]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      if(newTag != null){
                        var tag = TodoTag(newTag, courseColors[_selectedColor]);
                        Provider.of<TodoTagProvider>(context, listen: false).editTodoTag(newTag, tag);
                        Navigator.pop(context);
                      } else {

                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Color(0xFF232429),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Add Tag",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
      backgroundColor: Colors.grey[100],
      elevation: 4,
    );
  }

  List<Todo> sortedTodos(List<Todo> todos) {
    todos.sort((a, b) => a.endTime.compareTo(b.endTime));
    if (todoFilter.label != "ALL") {
      return todos.where((entry) => entry.tags.contains(todoFilter)).toList();
    }
    return todos;
  }

  _navigateTodoEditScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TodoEditScreen()),
    );
  }
}
