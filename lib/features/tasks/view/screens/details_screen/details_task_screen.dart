
import 'package:flutter/material.dart';
import 'package:to_do_app/features/tasks/view/screens/details_screen/widgets/details_body_widget.dart';

import '../../../data/model/task_model.dart';
import 'widgets/details_header_widget.dart';

class DetailsTaskScreen extends StatelessWidget {
  final TaskModel taskModel;
  DetailsTaskScreen({Key? key, required this.taskModel}) : super(key: key);

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _key.currentState?.save();
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _key,
        child: Column(
          children: [
            DetailsHeaderWidget(taskModel: taskModel),
            DetailsBodyWidget(taskModel: taskModel),
          ],
        ),
      ),
    );
  }
}