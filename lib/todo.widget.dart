import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
// Data.
import 'todos.dart';


class ToDo extends StatefulWidget {
  const ToDo({ Key? key }) : super(key: key);

  @override
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  var output = '';
  //
  Widget generateListTile(ToDoDB todo, int index){
    return Container(
        height: 70.0,
        child: Card(child: ListTile(
          title: Container(
            width: 50.0,
            child: Text(todo.title, style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0
            ))),
          trailing: Container(
            width: 50.0,
            child: Row(
            children:[
              Container(
                child: GestureDetector(
                  onTap: (){
                    
                  },
                  child: Icon(Icons.edit),
                )
              ),
              Container(
                padding: const EdgeInsets.only(left: 2.0),
                child: GestureDetector(
                  onTap: (){
                    
                  },
                  child: Icon(Icons.delete),
                )
              ),
            ])
          ),
        )
      )
    );
  }
  Widget generateSlidableTile(ToDoDB todo, int index){
    return Container(
      child: Slidable(
          actionPane: SlidableBehindActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
              color: Colors.white,
              child: ListTile(
                  title: Text(todo.title, style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0
                  )
                ),
                trailing: Tooltip(
                  message: "drag to left", 
                  showDuration: Duration(seconds: 3),
                  child: Icon(Icons.drag_indicator)
                )
              ),
            ),
            secondaryActions: <Widget>[
              IconSlideAction(
                color: Colors.green,
                icon: Icons.edit,
                onTap: (){
                  setState((){
                    ToDoDB.todos.replaceRange(index, index+1, [ToDoDB(output)]);
                  });
                },
              ),
              IconSlideAction(
                color: Colors.red,
                icon: Icons.delete,
                onTap: (){
                  setState((){
                    ToDoDB.todos.removeAt(index);
                  });
                },
              ),
            ],
          )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('To-Do List', style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30
        )),
        toolbarHeight: 200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(MediaQuery.of(context).size.width, 100),
          )
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(25),
        child: Center(
          child: ListView.builder(
            itemCount: ToDoDB.todos.length,
            itemBuilder: (BuildContext context, int index){
              // return generateListTile(ToDoDB.todos[index]);
              return generateSlidableTile(ToDoDB.todos[index], index);
            }
          )
        )
      ),
      floatingActionButton: Container(
        height: 80,
        width: 80,
        child: FloatingActionButton(
          child: Icon(Icons.add, size: 40.0),
          onPressed: (){
            showDialog(context: context, builder: (context){
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                title: Stack(
                  children: <Widget>[
                    AppBar(
                      title: Text('New Task', style: TextStyle(
                        fontWeight: FontWeight.bold
                      )),
                      backgroundColor: Colors.redAccent,
                      automaticallyImplyLeading: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                    // Container(
                    //   child: Align(
                    //     child: Text('New Task'),
                    //     alignment: Alignment.center
                    //   ),
                  ]
                ),
                content: Container(
                  child: TextField(
                    onChanged: (value){
                      output = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'What are you planning?'
                    )
                  ),
                ),
                actions: [
                 Stack(children: <Widget>[
                    Align(
                      child: ElevatedButton(onPressed: (){
                      setState((){
                        ToDoDB.todos.add(ToDoDB(output));
                      });
                      Navigator.of(context).pop();
                    }, child: Text('Create', style: TextStyle(
                      fontWeight: FontWeight.bold
                    ))),
                    alignment: Alignment.center,
                  )
                 ]) 
                ],
              );
            });
          },
        )
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.redAccent,
        child: Container(height: 70.0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}