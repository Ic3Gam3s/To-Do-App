import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [
    Task("Einkaufsliste erstellen"),
    Task("Wirtschaftshausaufgaben machen", DateTime(2024, 5,20)),
    Task("Deutschbuch lesen (Terror)", DateTime.now()),
  ];
  List<Task> completedTasks = [
    Task("Stärken / Schwächen aufschreiben"),
    Task("Warum XY"),
  ];
  bool showCompleteTasks = false;

  Widget _taskListTile(Task task) {
    return ListTile(
      title: Text(task.text),
      onTap: () {

      },
    );
  }

  void _openListTileDialog(Task? task) {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.task_rounded,
              size: 26,
            ),
            Text(
              "To-Do's",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            tasks.isNotEmpty
                ? ListView.separated(
                  shrinkWrap: true,
                    itemCount: tasks.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return _taskListTile(tasks[index]);
                    },
                  )
                : const Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.celebration,
                            size: 50,
                          ),
                          Text(
                            "Nichts mehr zu tun!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 26),
                          ),
                        ],
                      ),
                    ),
                  ),
            ListTile(
              leading: Icon(
                  showCompleteTasks ? Icons.arrow_drop_down : Icons.arrow_right, size: 32,),
              title: Text("Erledigt (${completedTasks.length})"),
              onTap: () {
                setState(() {
                  if (showCompleteTasks) {
                    showCompleteTasks = false;
                  } else {
                    showCompleteTasks = true;
                  }
                });
              },
            ),
            showCompleteTasks ? 
            ListView.separated(
              shrinkWrap: true,
              itemCount: completedTasks.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
              itemBuilder: (BuildContext context, int index) {
                return _taskListTile(completedTasks[index]);
              },
            ) : SizedBox(height: 0,),
          ],
        ),
      ),

      /*tasks.isNotEmpty
          ? ListView(
              children: [
                ListView.separated(
                  itemCount: tasks.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(tasks[index].text),
                    );
                  },
                ),
              ],
            )
          : const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.celebration,
                    size: 50,
                  ),
                  Text(
                    "Nichts mehr zu tun!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                ],
              ),
            ),*/

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
