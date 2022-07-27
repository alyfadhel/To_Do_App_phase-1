import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_phase1/core/util/bloc/bloc.dart';
import 'package:to_do_app_phase1/core/util/bloc/states.dart';

class AllWidget extends StatelessWidget {

   AllWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context).all;
        return Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => buildTaskItem(cubit[index], context),
            separatorBuilder: (context, index) => Divider(
              height: 1.0,
              color: Colors.grey[350],
            ),
            itemCount: cubit.length,
          ),
        );
      },
    );
  }

  Color getColorFrom(String colorStr) {

    String valueString =
    colorStr.split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    return Color(value);
  }

  Widget buildTaskItem(Map model,context)=>Dismissible(
    key: Key(model['id'].toString()),
    onDismissed: (directions)
    {
      AppCubit.get(context).deleteTodoDatabase(id: model['id']);
    },
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomCheckBox(
          value: AppCubit.get(context).checkBoxState == false ? false : true,
          onChanged: (val)
          {
            AppCubit.get(context).upDateTodoDatabase(status: 'completed', id: model['id']);
            AppCubit.get(context).changeCheckBox(val) ;
          },
          shouldShowBorder: false,
          borderColor: getColorFrom(model['color']),
          checkedFillColor: getColorFrom(model['color']),
          borderRadius: 8,
          borderWidth: 1,
          checkBoxSize: 22,

        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            '${model['title']}' ,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
        const Spacer(),
        Row(
          children:
          [
            // IconButton(
            //     onPressed: ()
            //     {
            //       AppCubit.get(context).upDateTodoDatabase(status: 'completed', id: model['id']);
            //     },
            //     icon: const Icon(
            //       Icons.archive_outlined,
            //       color: Colors.red,
            //     ),
            // ),
            IconButton(
                onPressed: ()
                {
                  AppCubit.get(context).upDateTodoDatabase(status: 'uncompleted', id: model['id']);
                },
                icon: const Icon(
                    Icons.unarchive_outlined,
                  color: Colors.red,
                ),
            ),
            IconButton(
                onPressed: ()
                {
                  AppCubit.get(context).upDateTodoDatabase(status: 'favorites', id: model['id']);
                },
                icon: const Icon(
                    Icons.favorite_border_outlined,
                  color: Colors.red,
                ),
            ),
          ],
        ),
      ],
    ),
  );
}




