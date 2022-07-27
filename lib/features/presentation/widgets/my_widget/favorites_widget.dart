import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_phase1/core/util/bloc/bloc.dart';
import 'package:to_do_app_phase1/core/util/bloc/states.dart';

class FavoritesWidget extends StatelessWidget {
  final bool shouldCheck;
  final bool shouldCheckDefault;
  const FavoritesWidget({
    Key? key,
    this.shouldCheck = false,
    this.shouldCheckDefault = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        var cubit = AppCubit.get(context).favorites;
        return Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => buildFavoriteItem(cubit[index]),
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

  Widget buildFavoriteItem(Map model) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // CustomCheckBox(
      //   value: shouldCheck,
      //   onChanged: (val) {},
      //   shouldShowBorder: true,
      //   borderColor: Colors.red,
      //   checkedFillColor: Colors.red,
      //   borderRadius: 8,
      //   borderWidth: 1,
      //   checkBoxSize: 22,
      // ),
       Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          '${model['title']}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
      const Spacer(),
    ],
  );
}
