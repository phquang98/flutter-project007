import 'package:example_repo_layer/data/provider/product_model.provider.dart';
import 'package:example_repo_layer/product_model/models/index.dart';

class ProductModelRepository {
  final ProductModelProvider _productModelProvider;

  ProductModelRepository({ProductModelProvider? productModelProvider})
      : _productModelProvider = productModelProvider ?? ProductModelProvider();

  Future<ProductModel> readOne(int recordId) async {
    final ProductModel record = await _productModelProvider
        .getOne("http://localhost:5164/api/productmodel/$recordId");
    return record;
  }
}
