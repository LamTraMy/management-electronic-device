import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_web_electronic_components/constants/color.dart';
import 'package:flutter_web_electronic_components/constants/controllers.dart';
import 'package:flutter_web_electronic_components/controllers/auth_controller.dart';
import 'package:flutter_web_electronic_components/controllers/cart_controller.dart';
import 'package:flutter_web_electronic_components/controllers/navigator_controller.dart';
import 'package:flutter_web_electronic_components/controllers/product_controller.dart';
import 'package:flutter_web_electronic_components/models/product.dart';
import 'package:flutter_web_electronic_components/pages/detail/detail_page.dart';
import 'package:flutter_web_electronic_components/widgets/custom_text.dart';
import 'package:flutter_web_electronic_components/widgets/icon_drop_down.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
    super.toolbarHeight = 112,
    super.leadingWidth = 0,
    super.automaticallyImplyLeading = false,
    super.title = const TitleAppBar(),
  });
}

class TitleAppBar extends StatelessWidget {
  const TitleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const IconDropDown(
          icon: Icons.list,
          items: MenuItems.menuItems,
        ),
        InkWell(
          onTap: () {
            Get.offAllNamed(rootRoute);
          },
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.fill,
            width: 200,
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            child: GetBuilder<ProductController>(
              initState: (_) => productController.getProduct(),
              builder: (controller) => controller.allProducts.isEmpty
                  ? Shimmer.fromColors(
                      baseColor: baseShimmerColor,
                      highlightColor: highlightShimmerColor,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 20,
                      ),
                    )
                  : TypeAheadField<Product>(
                      hideSuggestionsOnKeyboardHide: true,
                      keepSuggestionsOnLoading: false,
                      textFieldConfiguration: const TextFieldConfiguration(
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                          hintText: 'Tìm kiếm sản phẩm...',
                        ),
                      ),
                      suggestionsCallback: (string) async {
                        List<Product> list = controller.allProducts
                            .where(
                              (e) =>
                                  e.name?.toLowerCase().contains(string) ??
                                  false,
                            )
                            .toList();
                        return list;
                      },
                      itemBuilder: (context, product) {
                        return ListTile(
                          title: Text(product.name ?? ''),
                          subtitle: Text(
                            '${product.price} đ',
                          ),
                          trailing: SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.network(
                              product.image ?? '',
                              height: 50,
                              width: 50,
                            ),
                          ),
                        );
                      },
                      onSuggestionSelected: (product) {
                        Get.to(() => DetailPage(product: product));
                      },
                    ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        verticalDivider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<AuthController>(
            builder: (controller) => controller.user == null
                ? InkWell(
                    onTap: () {
                      Get.toNamed(loginPage);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        SizedBox(height: 4),
                        CustomText(
                          text: 'Tài khoản',
                          color: Colors.white,
                        )
                      ],
                    ),
                  )
                : IconDropDown(
                    icon: Icons.person,
                    items: MenuItems.account,
                    button: Column(
                      children: [
                        const Icon(
                          Icons.person,
                          size: 24,
                          shadows: [],
                        ),
                        CustomText(
                          text: authController.user!.firstName! +
                              authController.user!.lastName!,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
          ),
        ),
        verticalDivider(),
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Get.toNamed(cartPage);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(height: 4),
                    CustomText(
                      text: 'Giỏ hàng',
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 20,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: GetBuilder<CartController>(
                    initState: (_) => cartController.getCart(),
                    builder: (controller) => CustomText(
                      text: '${controller.carts.length}',
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget verticalDivider() {
    return const SizedBox(
      height: 50,
      width: 0.4,
      child: ColoredBox(color: Colors.white),
    );
  }
}
