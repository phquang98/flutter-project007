import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int? productModelID;
  final String name;
  final String? catalogDescription;
  final String rowguid;
  final String modifiedDate;

  // generative constructor
  const ProductModel(
    this.productModelID,
    this.name,
    this.rowguid,
    this.modifiedDate,
  ) : catalogDescription = null;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          "productModelID": int localProductModelID,
          "name": String localName,
          "rowguid": String localRowguid,
          "modifiedDate": String localModifiedDate
        }) {
      return ProductModel(
          localProductModelID, localName, localRowguid, localModifiedDate);
    } else {
      throw const FormatException('Unexpected JSON format');
    }
  }

  // TODO: remove all except ID cause redundant ?
  @override
  List<Object?> get props =>
      [productModelID, name, catalogDescription, rowguid, modifiedDate];
}
