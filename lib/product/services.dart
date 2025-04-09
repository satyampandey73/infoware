import 'package:http/http.dart' as http;
import 'package:infoware/product/itesm_model.dart';

class RemoteServices {
  static var client = http.Client();
  static Future<Product?> fetchProducts() async {
    var response =
        await client.get(Uri.parse("https://dummyjson.com/products"));
    if (response.statusCode == 200) {
      var json = response.body;
      return productFromJson(json);
    } else {
      print('Error response:${response.body}');
    }

    return null;
  }
}