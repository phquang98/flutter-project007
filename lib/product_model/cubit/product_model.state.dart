part of 'product_model.cubit.dart';

// TODO: need to rethink this, not reflex irl
// TODO: do 2 state, 1 state for the record (for Form, editing, ...); 1 state for the List
// inProgress could be understood like updating the state from UI, filling the form, fetching, ...
enum ResourceStatus { initial, inProgress, success, failure }

class ProductModelState extends Equatable {
  // not a class, cause will be used when user interact (e.g. filling the form) -> not always has required props -> cant create a class
  // -> Map
  final Map<String, dynamic> currentRecord;
  final ResourceStatus resourceStatus;
  final List<ProductModel> productModelList;

  // default required named constructor
  // inside {} are required named arg, aka you must use the name declared inside {} then assign value to those params
  const ProductModelState({
    required this.currentRecord,
    required this.resourceStatus,
    required this.productModelList,
  });

  // default value constructor
  ProductModelState.init()
      : currentRecord = {},
        resourceStatus = ResourceStatus.initial,
        productModelList = <ProductModel>[];

  ProductModelState copyWith({
    Map<String, dynamic>? currentRecordHere,
    ResourceStatus? resourceStatusHere,
    List<ProductModel>? productModelListHere,
  }) {
    // if (currentRecordHere
    //     case {
    //       "name": String _,
    //       "rowguid": String _,
    //       "modifiedDate": String _,
    //     }) {
    return ProductModelState(
      currentRecord: currentRecordHere ?? currentRecord,
      resourceStatus: resourceStatusHere ?? resourceStatus,
      productModelList: productModelListHere ?? productModelList,
    );
    // }

    // return ProductModelState.init();
  }

  @override
  List<Object> get props => [resourceStatus, currentRecord, productModelList];
}
