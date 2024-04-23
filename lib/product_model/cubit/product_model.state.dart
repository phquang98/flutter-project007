part of 'product_model.cubit.dart';

// TODO: need to rethink this, not reflex irl
// loading could be understood like updating the state from UI, fetching, ...
enum ResourceStatus { initial, loading, success, failure }

class ProductModelState extends Equatable {
  // storage var pointing to the currently used instance (e.g for a Form, ...)
  final Map<String, dynamic> currentRecord;
  final ResourceStatus resourceStatus;
  final List<ProductModel> productModelList;

  const ProductModelState(
    this.currentRecord, {
    this.resourceStatus = ResourceStatus.initial,
    this.productModelList = const <ProductModel>[],
  });

  // const ProductModelState({
  //   this.currentRecord  ,
  //   this.resourceStatus = ResourceStatus.initial,
  //   this.productModelList = const <ProductModel>[],
  // });

  // this used named param -> when call, must provide 2 args named like defined here
  // FYI,
  ProductModelState copyWith({
    Map<String, dynamic>? currentRecordHere,
    ResourceStatus? resourceStatusHere,
    List<ProductModel>? productModelListHere,
  }) {
    return ProductModelState(
      currentRecordHere ?? currentRecord,
      resourceStatus: resourceStatusHere ?? resourceStatus,
      productModelList: productModelListHere ?? productModelList,
    );
  }

  @override
  List<Object> get props => [resourceStatus, currentRecord, productModelList];
}
