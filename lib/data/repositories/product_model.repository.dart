import 'package:example_repo_layer/data/provider/index.dart';
import 'package:example_repo_layer/product_model/models/index.dart';

/// Wrapper of provider/client API, used by business logic layer
///
/// This class combines methods from provider/client API to solve requirements from business logic layer \
/// E.g. If my API is a black box with Employee and Payroll table, and I want average salary with name, I can combine those 2 queries and reduce them, wrap it under a method in here
class ProductModelRepository {
  final ProductModelProvider _productModelProvider;
  static const String _baseUrl = "http://localhost:5164/api/productmodel";

  ProductModelRepository({
    ProductModelProvider? productModelProvider,
  }) : _productModelProvider = productModelProvider ?? ProductModelProvider();

  Future<List<ProductModel>> readAll() async {
    final List<ProductModel> clt = await _productModelProvider.getAll(_baseUrl);
    return clt;
  }

  Future<ProductModel> readOne(int recordId) async {
    final ProductModel record =
        await _productModelProvider.getOne("$_baseUrl/$recordId");
    return record;
  }
}
