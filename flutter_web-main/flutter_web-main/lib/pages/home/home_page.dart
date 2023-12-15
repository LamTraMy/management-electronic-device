import 'package:flutter/material.dart';
import 'package:flutter_web_electronic_components/constants/color.dart';
import 'package:flutter_web_electronic_components/constants/controllers.dart';
import 'package:flutter_web_electronic_components/controllers/product_controller.dart';
import 'package:flutter_web_electronic_components/pages/home/widgets/horizontal_list.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<ProductController>(
          initState: (_) => productController.getProduct(idProductType: '2'),
          builder: (controller) => controller.products.isEmpty
              ? Shimmer.fromColors(
                  baseColor: baseShimmerColor,
                  highlightColor: highlightShimmerColor,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                )
              : GridProduct(
                  products: controller.products,
                  widthItem: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.height * 0.4,
                  titleText: 'Ram',
                  idProductType: '2',
                ),
        ),
        const SizedBox(height: 24),
        GetBuilder<ProductController>(
          initState: (_) => productController.getProduct(idProductType: '1'),
          builder: (controller) => controller.cpus.isEmpty
              ? Shimmer.fromColors(
                  baseColor: baseShimmerColor,
                  highlightColor: highlightShimmerColor,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                )
              : GridProduct(
                  products: controller.cpus,
                  widthItem: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.height * 0.4,
                  titleText: 'CPU',
                  idProductType: '1',
                ),
        ),
        const SizedBox(height: 24),
        GetBuilder<ProductController>(
          initState: (_) => productController.getProduct(idProductType: '6'),
          builder: (controller) => controller.laptops.isEmpty
              ? Shimmer.fromColors(
                  baseColor: baseShimmerColor,
                  highlightColor: highlightShimmerColor,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                )
              : GridProduct(
                  products: controller.laptops,
                  widthItem: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.height * 0.4,
                  titleText: 'Laptop',
                  idProductType: '6',
                ),
        ),
      ],
    );
  }
}
