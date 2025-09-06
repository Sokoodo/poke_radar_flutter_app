import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/category_provider.dart';
import 'category_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PokeTrend Radar')),
      body: Consumer<CategoryProvider>(
        builder: (ctx, categoryProvider, _) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ToggleButtons(
                isSelected: categoryProvider.selectedCategories,
                onPressed: (int index) {
                  categoryProvider.toggleCategory(index);
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Sealed'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Singles'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Owned'),
                  ),
                ],
              ),
            ),
            Expanded(child: CategoryScreen()),
          ],
        ),
      ),
    );
  }
}
