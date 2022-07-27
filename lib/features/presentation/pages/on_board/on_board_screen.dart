import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app_phase1/core/util/bloc/bloc.dart';
import 'package:to_do_app_phase1/core/util/bloc/states.dart';
import 'package:to_do_app_phase1/features/presentation/pages/add_task/add_task.dart';
import 'package:to_do_app_phase1/features/presentation/pages/schedule/schedule_screen.dart';
import 'package:to_do_app_phase1/features/presentation/widgets/my_button.dart';
import 'package:to_do_app_phase1/features/presentation/widgets/my_widget/all_widget.dart';
import 'package:to_do_app_phase1/features/presentation/widgets/my_widget/completed_widget.dart';
import 'package:to_do_app_phase1/features/presentation/widgets/my_widget/favorites_widget.dart';
import 'package:to_do_app_phase1/features/presentation/widgets/my_widget/uncompleted_widget.dart';

bool value = false;

class OnBoardScreen extends StatelessWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Board',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.black,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: ()
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScheduleScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                  ),
                ),
              ],
              bottom: const TabBar(
                indicatorColor: Colors.black,
                labelPadding: EdgeInsets.zero,
                tabs:
                [
                  Tab(
                    text: 'All',

                  ),
                  Tab(
                    text: 'Completed',

                  ),
                  Tab(
                    text: 'Uncompleted',
                  ),
                  Tab(
                    text: 'Favorites',

                  ),
                ],
              ),
            ),
            body:  TabBarView(
              children:
              [
                Column(
                  children:
                  [
                    AllWidget(),
                    MyButton(
                      isUpperCase: false,
                      text: 'Add a task',
                      onPressedButton: ()
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddTask(),
                          ),
                        );
                      },
                      radius: 10.0,
                      style: const TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
                Column(
                  children:   const [
                    CompletedWidget(),
                  ],
                ),
                Column(
                  children:   const [
                    UncompletedWidget(),
                  ],
                ),
                Column(
                  children:   const [
                    FavoritesWidget(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
