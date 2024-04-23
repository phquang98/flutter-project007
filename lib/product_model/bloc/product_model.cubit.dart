import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:example_repo_layer/product_model/models/index.dart';
import 'package:example_repo_layer/product_model/bloc/product_model.state.dart';
import 'package:example_repo_layer/data/repositories/product_model.repository.dart';

class ProductModelCubit extends Cubit<ProductModelState> {
  ProductModelCubit({
    ProductModelRepository? productModelRepository,
  })  : _productModelRepository =
            productModelRepository ?? ProductModelRepository(),
        super(const ProductModelState({}));

  final ProductModelRepository _productModelRepository;

  Future<void> fetchOne({required int recordId}) async {
    emit(state.copyWith(resourceStatusHere: ResourceStatus.loading));

    // TODO: trycatch here, or inside repo filee
    final cac = await _productModelRepository.readOne(recordId);

    // Create a copy of the existing list and add the new element
    List<ProductModel> cacList = List.from(state.productModelList)..add(cac);

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
    log("clgt: ${record}");
    emit(state.copyWith(
      currentRecordHere: record,
      resourceStatusHere: ResourceStatus.loading,
      productModelListHere: productModelList,
    ));
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
