import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infoware/product/get_controller.dart';
import 'package:infoware/product/itesm_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductConroller productConroller = Get.put(ProductConroller());
  final TextEditingController searchController = TextEditingController();
  RxList<ProductElement> filteredProducts = <ProductElement>[].obs;

  @override
  void initState() {
    super.initState();
    productConroller.fetchProducts();
    filteredProducts.assignAll(productConroller.productItems);
    searchController.addListener(_filterProducts);
  }

  void _filterProducts() {
    String query = searchController.text.toLowerCase();
    filteredProducts.assignAll(productConroller.productItems.where((product) {
      return product.title.toLowerCase().contains(query);
    }).toList());
  }

  Future<void> _refreshProducts() async {
    productConroller.fetchProducts();
    _filterProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 139, 249, 203),
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: "Search products...",
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                if (productConroller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: _refreshProducts,
                    child: GridView.builder(
                      itemCount: filteredProducts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.69),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(() =>
                                DetailPage(product: filteredProducts[index]));
                          },
                          child: ProductItemsDisplay(
                            product: filteredProducts[index],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductItemsDisplay extends StatelessWidget {
  final ProductElement product;
  const ProductItemsDisplay({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: product.thumbnail,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300], // Skeleton effect
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, size: 40),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.title.length > 20
                  ? "${product.title.substring(0, 20)}..."
                  : product.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green),
                  child: Row(
                    children: [
                      Text(
                        product.rating.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 18,
                      ),
                    ],
                  ),
                ),
                Text(
                  product.category.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "\$${product.price}",
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final ProductElement product;
  const DetailPage({super.key, required this.product});

  // void _shareProduct() {
  //   final String shareText =
  //       "Check out this product: ${product.title}\nPrice: \$${product.price}\nRating: ${product.rating} ⭐\nDescription: ${product.description}\n${product.thumbnail}";
  //   Share.share(shareText);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        backgroundColor: const Color.fromARGB(255, 78, 255, 237),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.share),
          //   onPressed: _shareProduct,
          // ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      product.thumbnail,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  product.title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.category, color: Colors.blueGrey),
                    const SizedBox(width: 8),
                    Text(
                      "${product.category}",
                      style:
                          const TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.attach_money, color: Colors.green),
                    const SizedBox(width: 8),
                    Text(
                      "Price: \$${product.price.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.star, color: const Color.fromARGB(255, 0, 0, 0)),
                    const SizedBox(width: 8),
                    Text(
                      "Rating: ${product.rating} ⭐",
                      style:
                          const TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  "Description:",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  product.description,
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 20),
                Divider(),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.inventory, color: Colors.red),
                    const SizedBox(width: 8),
                    Text(
                      "Stock: ${product.stock} (Min Order: ${product.minimumOrderQuantity})",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: product.stock < product.minimumOrderQuantity
                            ? Colors.red
                            : Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.local_shipping, color: Colors.blue),
                    const SizedBox(width: 8),
                    Text(
                      "Shipping: ${product.shippingInformation}",
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.verified, color: Colors.green),
                    const SizedBox(width: 8),
                    Text(
                      "Warranty: ${product.warrantyInformation}",
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.replay, color: Colors.deepPurple),
                    const SizedBox(width: 8),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Text(
                        "${product.returnPolicy}",
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black54),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2, // Add ellipsis if text overflows
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  "Reviews:-",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: product.reviews.map((review) {
                    return Card(
                      color: const Color.fromARGB(255, 240, 240, 240),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Icon(
                          Icons.person,
                          color: Colors.blueAccent,
                        ),
                        title: Text(
                          review.reviewerName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Email: ${review.reviewerEmail}",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black54)),
                            Text("Rating: ${review.rating} ⭐"),
                            Text("Comment: ${review.comment}"),
                            Text("Date: ${review.date}",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
