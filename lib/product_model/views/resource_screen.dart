import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:example_repo_layer/product_model/cubit/product_model.cubit.dart';

enum WidgetKind { get, post, put, delete }

class ResourceScreen extends StatefulWidget {
  const ResourceScreen({super.key});

  @override
  State<ResourceScreen> createState() => _ResourceScreenState();
}

class _ResourceScreenState extends State<ResourceScreen> {
  final _formKey = GlobalKey<FormState>();
  WidgetKind kind = WidgetKind.get; // state to know which tab is being pressed

  final productModelIDCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final catalogDescriptionCtrl = TextEditingController();
  final rowGuIDCtrl = TextEditingController();
  final modifiedDateCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Implement some initialization operations here.
  }

  void _onItemTapped(WidgetKind kindHere) {
    setState(() {
      kind = kindHere;
      productModelIDCtrl.clear();
      nameCtrl.clear();
      catalogDescriptionCtrl.clear();
      rowGuIDCtrl.clear();
      modifiedDateCtrl.clear();
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameCtrl.dispose();
    catalogDescriptionCtrl.dispose();
    rowGuIDCtrl.dispose();
    modifiedDateCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("This is the appbar"),
      ),
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
          // borderRadius: BorderRadius.only(
          //       topRight: Radius.circular(20),
          //       bottomRight: Radius.circular(20)),
        ),
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Get'),
              // selected: _selectedDrawer == 0,
              onTap: () {
                _onItemTapped(WidgetKind.get);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Post'),
              // selected: _selectedDrawer == 1,
              onTap: () {
                _onItemTapped(WidgetKind.post);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Put'),
              // selected: _selectedDrawer == 1,
              onTap: () {
                // _onItemTapped(WidgetKind.put);
                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Delete'),
              // selected: _selectedDrawer == 1,
              onTap: () {
                // _onItemTapped(WidgetKind.delete);
                // Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: BlocConsumer<ProductModelCubit, ProductModelState>(
          // not called at the initial state https://bloclibrary.dev/flutter-bloc-concepts/#bloclistener
          listener: (context, state) {
            if (state.status == Status.inProgress) {
              log("In progress...");
              log("In listener, data List length: ${state.list.length}");
            }
            if (state.status == Status.success) {
              log("Operation successful...");
              if (state.list.length == 1) {
                final snackBar = SnackBar(
                  content: Text("getOne success: ${state.list[0].name}"),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              if (state.list.length > 1) {
                final snackBar = SnackBar(
                  content: Text("getAll success: ${state.list.length}"),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }
            if (state.status == Status.failure) {
              log("Operation failed...");
            }
          },
          // this builder should be as pure as possible
          builder: (context, state) {
            if (state.status == Status.initial) {
              log("watching...");
              // context.read<ProductModelCubit>().fetchOne(recordId: 10);
              // context.read<ProductModelCubit>().fetchAll();
            }

            return Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: SizedBox(
                    width: screenWidth * 0.4,
                    height: 600,
                    // child: const Text('Testing...')
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // wrap this in SizedBox to prevent jumping height if error validating
                          // ---
                          SizedBox(
                            height: 80,
                            child: TextFormField(
                              // initialValue must be null when this isn't
                              // controller: nameCtrl,
                              controller: productModelIDCtrl,
                              decoration: const InputDecoration(
                                hintText: 'This input will be disabled.',
                                labelText: 'productModelID',
                              ),
                              keyboardType: TextInputType.phone,
                              // onSaved: (newValue) {},
                              readOnly: kind == WidgetKind.get ? false : true,
                              validator: (value) {
                                if (kind == WidgetKind.get) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                }

                                return null;
                              },
                            ),
                          ),
                          // ---
                          SizedBox(
                            height: 80,
                            child: TextFormField(
                              // initialValue must be null when this isn't
                              controller: nameCtrl,
                              decoration: const InputDecoration(
                                hintText: 'Name of the product model.',
                                labelText: 'name',
                              ),
                              keyboardType: TextInputType.phone,
                              // onSaved: (newValue) {},
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Please enter some text';
                              //   }
                              //   return null;
                              // },
                            ),
                          ),
                          // ---
                          SizedBox(
                            height: 80,
                            child: TextFormField(
                              // initialValue must be null when this isn't
                              controller: catalogDescriptionCtrl,
                              decoration: const InputDecoration(
                                hintText:
                                    'Catalogue description of the product model.',
                                labelText: 'catalogDescription',
                              ),
                              keyboardType: TextInputType.phone,
                              // onSaved: (newValue) {},
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Please enter some text';
                              //   }
                              //   return null;
                              // },
                            ),
                          ),
                          // ---
                          SizedBox(
                            height: 80,
                            child: TextFormField(
                              // initialValue must be null when this isn't
                              controller: rowGuIDCtrl,
                              decoration: const InputDecoration(
                                hintText: 'Row GUID of the product model.',
                                labelText: 'rowguid',
                              ),
                              keyboardType: TextInputType.phone,
                              // onSaved: (newValue) {},
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Please enter some text';
                              //   }
                              //   return null;
                              // },
                            ),
                          ),
                          // ---
                          SizedBox(
                            height: 80,
                            child: TextFormField(
                              // initialValue must be null when this isn't
                              controller: modifiedDateCtrl,
                              decoration: const InputDecoration(
                                hintText: 'Modified date of the product model.',
                                labelText: 'modifiedDate',
                              ),
                              keyboardType: TextInputType.phone,
                              // onSaved: (newValue) {},
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Please enter some text';
                              //   }
                              //   return null;
                              // },
                            ),
                          ),

                          // NOTE: what kind of writing logic is this ???
                          if (kind == WidgetKind.get)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                              child: ElevatedButton(
                                onPressed: () {
                                  context.read<ProductModelCubit>().fetchAll();
                                },
                                child: const Text('Get All'),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState
                                    case FormState formKeyCurrentState?) {
                                  if (formKeyCurrentState.validate()) {
                                    final tmpOne = productModelIDCtrl.text;

                                    context
                                        .read<ProductModelCubit>()
                                        .fetchOne(recordId: tmpOne);
                                  }
                                }
                              },
                              child: const Text('Get One'),
                            ),
                          ),

                          if (kind == WidgetKind.delete)
                            ElevatedButton(
                              onPressed: () {
                                context.read<ProductModelCubit>().fetchAll();
                              },
                              child: const Text('DeleteOne'),
                            ),

                          // ElevatedButton(
                          //   onPressed: () {
                          //     if (_formKey.currentState
                          //         case FormState formKeyCurrentState?) {
                          //       if (formKeyCurrentState.validate()) {
                          //         final tmpOne = nameCtrl.text;

                          //         final finalForm = {
                          //           "name": tmpOne,
                          //           "catalogDescription": null,
                          //           "rowguid":
                          //               "9155e5b2-f52d-4e33-b660-d85a208c0c4b",
                          //           "modifiedDate": "2024-01-01",
                          //         };

                          //         context
                          //             .read<ProductModelCubit>()
                          //             .createOne(data: finalForm);

                          //         // formKeyCurrentState
                          //         //     .save(); // call onSave on all possible TextFieldForm
                          //         // TODO: call onDynamicSubmit here, like http.post
                          //       }
                          //     }
                          //   },
                          //   child: const Text('Submit'),
                          // ),
                          // TODO: only switch expression exist, no if expression
                          // Loi logic: code nay thuc thi truoc -> khong co data -> error
                          // Text('Data o day: ${state.productModelList[0].name}'),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                            child: switch ((state.status, state.list.length)) {
                              (Status.success, == 1) =>
                                Text('Data o day: ${state.list[0].name}'),
                              (Status.success, > 1) =>
                                Text('GetAll OK. Length: ${state.list.length}'),
                              _ => const Text('Chua co data!'),
                            },
                          ),
                        ],
                      ),
                    ),

                    // child: FutureBuilder(
                    //   future: apiData,
                    //   builder: (context, snapshot) {
                    //     if (snapshot.hasData) {
                    //       if (snapshot.data case final GCS snapshotData?) {
                    //         return DemoForm(
                    //           initialRecord: snapshotData,
                    //           onDynamicSubmit: (GCS dataFromChildren) {
                    //             log("Data will be sent to API: $dataFromChildren");
                    //             log("Smaller example: ${dataFromChildren.hOTEN} + ${dataFromChildren.mADVIQLY} + ${dataFromChildren.maNVIEN}");
                    //             // http.post() here
                    //           },
                    //         );
                    //       }
                    //     } else if (snapshot.hasError) {
                    //       if (snapshot.error case final snapshotErr?) {
                    //         return Text('Error is: $snapshotErr');
                    //       }
                    //     }

                    //     return const CircularProgressIndicator();
                    //   },
                    // ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
