part of 'product_model.cubit.dart';

// inProgress could be understood like updating the state from UI, filling the form, fetching, ...
enum Status { initial, inProgress, success, failure }

class ProductModelState extends Equatable {
  final List<ProductModel> list;
  final Status status;

  // default required named constructor
  // inside {} are required named arg, aka you must use the name declared inside {} then assign value to those params
  const ProductModelState({
    required this.list,
    required this.status,
  });

  // default value constructor
  ProductModelState.init()
      : list = <ProductModel>[],
        status = Status.initial;

  ProductModelState copyWith({
    List<ProductModel>? listHere,
    Status? statusHere,
  }) {
    // if (record
    //     case {
    //       "name": String _,
    //       "rowguid": String _,
    //       "modifiedDate": String _,
    //     }) {
    return ProductModelState(
      list: listHere ?? list,
      status: statusHere ?? status,
    );
    // }

    // return ProductModelState.init();
  }

  @override
  List<Object> get props => [list, status];
}
