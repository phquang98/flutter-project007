import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:example_repo_layer/product_model/cubit/product_model.cubit.dart';

class ResourceScreen extends StatefulWidget {
  const ResourceScreen({super.key});

  @override
  State<ResourceScreen> createState() => _ResourceScreenState();
}

class _ResourceScreenState extends State<ResourceScreen> {
  final _formKey = GlobalKey<FormState>();

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

    return BlocConsumer<ProductModelCubit, ProductModelState>(
      // not called at the initial state https://bloclibrary.dev/flutter-bloc-concepts/#bloclistener
      listener: (context, state) {
        if (state.resourceStatus == ResourceStatus.inProgress) {
          log("filling...");
          log("in listener + progress: ${state.currentRecord}");
        }
        if (state.resourceStatus == ResourceStatus.success) {
          log("have data...");
          if (state.productModelList.length == 1) {
            final snackBar = SnackBar(
              content:
                  Text("getOne success: ${state.productModelList[0].name}"),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state.productModelList.length > 1) {
            final snackBar = SnackBar(
              content: Text("getAll success: ${state.productModelList.length}"),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
        if (state.resourceStatus == ResourceStatus.failure) {
          log("failed...");
          final snackBar = SnackBar(
            content: Text(state.productModelList[0].name),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      // this builder should be as pure as possible
      builder: (context, state) {
        if (state.resourceStatus == ResourceStatus.initial) {
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
                height: 400,
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
                          decoration: const InputDecoration(
                            hintText: 'This input will be disabled.',
                            labelText: 'productModelID',
                          ),
                          keyboardType: TextInputType.phone,
                          // onSaved: (newValue) {},
                          readOnly: true,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
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
                          controller: catalogDescriptionCtrl,
                          decoration: const InputDecoration(
                            hintText:
                                'Catalogue description of the product model.',
                            labelText: 'catalogDescription',
                          ),
                          keyboardType: TextInputType.phone,
                          // onSaved: (newValue) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
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
                          controller: rowGuIDCtrl,
                          decoration: const InputDecoration(
                            hintText: 'Row GUID of the product model.',
                            labelText: 'rowguid',
                          ),
                          keyboardType: TextInputType.phone,
                          // onSaved: (newValue) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
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
                          controller: modifiedDateCtrl,
                          decoration: const InputDecoration(
                            hintText: 'Modified date of the product model.',
                            labelText: 'modifiedDate',
                          ),
                          keyboardType: TextInputType.phone,
                          // onSaved: (newValue) {},
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                      // ---
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState
                              case FormState formKeyCurrentState?) {
                            if (formKeyCurrentState.validate()) {
                              final tmpOne = nameCtrl.text;

                              final finalForm = {
                                "name": tmpOne,
                                "catalogDescription": null,
                                "rowguid":
                                    "9155e5b2-f52d-4e33-b660-d85a208c0c4b",
                                "modifiedDate": "2024-01-01",
                              };

                              context
                                  .read<ProductModelCubit>()
                                  .createOne(data: finalForm);

                              // formKeyCurrentState
                              //     .save(); // call onSave on all possible TextFieldForm
                              // TODO: call onDynamicSubmit here, like http.post
                            }
                          }
                        },
                        child: const Text('Submit'),
                      ),
                      // TODO: only switch expression exist, no if expression
                      // Loi logic: code nay thuc thi truoc -> khong co data -> error
                      // Text('Data o day: ${state.productModelList[0].name}'),
                      switch ((
                        state.resourceStatus,
                        state.productModelList.length
                      )) {
                        (ResourceStatus.success, == 1) =>
                          Text('Data o day: ${state.productModelList[0].name}'),
                        _ => const Text('Chua co data, hoi cai loz me may ???'),
                      }
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
    );
  }
}
