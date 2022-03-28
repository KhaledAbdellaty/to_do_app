
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/database/database_provider.dart';
import 'package:to_do_app/model/task_model.dart';
import 'package:to_do_app/providers/notification_provider.dart';
import 'package:to_do_app/providers/theme_provider.dart';

class TaskDetails extends StatefulWidget {
  TaskModel taskModel;


  TaskDetails({Key? key, required this.taskModel}) : super(key: key);

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  int _completed = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<NotificationProvider>(
            builder: (context,notify,child){return InkWell(
              onTap: (){
                editUser(widget.taskModel.id!);
                notify.showNotification(title: 'Edit Done', body: 'Keep it in your mind');
                Navigator.of(context).pop();
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.done,size: 30,),
              ),
            );},
          ),
        ],
      ),
      body: Form(
        key: _key,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.access_time_outlined,
                        color: widget.taskModel.color == 0 ? theme.isDark?Colors.white:Colors.indigo
                            : widget.taskModel.color == 1 ? theme.isDark?Colors.white:Colors.pink
                            :theme.isDark?Colors.white:Colors.deepPurple,),
                      const SizedBox(width: 10,),
                      Text('Start in : ${widget.taskModel.startTime}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.access_time_outlined,
                        color: widget.taskModel.color == 0 ? theme.isDark?Colors.white:Colors.indigo
                            : widget.taskModel.color == 1 ? theme.isDark?Colors.white:Colors.pink
                            :theme.isDark?Colors.white:Colors.deepPurple,),
                      const SizedBox(width: 10,),
                      Text('End in : ${widget.taskModel.endTime}',style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    ],
                  ),

                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.date_range,
                  color: widget.taskModel.color == 0 ? theme.isDark?Colors.white:Colors.indigo
                      : widget.taskModel.color == 1 ? theme.isDark?Colors.white:Colors.pink
                      :theme.isDark?Colors.white:Colors.deepPurple,),
                const SizedBox(width: 10,),
                Text('In Date : ${widget.taskModel.date}',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),

              ],
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: Center(
                 child: Container(
                   width: 350,
                    height: 550,
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: widget.taskModel.color == 0 ? Colors.indigo
                          : widget.taskModel.color == 1 ? Colors.pink
                          : Colors.deepPurple,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Hello Khaled !',style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold,color: Colors.white),),
                          const SizedBox(height: 10,),
                          Text(widget.taskModel.isCompleted == 1 ?'You Already Done It..':'You Can Do It',
                          style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                          const SizedBox(height: 10,),
                          multiTitleTextField(),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: multiNoteTextField(),
                          ),
                          Consumer<NotificationProvider>(
                            builder: (context,provider,child){return ElevatedButton(onPressed: (){
                              setState(() {
                                _completed =1;
                              });
                              provider.showNotification(title: 'Congratulation', body: 'You complete this task');
                              print(_completed );
                            }, child: const Text("Completed Task"));},

                          )
                        ],
                      ),
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

  multiNoteTextField() {
    return TextFormField(
      initialValue: widget.taskModel.note,
      minLines: 1,
      maxLines: 20,
      cursorColor: Colors.white,
      keyboardType: TextInputType.multiline,
      onSaved: (value){
        _noteController.text = value!;
      },
      style: TextStyle(
        color: Colors.grey[300],
        fontSize: 18,
        fontWeight: FontWeight.w600

      ),
      decoration: InputDecoration(
          label: const Text('Note'),
          labelStyle: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color:  Colors.white
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color:Colors.white
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color:  Colors.white ,
            ),
            borderRadius: BorderRadius.circular(15),
          )),
    );
  }

  multiTitleTextField() {
    return TextFormField(
      initialValue: widget.taskModel.title,
      minLines: 1,
      maxLines: 3,
      onSaved: (value){
        _titleController.text = value!;
      },
      keyboardType: TextInputType.multiline,
      style: const TextStyle(
          color: Colors.white,
          fontSize: 21,
          fontWeight: FontWeight.w600
      ),
      decoration: InputDecoration(
          label:const  Text('Title'),
        labelStyle: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color:  Colors.white
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color:Colors.white
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color:  Colors.white ,
            ),
            borderRadius: BorderRadius.circular(15),
          )),
    );
  }

  editUser(int id) {
    _key.currentState?.save();
    DatabaseProvider.instance.updateOneTask(TaskModel(
      id: id,
      note: _noteController.text,
      title: _titleController.text,
      isCompleted: _completed,
    ));
  }
}
