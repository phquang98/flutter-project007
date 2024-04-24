import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:example_repo_layer/data/repositories/index.dart';
import 'package:example_repo_layer/product_model/models/index.dart';

part 'product_model.state.dart';

class ProductModelCubit extends Cubit<ProductModelState> {
  ProductModelCubit({
    ProductModelRepository? productModelRepository,
  })  : _productModelRepository =
            productModelRepository ?? ProductModelRepository(),
        super(ProductModelState.init());

  final ProductModelRepository _productModelRepository;

  Future<void> fetchOne({required int recordId}) async {
    emit(state.copyWith(resourceStatusHere: ResourceStatus.inProgress));

    // already trycatch in provider/client API layer
    final queryRes = await _productModelRepository.readOne(recordId);

    // create a copy of the existing list and add the new element
    List<ProductModel> cacList = List.from(state.productModelList)
      ..add(queryRes);

    emit(state.copyWith(
      resourceStatusHere: ResourceStatus.success,
      productModelListHere: cacList,
    ));
  }

  /// Reflect changes affected by live editing on the UI (e.g. fill in input forms, ...)
  void updateByChange(
    Map<String, dynamic> record,
    List<ProductModel>? productModelList,
  ) {
    emit(state.copyWith(
      currentRecordHere: record,
      resourceStatusHere: ResourceStatus.inProgress,
      productModelListHere: productModelList,
    ));
    // log("why: $record");
    // log("why: ${state.currentRecord}");
  }

  void reset() {
    emit(state.copyWith(
      currentRecordHere: {},
      resourceStatusHere: ResourceStatus.initial,
      productModelListHere: [],
    ));
  }

  // name should represent the action connecting between the data layer and the presentation layer
}
