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

  Future<void> fetchAll() async {
    emit(state.copyWith(statusHere: Status.inProgress, listHere: []));

    final queryRes = await _productModelRepository.readAll();

    if (queryRes case List tmp when tmp.isNotEmpty) {
      emit(
        state.copyWith(
          listHere: queryRes,
          statusHere: Status.success,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        listHere: [],
        statusHere: Status.failure,
      ),
    );
  }

  Future<void> fetchOne({required String recordId}) async {
    emit(state.copyWith(statusHere: Status.inProgress, listHere: []));

    final queryRes = await _productModelRepository.readOne(recordId);

    // Error handling
    if (queryRes case ProductModel tmp
        when tmp.productModelID == 0 ||
            tmp.productModelID == -1 ||
            tmp.productModelID == -2) {
      emit(
        state.copyWith(
          listHere: [queryRes],
          statusHere: Status.failure,
        ),
      );
      return;
    }

    // create a new copy of the existing list and add the new element
    List<ProductModel> newList = List.from(state.list)..add(queryRes);

    emit(
      state.copyWith(
        listHere: newList,
        statusHere: Status.success,
      ),
    );
    return;
  }

  // TODO: combine with returns value
  Future<void> createOne({required Map<String, dynamic> data}) async {
    emit(state.copyWith(statusHere: Status.inProgress, listHere: []));

    final queryRes = await _productModelRepository.createOne(data);

    if (queryRes == 0) {
      emit(
        state.copyWith(
          statusHere: Status.success,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        statusHere: Status.failure,
      ),
    );
    return;
  }

  Future<void> updateOne({required Map<String, dynamic> data}) async {
    emit(state.copyWith(statusHere: Status.inProgress, listHere: []));

    final queryRes = await _productModelRepository.updateOne(data);

    if (queryRes == 0) {
      emit(
        state.copyWith(
          statusHere: Status.success,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        statusHere: Status.failure,
      ),
    );
    return;
  }

  Future<void> deleteOne({required String recordId}) async {
    emit(state.copyWith(statusHere: Status.inProgress, listHere: []));

    final queryRes = await _productModelRepository.deleteOne(recordId);

    if (queryRes == 0) {
      emit(
        state.copyWith(
          statusHere: Status.success,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        statusHere: Status.failure,
      ),
    );
    return;
  }

  // name should represent the action connecting between the data layer and the presentation layer
}
