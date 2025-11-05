import 'package:flutter/material.dart';
import '../../data/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/ cubit/favorites_cubit.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  const ProductDetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favCubit = context.watch<FavoritesCubit>();
    final isFav = favCubit.isFavorite(product.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis),
        actions: [
          IconButton(
            icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
            onPressed: () {
              favCubit.toggleFavorite(product.id);
            },
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 260,
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    fit: BoxFit.contain,
                    placeholder: (c, s) => const CircularProgressIndicator(),
                    errorWidget: (c, s, e) => const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(product.title, style: Theme.of(context).textTheme.headline6),
              const SizedBox(height: 8),
              Text('\$${product.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.green)),
              const SizedBox(height: 16),
              Text(product.description),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    favCubit.toggleFavorite(product.id);
                    final nowFav = favCubit.isFavorite(product.id);
                    final snack = nowFav ? 'Added to favorites' : 'Removed from favorites';
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(snack)));
                  },
                  icon: const Icon(Icons.favorite),
                  label: const Text('Toggle Favorite'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
