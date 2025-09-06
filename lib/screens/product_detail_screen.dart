import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:poke_radar_app/screens/base_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../services/product_service.dart';
import '../services/navigation_service.dart';
import '../models/product_detail.dart';
import '../widgets/product_chart.dart';

class ProductDetailController extends GetxController {
  final ProductService _productService = ProductService();

  final Rx<ProductDetail?> productDetail = Rx<ProductDetail?>(null);
  final RxBool loading = true.obs;
  final RxString error = ''.obs;

  String? productUrl;

  void initialize(String idUrl) {
    productUrl = idUrl;
    loadProductDetail();
  }

  Future<void> loadProductDetail() async {
    if (productUrl == null) return;

    try {
      loading.value = true;
      error.value = '';

      final product = await _productService.getProductDetailsFromApi(
        productUrl!,
      );
      productDetail.value = product;

      loading.value = false;
    } catch (e) {
      error.value = 'Errore nel caricamento dei dettagli: $e';
      loading.value = false;
    }
  }

  Future<void> openCardmarket() async {
    if (productDetail.value != null) {
      await NavigationService.to.launchExternalUrl(productDetail.value!.idUrl);
    }
  }

  void showAddOwnedDialog() {
    // TODO: Implementare dialog per aggiungere alla collezione
    Get.snackbar('Info', 'Funzionalità in arrivo');
  }
}

class ProductDetailScreen extends BaseScreen {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends BaseScreenState<ProductDetailScreen> {
  final ProductDetailController controller = Get.put(ProductDetailController());

  @override
  void initState() {
    super.initState();
    final idUrl = Get.parameters['id_url'];
    if (idUrl != null) {
      controller.initialize(idUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.productDetail.value?.title ?? 'Dettagli Prodotto',
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Obx(() {
            if (controller.productDetail.value != null) {
              return IconButton(
                icon: const Icon(Icons.open_in_new),
                onPressed: () => controller.openCardmarket(),
                tooltip: 'Apri su CardMarket',
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
      body: ResponsiveBreakpoints.builder(
        child: Builder(
          builder: (context) => Obx(() {
            if (controller.loading.value) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Caricamento dettagli...'),
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
                      onPressed: () => controller.loadProductDetail(),
                      child: const Text('Riprova'),
                    ),
                  ],
                ),
              );
            }

            final product = controller.productDetail.value;
            if (product == null) {
              return const Center(child: Text('Prodotto non trovato'));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: ResponsiveRowColumn(
                layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
                    ? ResponsiveRowColumnType.COLUMN
                    : ResponsiveRowColumnType.ROW,
                rowCrossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Colonna sinistra - Immagine e info base
                  ResponsiveRowColumnItem(
                    rowFlex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Immagine del prodotto
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxHeight: 400,
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: product.image,
                                  fit: BoxFit.contain,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                        height: 300,
                                        color: Colors.grey[200],
                                        child: const Icon(
                                          Icons.image_not_supported,
                                          size: 100,
                                          color: Colors.grey,
                                        ),
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Informazioni base
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (product.subtitle != null) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    product.subtitle!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 16),
                                _buildInfoRow('Set:', product.setName),
                                _buildInfoRow('Numero:', product.cardNumber),
                                _buildInfoRow('Lingua:', product.language),
                                _buildInfoRow('Condizione:', product.condition),
                                _buildInfoRow('TCG:', product.tcgName),
                                _buildInfoRow(
                                  'Specie:',
                                  product.pokemonSpecies,
                                ),
                                const SizedBox(height: 16),
                                // Prezzo e disponibilità
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Prezzo Minimo: €${product.currentMinPrice.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Disponibilità: ${product.currentAvailability}',
                                      ),
                                      Text(
                                        'Nella collezione: ${product.ownedProductsCount}',
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Bottone aggiungi alla collezione
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () =>
                                        controller.showAddOwnedDialog(),
                                    icon: const Icon(Icons.add),
                                    label: const Text(
                                      'Aggiungi alla Collezione',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ResponsiveRowColumnItem(child: const SizedBox(width: 16)),
                  // Colonna destra - Grafico
                  ResponsiveRowColumnItem(
                    rowFlex: 1,
                    child: ProductChart(productDetail: product),
                  ),
                ],
              ),
            );
          }),
        ),
        breakpoints: const [
          Breakpoint(start: 0, end: 450, name: MOBILE),
          Breakpoint(start: 451, end: 800, name: TABLET),
          Breakpoint(start: 801, end: 1920, name: DESKTOP),
          Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
