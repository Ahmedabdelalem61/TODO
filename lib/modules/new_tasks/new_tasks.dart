import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_todo/shared/components/component.dart';
import 'package:task_todo/shared/components/constants.dart';
import 'package:task_todo/shared/cubit/cubit.dart';
import 'package:task_todo/shared/cubit/cubitStates.dart';

class NewTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        var tasks = AppCubit
            .get(context)
            .tasks;
        return ListView.separated(
            itemBuilder: (context, index) => WidgetBuildTaskItem(tasks[index]),
            separatorBuilder: (context, index) =>
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Divider(
                    color: Colors.grey[400],
                  ),
                ),
            itemCount: tasks.length);
      },
    );
  }
}


