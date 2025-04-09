import 'package:get/get.dart';
import 'package:infoware/product/itesm_model.dart';
import 'package:infoware/product/services.dart';

class ProductConroller extends GetxController {
  var productItems = <ProductElement>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchProducts();
      if (products != null) {
        productItems.assignAll(products.products);
      }
    } finally {
      isLoading(false);
    }
  }
}