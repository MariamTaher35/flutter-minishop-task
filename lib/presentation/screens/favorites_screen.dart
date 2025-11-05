import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/ cubit/favorites_cubit.dart';
import '../../logic/bloc/product_bloc.dart';
import '../../logic/bloc/product_state.dart';
import '../../data/models/product.dart';
import '../widgets/product_card.dart';
import 'product_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favCubit = context.watch<FavoritesCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoaded) {
              // Filter products by favorite IDs
              final favorites = state.products
                  .where((p) => favCubit.isFavorite(p.id))
                  .toList();

              if (favorites.isEmpty) {
                return const Center(child: Text('No favorites yet'));
              }

              return GridView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: favorites.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.62,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final Product p = favorites[index];
                  return ProductCard(
                    product: p,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailsScreen(product: p),
                      ),
                    ),
                  );
                },
              );
            } else if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(
                  child: Text('No products loaded. Try reopening the app.'));
            }
          },
        ),
      ),
    );
  }
}

