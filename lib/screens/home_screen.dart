import 'package:demaze/bloc/product/product_bloc.dart';
import 'package:demaze/general/build_product_item_container.dart';
import 'package:demaze/screens/add_edit_product_screen.dart';
import 'package:demaze/screens/change_theme_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<ProductBloc>()
        .add(GetProductDetailsFromPreferencesRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Products'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ChangeThemeScreen(),
                ),
              );
            },
            child: const Text('Change Theme'),
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        buildWhen: (previous, current) =>
            previous.status != current.status ||
            previous.products != current.products,
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              var product = state.products[index];
              return BuildProductItemContainer(
                productName: product.productName,
                productDetail: product.productDescription,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          AddEditProductScreen(productModel: product),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddProductScreen(context: context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToAddProductScreen({required BuildContext context}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddEditProductScreen(),
      ),
    );
  }
}
