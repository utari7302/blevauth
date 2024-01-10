import 'package:blevauth/bloc/auth_bloc.dart';
import 'package:blevauth/bloc/auth_event.dart';
import 'package:blevauth/bloc/auth_state.dart';
import 'package:blevauth/login_screen.dart';
import 'package:blevauth/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //final authState = context.watch<AuthBloc>().state as AuthSuccess; //With this approach unnecessary component will also run
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc,AuthState>(
        listener: (context, state) {
          if(state is AuthInitial){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen(),), (route) => false);
          }
        },
        builder: (context, state) {
          if(state is AuthLoading){
            return const Center(child: CircularProgressIndicator(),);
          }
          return Center(
            child: Column(
              children: [
                Center(
                  child: Text((state as AuthSuccess).uid),
                ),
                GradientButton(onPressed: () {
                  context.read<AuthBloc>().add(AuthLogOutRequested());
                },)
              ],
            ),
          );
        },

      ),
    );
  }
}
