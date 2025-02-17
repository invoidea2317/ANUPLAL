import 'package:anuplal/controller/orders_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../utils/sizeboxes.dart';
import '../../models/cart_model.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_buttons.dart';
import 'package:get/get.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  // Initialize the controller once using Get.put.
  final OrdersController ordersController = Get.put(OrdersController());

  @override
  void initState() {
    super.initState();
    ordersController.getOrdersInfo(ordersController);
  }


  void showProductBottomSheet(BuildContext context, List<ProductModel> products) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Order Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  debugPrint("https://anup.lab5.invoidea.in/storage/${products[index].media?.src}");
                  final product = products[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            "https://anup.lab5.invoidea.in${(product.thumbnail)!}",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                "Price: \$${product.price.toStringAsFixed(2)}",
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                "Quantity: ${product.quantity}",
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersController>(builder: (ordersScreenController) {
      // Show a loading indicator if 'order' is null or empty.
      if (ordersScreenController.order.isEmpty) {
        return SafeArea(
          child: const Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(125),
              child: CustomAppBar(
                title: 'Orders',
                isBackButtonExist: true,
              ),
            ),
            body: Center(
              child: Text("No Orders are there"),
            ),
          ),
        );
      }

      return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(125),
            child: const CustomAppBar(
              title: 'Orders',
              isBackButtonExist: true,
        
            ),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: ordersScreenController.order.length,
            itemBuilder: (context, index) {
              // debugPrint("https://anup.lab5.invoidea.in/storage/${ordersScreenController.order[index].media.toString()}");
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: GestureDetector(
                  onTap: () {
                    debugPrint("Order clicked:${ordersScreenController.order[index]}");
                    showProductBottomSheet(context, ordersScreenController.order[index].products!);
                  },
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Color(0x334C5829)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 80.26,
                            height: 80.10,
                            decoration:  BoxDecoration(
                              // Uncomment and replace image URL if needed
                              image: DecorationImage(
                                image: AssetImage("assets/images/genericOrder.png"),
                                // NetworkImage("https://anup.lab5.invoidea.in/storage/${ordersScreenController.order[index].media?.src}"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Order Code: ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF4C5829),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ordersScreenController.order[index].orderCode,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF4C5829),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Amount: ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF4C5829),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${ordersScreenController.order[index].amount}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF4C5829),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Payment Status: ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF4C5829),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ordersScreenController.order[index].paymentStatus,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF4C5829),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Order Status: ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF4C5829),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ordersScreenController.order[index].orderStatus,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF4C5829),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: 'Placed on: ',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF4C5829),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ordersScreenController.order[index].placedAt,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF4C5829),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}