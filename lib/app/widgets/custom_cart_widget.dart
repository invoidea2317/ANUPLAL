import 'package:anuplal/app/services/api_services.dart';
import 'package:anuplal/controller/home_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartItemContainer extends StatefulWidget {
  final dynamic imagePath;
  final dynamic productName;
  final dynamic quantity;
  final dynamic price;
  final String id;
  final HomeScreenController homeScreenController;

  const CartItemContainer({
    Key? key,
    this.imagePath,
    this.productName,
    this.quantity,
    this.price, required this.id, required this.homeScreenController,
  }) : super(key: key);

  @override
  State<CartItemContainer> createState() => _CartItemContainerState();
}

class _CartItemContainerState extends State<CartItemContainer> {
  int quantity = 0;
  ApiService apiService = ApiService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quantity = widget.quantity;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 350,
      //   height: 100,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.all(0.0),
      child: Row(
        children: [
          Image.network(widget.imagePath, width: 90, height: 100), // Adjust as needed
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // Aligns text to the start
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(
                  widget.productName,
                  style: TextStyle(fontSize: 17),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                           if(quantity!=1){
                             setState(() {
                               quantity--;
                             });
                             apiService.decreaseCartItemApi(widget.homeScreenController,widget.id);
                           }
                          },
                          child: Icon(Icons.remove, color: Colors.red)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black45, width: 2),
                          ),
                          child: Text('${quantity}'),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              quantity++;
                            });
                            apiService.increaseCartItemApi(widget.homeScreenController,widget.id);
                          },
                          child: Icon(Icons.add, color: Colors.green)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                 apiService.deleteCartItemApi(widget.homeScreenController,widget.id);
                },
                  child: Icon(Icons.delete, color: Colors.red)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Rs.${quantity>0?widget.price*quantity:widget.price }',
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
