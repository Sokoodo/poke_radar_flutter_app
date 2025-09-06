import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poke_radar_app/widgets/pokemon_card.dart';
import 'package:responsive_framework/responsive_framework.dart' as responsive;
import '../services/singles_service.dart';
import '../services/navigation_service.dart';
import '../models/singles_detail.dart';
import '../screens/base_screen.dart';

class SinglesController extends GetxController {
  final SinglesService _singlesService = SinglesService();

  final RxList<SinglesDetail> singlesProducts = <SinglesDetail>[].obs;
  final RxList<SinglesDetail> filteredProducts = <SinglesDetail>[].obs;
  final RxBool loading = true.obs;
  final RxString error = ''.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadSinglesProducts();
  }

  Future<void> loadSinglesProducts() async {
    try {
      loading.value = true;
      error.value = '';

      final products = await _singlesService.getSinglesListFromApi();
      singlesProducts.value = products;
      filteredProducts.value = products;

      loading.value = false;
    } catch (e) {
      error.value = 'Errore nel caricamento dei prodotti: $e';
      loading.value = false;
    }
  }

  void searchProducts(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredProducts.value = singlesProducts;
    } else {
      filteredProducts.value = singlesProducts
          .where(
            (product) =>
                product.title.toLowerCase().contains(query.toLowerCase()) ||
                product.setName.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
  }

  void navigateToProductDetail(String idUrl) {
    NavigationService.to.navigateToProductDetail(idUrl);
  }

  Future<void> openCardmarket(String idUrl) async {
    await NavigationService.to.launchExternalUrl(idUrl);
  }
}

class SinglesScreen extends BaseScreen {
  const SinglesScreen({super.key});

  @override
  State<SinglesScreen> createState() => _SinglesScreenState();
}

class _SinglesScreenState extends BaseScreenState<SinglesScreen> {
  final SinglesController controller = Get.put(SinglesController());
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carte Singole'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.loadSinglesProducts(),
          ),
        ],
      ),
      body: responsive.ResponsiveBreakpoints.builder(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Cerca carte...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => controller.searchProducts(value),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.loading.value) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Caricamento prodotti...'),
                      ],
                    ),
                  );
                }

                if (controller.error.value.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, size: 64, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(controller.error.value),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => controller.loadSinglesProducts(),
                          child: const Text('Riprova'),
                        ),
                      ],
                    ),
                  );
                }

                if (controller.filteredProducts.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('Nessun prodotto trovato'),
                      ],
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: responsive.ResponsiveValue<int>(
                        context,
                        defaultValue: 2,
                        conditionalValues: [
                          const responsive.Condition.smallerThan(
                            name: responsive.TABLET,
                            value: 2,
                          ),
                          const responsive.Condition.largerThan(
                            name: responsive.TABLET,
                            value: 4,
                          ),
                          const responsive.Condition.largerThan(
                            name: responsive.DESKTOP,
                            value: 6,
                          ),
                        ],
                      ).value,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                    ),
                    itemCount: controller.filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = controller.filteredProducts[index];
                      return ProductCard(
                        idUrl: product.idUrl,
                        title: product.title,
                        setName: product.setName,
                        image: product.image,
                        language: product.language,
                        currentMinPrice: product.currentMinPrice,
                        currentAvailability: product.currentAvailability,
                        onTap: () =>
                            controller.navigateToProductDetail(product.idUrl),
                        onCardMarketTap: () =>
                            controller.openCardmarket(product.idUrl),
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
        breakpoints: const [
          responsive.Breakpoint(start: 0, end: 450, name: responsive.MOBILE),
          responsive.Breakpoint(start: 451, end: 800, name: responsive.TABLET),
          responsive.Breakpoint(
            start: 801,
            end: 1920,
            name: responsive.DESKTOP,
          ),
          responsive.Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
    );
  }
}
