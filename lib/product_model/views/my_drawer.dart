// import 'package:example_repo_layer/product_model/views/data_screen.dart';
// import 'package:example_repo_layer/product_model/views/resource_screen.dart';
// import 'package:flutter/material.dart';

// class MyDrawer extends StatefulWidget {
//   const MyDrawer({super.key});

//   @override
//   State<MyDrawer> createState() => _MyDrawerState();
// }

// class _MyDrawerState extends State<MyDrawer> {
//   WidgetKind indexWidget = WidgetKind.get;

//   @override
//   void initState() {
//     super.initState();
//     // Implement some initialization operations here.
//   }

//   void _onItemTapped(WidgetKind kind) {
//     setState(() {
//       indexWidget = kind;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:
//           AppBar(title: Text("This is the appbar kind: ${indexWidget.name}")),
//       body: Center(
//         child: ResourceScreen(indexWidget: indexWidget),
//       ),
//       drawer: Drawer(
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(0)),
//           // borderRadius: BorderRadius.only(
//           //       topRight: Radius.circular(20),
//           //       bottomRight: Radius.circular(20)),
//         ),
//         child: ListView(
//           padding: const EdgeInsets.all(0),
//           children: [
//             const DrawerHeader(
//               decoration: BoxDecoration(color: Colors.blue),
//               child: Text('Drawer Header'),
//             ),
//             ListTile(
//               title: const Text('Get'),
//               // selected: _selectedDrawer == 0,
//               onTap: () {
//                 _onItemTapped(WidgetKind.get);
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               title: const Text('Post'),
//               // selected: _selectedDrawer == 1,
//               onTap: () {
//                 _onItemTapped(WidgetKind.post);
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               title: const Text('Put'),
//               // selected: _selectedDrawer == 1,
//               onTap: () {
//                 _onItemTapped(WidgetKind.put);
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               title: const Text('Delete'),
//               // selected: _selectedDrawer == 1,
//               onTap: () {
//                 _onItemTapped(WidgetKind.delete);
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
