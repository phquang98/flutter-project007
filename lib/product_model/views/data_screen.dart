// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:example_repo_layer/product_model/cubit/product_model.cubit.dart';

// enum WidgetKind { get, post, put, delete }

// class DataScreen extends StatefulWidget {
//   const DataScreen({super.key, required this.indexWidget});

//   final WidgetKind indexWidget;

//   @override
//   State<DataScreen> createState() => _DataScreenState();
// }

// class _DataScreenState extends State<DataScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final productModelIDCtrl = TextEditingController();
//   final nameCtrl = TextEditingController();
//   final catalogDescriptionCtrl = TextEditingController();
//   final rowGuIDCtrl = TextEditingController();
//   final modifiedDateCtrl = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     // Implement some initialization operations here.
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     nameCtrl.dispose();
//     catalogDescriptionCtrl.dispose();
//     rowGuIDCtrl.dispose();
//     modifiedDateCtrl.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;

//     return BlocConsumer<ProductModelCubit, ProductModelState>(
//       // not called at the initial state https://bloclibrary.dev/flutter-bloc-concepts/#bloclistener
//       listener: (context, state) {
//         if (state.status == Status.inProgress) {
//           log("In progress...");
//           log("In listener, data List length: ${state.list.length}");
//         }
//         if (state.status == Status.success) {
//           log("Operation successful...");
//           if (state.list.length == 1) {
//             final snackBar = SnackBar(
//               content: Text("getOne success: ${state.list[0].name}"),
//             );
//             ScaffoldMessenger.of(context).showSnackBar(snackBar);
//           }
//           if (state.list.length > 1) {
//             final snackBar = SnackBar(
//               content: Text("getAll success: ${state.list.length}"),
//             );
//             ScaffoldMessenger.of(context).showSnackBar(snackBar);
//           }
//         }
//         if (state.status == Status.failure) {
//           log("Operation failed...");
//         }
//       },
//       builder: (context, state) {
//         return switch (widget.indexWidget) {
//           WidgetKind.get => const Text("This is the 1st screen"),
//           WidgetKind.post => const Text("This is the 2nd screen"),
//           WidgetKind.put => const Text("This is the 3rd screen"),
//           WidgetKind.delete => const Text("This is the 4th screen")
//         };
//       },
//     );
//   }
// }
