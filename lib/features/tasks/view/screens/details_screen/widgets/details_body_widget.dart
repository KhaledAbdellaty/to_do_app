import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../awesome_notification/notification_init.dart';
import '../../../../controller/providers/task_provider.dart';
import '../../../../data/model/task_model.dart';
import '../../../widgets/custom_multi_text_field.dart';

class DetailsBodyWidget extends StatelessWidget {
  final TaskModel taskModel;
  DetailsBodyWidget({Key? key, required this.taskModel}) : super(key: key);
  final _titleController = TextEditingController();
  final _noteContoller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    return Form(
      key: _key,
      child: Expanded(
        child: Center(
          child: Container(
            width: 350,
            height: 550,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: taskModel.color == 0
                  ? Colors.indigo
                  : taskModel.color == 1
                      ? Colors.pink
                      : Colors.deepPurple,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Hello Khaled !',
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    taskModel.isCompleted == 1
                        ? 'You Already Done It..'
                        : 'You Can Do It',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomMultiTextField(
                    label: 'Title',
                    maxLines: 3,
                    value: taskModel.title!,
                    controller: _titleController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: CustomMultiTextField(
                      label: 'Note',
                      maxLines: 6,
                      value: taskModel.note!,
                      controller: _noteContoller,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            completeOrNOcompleteTask(
                                taskProvider.completeTask(), context);
                            print(
                                'taskCompleted =  ${taskProvider.completeTask()}');
                            MyNotifications.instance.createNotification(
                                title: 'You Done It.. ', body: 'Keep Going....');
                          },
                          child: const Text("Completed Task")),
                      ElevatedButton(
                        onPressed: () {
                          completeOrNOcompleteTask(
                              taskProvider.completedTask, context);
                          MyNotifications.instance.createNotification(
                              title: 'You Edited Task.. ',
                              body: 'Keep it in your mind..');
                        },
                        child: const Text('Edit'),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void completeOrNOcompleteTask(int isCompleted, BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    _key.currentState?.save();
    taskProvider.updateTask(TaskModel(
      id: taskModel.id,
      note: _noteContoller.text,
      title: _titleController.text,
      isCompleted: isCompleted,
    ));

    Navigator.of(context).pop();
  }
}