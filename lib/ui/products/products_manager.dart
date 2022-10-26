import 'package:flutter/foundation.dart';

import '../../models/product.dart';
import '../../models/auth_token.dart';
import '../../services/products_service.dart';

class ProductsManager with ChangeNotifier {
    Product findById(String id){
      return _items.firstWhere((prod) => prod.id == id);
    }
  List<Product> _items = [];

    final ProductsService _productsService;

  ProductsManager([AuthToken? authToken])
    : _productsService = ProductsService(authToken);

  set authToken(AuthToken? authToken) {
    _productsService.authToken = authToken;
  }

  Future<void> fetchProducts([bool filterByUser = false]) async {
    _items = await _productsService.fectProducts(filterByUser);
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final newProduct = await _productsService.addProduct(product);
    if(newProduct != null) {
      _items.add(newProduct);
      notifyListeners();
    }
  }

    int get itemCount{
      return _items.length;
    }

    List<Product> get items {
      return [..._items];
    }

    List<Product> get favoriteItems {
      return _items.where((prodItem) => prodItem.isFavorite).toList();
    }

    // void addProduct(Product product) {
    //   _items.add(
    //     product.coppyWith(
    //       id: 'p${DateTime.now().toIso8601String()}',
    //     ),
    //   );
    //   notifyListeners();
    // }

    void updateProduct(Product product) {
      final index = _items.indexWhere((item) => item.id == product.id);
      if (index >= 0) {
        _items[index] = product;
        notifyListeners();
      }
    }

    void deleteProduct(String id) {
      final index = _items.indexWhere((item) => item.id == id);
      _items.removeAt(index);
      notifyListeners();
    }
  
}

