import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_ease/app/di/injection.dart';
import 'package:shop_ease/app/router/route_names.dart';
import 'package:shop_ease/features/products/presentation/bloc/products_bloc.dart';
import 'package:shop_ease/features/products/presentation/bloc/products_event.dart';
import 'package:shop_ease/features/products/presentation/bloc/products_state.dart';
import 'package:shop_ease/features/products/presentation/widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ProductsBloc>().add(ProductsNextPageRequested());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => getIt<ProductsBloc>()
      ..add(ProductsRequested())
      ..add(CategoriesRequested()),
    child: Scaffold(
      appBar: AppBar(
        title: const Text('Shop Ease'),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(RouteNames.notifications),
            icon: const Icon(Icons.notifications_none),
          ),
          IconButton(
            onPressed: () => context.pushNamed(RouteNames.profile),
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state.status == ProductsStatus.loading &&
              state.products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              _SearchBar(controller: _searchController),
              const _CategoryList(),
              Expanded(child: _buildMainContent(context, state)),
            ],
          );
        },
      ),
      bottomNavigationBar: const _BottomNav(currentIndex: 0),
    ),
  );

  Widget _buildMainContent(BuildContext context, ProductsState state) {
    switch (state.status) {
      case ProductsStatus.empty:
        return const _EmptyState();
      case ProductsStatus.failure:
        return _ErrorState(message: state.errorMessage);
      case ProductsStatus.success:
      case ProductsStatus.loading:
        return RefreshIndicator(
          onRefresh: () async {
            context.read<ProductsBloc>().add(ProductsRefreshed());
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
              final childAspectRatio = constraints.maxWidth < 350 ? 0.55 : 0.65;

              return GridView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: state.hasReachedMax
                    ? state.products.length
                    : state.products.length + 1,
                itemBuilder: (context, index) {
                  if (index >= state.products.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  final product = state.products[index];
                  return ProductCard(
                    product: product,
                    onTap: () => context.pushNamed(
                      RouteNames.productDetail,
                      pathParameters: {'id': product.id.toString()},
                    ),
                  );
                },
              );
            },
          ),
        );
      default:
        return const SizedBox();
    }
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  const _SearchBar({required this.controller});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Search products...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            controller.clear();
            context.read<ProductsBloc>().add(const SearchQueryChanged(''));
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      onSubmitted: (query) {
        context.read<ProductsBloc>().add(SearchQueryChanged(query));
      },
    ),
  );
}

class _CategoryList extends StatelessWidget {
  const _CategoryList();

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<ProductsBloc, ProductsState>(
    builder: (context, state) {
      if (state.categories.isEmpty) return const SizedBox.shrink();

      return SizedBox(
        height: 50,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: state.categories.length,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final category = state.categories[index];
            final isSelected =
                state.selectedCategory == category ||
                (category == 'All' && state.selectedCategory == null);

            return ChoiceChip(
              label: Text(category[0].toUpperCase() + category.substring(1)),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  context.read<ProductsBloc>().add(CategorySelected(category));
                }
              },
            );
          },
        ),
      );
    },
  );
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey),
        const SizedBox(height: 16),
        Text(
          'No products found',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        const Text('Try searching with different keywords.'),
      ],
    ),
  );
}

class _ErrorState extends StatelessWidget {
  final String? message;
  const _ErrorState({this.message});

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off, size: 80, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            message ?? "We couldn't load the products. Check your connection.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton.tonal(
            onPressed: () =>
                context.read<ProductsBloc>().add(ProductsRequested()),
            child: const Text('Try again'),
          ),
        ],
      ),
    ),
  );
}

class _BottomNav extends StatelessWidget {
  final int currentIndex;
  const _BottomNav({required this.currentIndex});

  @override
  Widget build(BuildContext context) => NavigationBar(
    selectedIndex: currentIndex,
    onDestinationSelected: (index) {
      if (index == currentIndex) return;
      if (index == 0) context.goNamed(RouteNames.home);
      if (index == 1) context.pushNamed(RouteNames.notifications);
      if (index == 2) context.pushNamed(RouteNames.profile);
    },
    destinations: const [
      NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
      NavigationDestination(
        icon: Icon(Icons.notifications_outlined),
        label: 'Alerts',
      ),
      NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
    ],
  );
}
