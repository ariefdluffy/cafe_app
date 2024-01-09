import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/product_detail_controller.dart';
import '../state/product_detail_state.dart';
import 'package:get_it/get_it.dart';

class ProductDetailView extends StatefulWidget {
  final Map item;
  const ProductDetailView({Key? key, required this.item}) : super(key: key);

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  ProductDetailController controller = ProductDetailController();

  @override
  void initState() {
    if (GetIt.I.isRegistered<ProductDetailController>()) {
      GetIt.I.unregister<ProductDetailController>();
    }
    GetIt.I.registerSingleton(controller);
    controller.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => controller.ready(),
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => controller,
      child: BlocListener<ProductDetailController, ProductDetailState>(
        listener: (context, state) {},
        child: BlocBuilder<ProductDetailController, ProductDetailState>(
          builder: (context, state) {
            final bloc = context.read<ProductDetailController>();
            return buildView(context, bloc, state);
          },
        ),
      ),
    );
  }

  Widget buildView(
    BuildContext context,
    ProductDetailController controller,
    ProductDetailState state,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Product Detail'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_outline,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 160.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    widget.item["photo"],
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    8.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              "${widget.item["product_name"]}",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              "${widget.item["category"]}",
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              "Description",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
