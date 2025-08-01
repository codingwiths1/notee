import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notee/core/router/app_router.dart';
import 'package:notee/features/note/view_model/note_bloc/note_cubit.dart';

final AppRouter appRouter = AppRouter();

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => NoteCubit())],
      child: ScreenUtilInit(
        designSize: const Size(417, 1024),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp.router(
          theme: ThemeData(useMaterial3: true),
          routerConfig: appRouter.config(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
