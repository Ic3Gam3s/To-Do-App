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
    Task("Wirtschaftshausaufgaben machen", DateTime(2024, 5, 20)),
    Task("Deutschbuch lesen (Terror)", DateTime.now()),
  ];
  List<Task> completedTasks = [];
  bool showCompleteTasks = false;

  Widget _taskListTile(Task task, int index) {
    return ListTile(
      leading: Checkbox(
        value: task.complete,
        onChanged: (value) {
          setState(() {
            task.complete = value!;

            if (value!) {
              completedTasks.add(task);
              tasks.removeAt(index);
            } else {
              tasks.add(task);
              completedTasks.removeAt(index);
            }
          });
        },
      ),
      title: Text(task.text),
      onTap: () async {
        _openListTileDialog(task, index);
      },
    );
  }

  void _openListTileDialog(Task? task, int? index) async {
    TextEditingController _textController = TextEditingController();
    TextEditingController _dateController = TextEditingController();

    if (task != null) {
      _textController.text = task.text;
    }

    Task? updatedTask = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              Text(task != null ? "Task bearbeiten" : "Neuen Task erstellen"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Abbrechen"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            OutlinedButton(
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [Icon(Icons.save), Text("Task Speichern")],
              ),
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  Navigator.pop(
                    context,
                    Task(_textController.text),
                  );
                }
              },
            ),
          ],
        );
      },
    );

    if (updatedTask != null) {
      if (index != null) {
        if (task!.complete) {
          setState(() {
            completedTasks[index] = updatedTask;
          });
        } else {
          setState(() {
            tasks[index] = updatedTask;
          });
        }
      } else {
        setState(() {
          tasks.add(updatedTask);
        });
      }
    }
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
                      return const Divider();
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return _taskListTile(tasks[index], index);
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
            Divider(
              thickness: 4,
            ),
            ListTile(
              leading: Icon(
                showCompleteTasks ? Icons.arrow_drop_down : Icons.arrow_right,
                size: 32,
              ),
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
            showCompleteTasks
                ? ListView.separated(
                    shrinkWrap: true,
                    itemCount: completedTasks.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return _taskListTile(completedTasks[index], index);
                    },
                  )
                : const SizedBox(
                    height: 0,
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _openListTileDialog(null, null);
        },
      ),
    );
  }
}
