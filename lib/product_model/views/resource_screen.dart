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
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Implement some initialization operations here.
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<ProductModelCubit, ProductModelState>(
      listener: (context, state) {
        if (state.resourceStatus == ResourceStatus.initial) {
          log("watching...");
          context.read<ProductModelCubit>().fetchOne(recordId: 10);
        }
        if (state.resourceStatus == ResourceStatus.loading) {
          log("Filling data...");
        }
      },
      // this builder should be as pure as possible
      builder: (context, state) {
        if (state.resourceStatus == ResourceStatus.initial) {
          log("watching...");
          context.read<ProductModelCubit>().fetchOne(recordId: 10);
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
                      SizedBox(
                        height: 80,
                        child: TextFormField(
                          controller: nameController,
                          // initialValue: "test",
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
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState
                              case FormState formKeyCurrentState) {
                            if (formKeyCurrentState.validate()) {
                              final tmpOne = nameController.text;

                              context
                                  .read<ProductModelCubit>()
                                  .updateByChange({"name": tmpOne}, []);

                              log("em yeu oi: ${state.currentRecord["name"]}");

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
                      switch (state.productModelList.length) {
                        == 1 =>
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
