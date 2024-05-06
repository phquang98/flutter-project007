import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:example_repo_layer/product_model/views/resource_screen.dart';
import 'package:example_repo_layer/product_model/cubit/product_model.cubit.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: <BlocProvider<dynamic>>[
          BlocProvider<ProductModelCubit>(
            create: (BuildContext context) => ProductModelCubit(),
          ),
        ],
        child: const ResourceScreen(),
      ),
    );
  }
}
