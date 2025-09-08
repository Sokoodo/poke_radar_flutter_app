import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poke_radar_app/screens/base_screen.dart';
import 'package:poke_radar_app/widgets/pokemon_card.dart';
import 'package:responsive_framework/responsive_framework.dart' as responsive;
import '../services/owned_product_service.dart';
import '../services/navigation_service.dart';
import '../models/owned_product_data.dart';

class MyCardsController extends GetxController {
  final OwnedProductService _ownedProductService = OwnedProductService();

  final RxList<OwnedProductData> ownedProducts = <OwnedProductData>[].obs;
  final RxList<OwnedProductData> filteredProducts = <OwnedProductData>[].obs;
  final RxBool loading = true.obs;
  final RxString error = ''.obs;
  final RxString searchQuery = ''.obs;
  final RxDouble totalValue = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadOwnedProducts();
  }

  Future<void> loadOwnedProducts() async {
    try {
      loading.value = true;
      error.value = '';

      final products = await _ownedProductService.getOwnedProductListFromApi();
      ownedProducts.value = products;
      filteredProducts.value = products;

      // Calcola il valore totale
      totalValue.value = products.fold(
        0.0,
        (sum, product) =>
            sum + (product.currentMinPrice * product.ownedEntriesNumber),
      );

      loading.value = false;
    } catch (e) {
      error.value = 'Errore nel caricamento della collezione: $e';
      loading.value = false;
    }
  }

  void searchProducts(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredProducts.value = ownedProducts;
    } else {
      filteredProducts.value = ownedProducts
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

class MyCardsScreen extends BaseScreen {
  const MyCardsScreen({super.key});

  @override
  State<MyCardsScreen> createState() => _MyCardsScreenState();
}

class _MyCardsScreenState extends BaseScreenState<MyCardsScreen> {
  final MyCardsController controller = Get.put(MyCardsController());
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
        title: const Text('Le Mie Carte'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.loadOwnedProducts(),
          ),
        ],
      ),
      body: responsive.ResponsiveBreakpoints.builder(
        child: Column(
          children: [
            Obx(
              () => Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          '${controller.filteredProducts.length}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const Text('Carte Possedute'),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '€${controller.totalValue.value.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const Text('Valore Totale'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Cerca nelle mie carte...',
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
                        Text('Caricamento collezione...'),
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
                          onPressed: () => controller.loadOwnedProducts(),
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
                        Icon(
                          Icons.collections_bookmark_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text('Nessuna carta nella collezione'),
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
                      return Stack(
                        children: [
                          ProductCard(
                            idUrl: product.idUrl,
                            title: product.title,
                            setName: product.setName,
                            image: product.image,
                            language: product.language,
                            currentMinPrice: product.currentMinPrice,
                            currentAvailability: product.currentAvailability,
                            onTap: () => controller.navigateToProductDetail(
                              product.idUrl,
                            ),
                            onCardMarketTap: () =>
                                controller.openCardmarket(product.idUrl),
                          ),
                          if (product.ownedEntriesNumber > 1)
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '${product.ownedEntriesNumber}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
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
