import 'package:flutter/material.dart';
import 'package:solikat_2024/utils/common_colors.dart';
import 'package:solikat_2024/utils/constant.dart';

class ProductContainer extends StatefulWidget {
  final String imgUrl;
  final String productName;
  final String variantName;
  final int stock;
  final int discountPer;
  final int discountPrice;
  final int productPrice;
  final double? width;
  final Function onIncrement;
  final Function onDecrement;
  final int itemCount;

  const ProductContainer({
    super.key,
    required this.imgUrl,
    required this.productName,
    this.width,
    required this.onIncrement,
    required this.onDecrement,
    required this.stock,
    required this.variantName,
    required this.discountPrice,
    required this.productPrice,
    required this.discountPer,
    required this.itemCount,
  });

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  int itemCount = 0;

  void incrementItem() {
    setState(() {
      itemCount++;
    });
    widget.onIncrement();
  }

  void decrementItem() {
    if (itemCount > 0) {
      setState(() {
        itemCount--;
      });
      widget.onDecrement();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    if (widget.stock != 0)
                      Center(
                        child: Image.network(
                          widget.imgUrl,
                          fit: BoxFit.contain,
                          height: 170,
                        ),
                      ),
                    if (widget.stock == 0)
                      Center(
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.5),
                            BlendMode.srcOver, // Blend mode for overlay
                          ),
                          child: Image.network(
                            widget.imgUrl,
                            fit: BoxFit.contain,
                            height: 170,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      widget.productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: getAppStyle(
                          fontSize: 14,
                          color: widget.stock == 0
                              ? Colors.grey[400]
                              : Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    widget.variantName,
                    style: getAppStyle(
                      fontSize: 14,
                      color:
                          widget.stock == 0 ? Colors.grey[400] : Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.discountPrice.toString(),
                            style: getAppStyle(
                              fontSize: 14,
                              color: widget.stock == 0
                                  ? Colors.grey[400]
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.productPrice.toString(),
                            style: getAppStyle(
                              color: widget.stock == 0
                                  ? Colors.grey[400]
                                  : Colors.black54,
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                      if (widget.stock != 0) ...[
                        widget.itemCount > 1
                            ? Container(
                                // padding: const EdgeInsets.symmetric(
                                //     horizontal: 4, vertical: 4),
                                // margin: const EdgeInsets.only(bottom: 4),
                                height: 35,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: CommonColors.primaryColor,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: decrementItem,
                                      child: const Icon(
                                        Icons.remove,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      (widget.itemCount - 1).toString(),
                                      style: getAppStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: incrementItem,
                                      child: const Icon(
                                        Icons.add,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : InkWell(
                                onTap: incrementItem,
                                child: Container(
                                  width: 100,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: CommonColors.primaryColor,
                                        width: 1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Add",
                                      style: getAppStyle(
                                        color: CommonColors.primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ]
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (widget.discountPer != 0 && widget.stock != 0)
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Text(
                    "${widget.discountPer}% off",
                    style: getAppStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          if (widget.stock == 0)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 100),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: CommonColors.primaryColor.withOpacity(0.2),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(
                        2.0,
                        4.0,
                      ),
                      blurRadius: 5.0,
                      spreadRadius: 0.5,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                  child: Text(
                    "Sorry, this item is sold out",
                    textAlign: TextAlign.center,
                    style: getAppStyle(
                        color: CommonColors.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        height: 1.2),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
