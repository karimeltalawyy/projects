import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/modules/counter/cubit/cubit.dart';
import 'package:test_one/modules/counter/cubit/states.dart';
class CounterScreen extends StatelessWidget {




  CounterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>CounterCubit(),
      child: BlocConsumer<CounterCubit,CounterStates>(
        listener: (context,state){
          if(state is CounterInitialState) print('initial state');
          if(state is CounterPlusState) print('Plus state');
          if(state is CounterMinusState) print('Minus state');
        },
          builder: (context,state){return Scaffold(
            appBar: AppBar(
              title: const Text('Counter'),
              backgroundColor: Colors.green,
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: const Color.fromARGB(255, 6, 80, 12),
                    child: TextButton(
                      onPressed: () {
                        CounterCubit.get(context).minus();
                      },
                      child: const Text(
                        'MINUS',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      '${CounterCubit.get(context).counter}',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  Container(
                    color: const Color.fromARGB(255, 6, 80, 12),
                    child: TextButton(
                      onPressed: () {
                        CounterCubit.get(context).plus();
                      },
                      child: const Text(
                        'PLUS',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );},

      ),
    );
  }
}


