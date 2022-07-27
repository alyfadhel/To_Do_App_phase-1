import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:to_do_app_phase1/core/util/bloc/bloc.dart';
import 'package:to_do_app_phase1/core/util/bloc/observer.dart';
import 'package:to_do_app_phase1/core/util/bloc/states.dart';
import 'package:to_do_app_phase1/features/presentation/pages/notification_services.dart';
import 'package:to_do_app_phase1/features/presentation/pages/on_board/on_board_screen.dart';
import 'package:to_do_app_phase1/features/presentation/widgets/styles/themes.dart';

void main()async
{
  WidgetsFlutterBinding.ensureInitialized();
  NotifyHelper().initializeNotification();
  BlocOverrides.runZoned(
        () {
          runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (context) => AppCubit()..initDatabase(),),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home: const OnBoardScreen(),
          );
        },
      ),
    );
  }
}

