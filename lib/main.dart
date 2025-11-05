// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repositories/product_repository.dart';
import 'logic/ cubit/favorites_cubit.dart';
import 'logic/bloc/product_bloc.dart';
import 'presentation/screens/product_list_screen.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final productRepository = ProductRepository();

  runApp(MyApp(productRepository: productRepository));
}

class MyApp extends StatelessWidget {
  final ProductRepository productRepository;
  const MyApp({Key? key, required this.productRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (_) => ProductBloc(repository: productRepository),
        ),
        BlocProvider<FavoritesCubit>(
          create: (_) => FavoritesCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MiniShop',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
        home: const ProductListScreen(),
      ),
    );
  }
}
