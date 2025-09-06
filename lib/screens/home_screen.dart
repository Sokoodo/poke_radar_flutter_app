import 'package:flutter/material.dart';
import 'package:poke_radar_app/screens/base_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../services/navigation_service.dart';

class HomeScreen extends BaseScreen {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseScreenState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PokeTrendRadar'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ResponsiveBreakpoints.builder(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.catching_pokemon, size: 100, color: Colors.blue),
              const SizedBox(height: 30),
              const Text(
                'PokeTrendRadar',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Monitora i prezzi delle carte Pokemon',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              ResponsiveRowColumn(
                layout: ResponsiveBreakpoints.of(context).smallerThan(TABLET)
                    ? ResponsiveRowColumnType.COLUMN
                    : ResponsiveRowColumnType.ROW,
                rowMainAxisAlignment: MainAxisAlignment.center,
                columnMainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ResponsiveRowColumnItem(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: _buildNavigationCard(
                        title: 'Carte Singole',
                        subtitle: 'Esplora le carte Pokemon singole',
                        icon: Icons.style,
                        onTap: () => NavigationService.to.navigateToSingles(),
                        color: Colors.green,
                      ),
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: _buildNavigationCard(
                        title: 'Prodotti Sealed',
                        subtitle: 'Buste e box sigillati',
                        icon: Icons.inventory_2,
                        onTap: () => NavigationService.to.navigateToSealed(),
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ResponsiveRowColumn(
                layout: ResponsiveBreakpoints.of(context).smallerThan(TABLET)
                    ? ResponsiveRowColumnType.COLUMN
                    : ResponsiveRowColumnType.ROW,
                rowMainAxisAlignment: MainAxisAlignment.center,
                columnMainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ResponsiveRowColumnItem(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: _buildNavigationCard(
                        title: 'Le Mie Carte',
                        subtitle: 'Gestisci la tua collezione',
                        icon: Icons.collections,
                        onTap: () => NavigationService.to.navigateToMyCards(),
                        color: Colors.purple,
                      ),
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: _buildNavigationCard(
                        title: 'Statistiche',
                        subtitle: 'Analizza i dati di mercato',
                        icon: Icons.analytics,
                        onTap: () =>
                            NavigationService.to.navigateToStatistics(),
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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

  Widget _buildNavigationCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 250,
          height: 120,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
