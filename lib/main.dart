import 'package:flutter/material.dart';
import 'package:myshop/ui/cart/cart_manager.dart';
import 'package:myshop/ui/orders/order_manager.dart';
import 'package:provider/provider.dart';
import 'ui/products/products_manager.dart';
import 'ui/products/product_detail_screen.dart';
import 'ui/products/product_overview_screen.dart';
import 'ui/products/user_products_screen.dart';
import 'ui/cart/cart_screen.dart';
import 'ui/orders/orders_screen.dart';
import 'ui/products/edit_product_screen.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsManager(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartManager(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrderManager(),
        ),
      ],
      child: MaterialApp(
        title: 'My Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple,
          ).copyWith(
            secondary: Colors.deepOrange,
          ),
        ),
        home: const ProductsOverviewScreen(),
        routes: {
          CartScreen.routeName:
              (ctx) => const CartScreen(),
          OrderScreen.routeName:
              (ctx) => const OrderScreen(),
          UserProductsScreen.routeName:
              (ctx) => const UserProductsScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == EditProductScreen.routeName){
            final productId = settings.arguments as String?;
            return MaterialPageRoute(
              builder: (ctx) {
                return EditProductScreen(
                  productId != null
                  ? ctx.read<ProductsManager>().findById(productId)
                  : null,
                );
              },
            );
          }
          return null;
        },
      ),
    );
  }
}