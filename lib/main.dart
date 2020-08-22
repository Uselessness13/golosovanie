import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:jkh/auth/index.dart';
import 'package:jkh/login/index.dart';
import 'package:jkh/utils/snacks.dart';
import 'voting/index.dart';

const String ROOT_URL = 'http://192.168.0.109:443';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GOловосание',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        // backgroundColor: Colors.blue[100],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(UnAuthState()),
          ),
          BlocProvider(
            create: (context) => SnackBarsCubit(),
          ),
        ],
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SnackBarsCubit, String>(
      cubit: BlocProvider.of<SnackBarsCubit>(context),
      listener: (BuildContext context, state) {
        Get.snackbar(state, '',
            isDismissible: true, snackPosition: SnackPosition.BOTTOM);
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is UnAuthState) {
            return LoginPage();
          }
          if (state is InAuthState) {
            return MultiBlocProvider(providers: [
              BlocProvider<VotingCubit>(
                  create: (context) => VotingCubit()..loadAllVotings())
            ], child: VotingPage());
          }
        },
      ),
    );
  }
}
