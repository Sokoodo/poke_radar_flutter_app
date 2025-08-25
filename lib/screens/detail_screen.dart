import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/card_provider.dart';
import '../models/card_model.dart';

class DetailScreen extends StatelessWidget {
  final String cardId;

  const DetailScreen({super.key, required this.cardId});

  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context, listen: false);

    // Load card details when screen is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cardProvider.loadCardDetail(cardId);
    });

    return Scaffold(
      appBar: AppBar(title: Text('Card Details')),
      body: Consumer<CardProvider>(
        builder: (ctx, cardProvider, _) {
          if (cardProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (cardProvider.selectedCard == null) {
            return Center(child: Text('Card not found'));
          }

          final card = cardProvider.selectedCard!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CachedNetworkImage(
                    imageUrl: card.imageUrl,
                    height: 300,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  card.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '${card.set} #${card.number}',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Chip(
                      label: Text(card.rarity),
                      backgroundColor: Colors.blue[100],
                    ),
                    SizedBox(width: 8),
                    Chip(
                      label: Text(card.category),
                      backgroundColor: Colors.green[100],
                    ),
                    if (card.owned) SizedBox(width: 8),
                    if (card.owned)
                      Chip(
                        label: Text('Owned'),
                        backgroundColor: Colors.orange[100],
                      ),
                  ],
                ),
                SizedBox(height: 24),
                Text(
                  'Current Price: \$${card.price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 24),
                Text(
                  'Price History',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 300,
                  child: SfCartesianChart(
                    primaryXAxis: DateTimeAxis(),
                    primaryYAxis: NumericAxis(),
                    series: <CartesianSeries>[
                      LineSeries<PriceHistory, DateTime>(
                        dataSource: cardProvider.priceHistory,
                        xValueMapper: (PriceHistory history, _) => history.date,
                        yValueMapper: (PriceHistory history, _) =>
                            history.price,
                        markerSettings: MarkerSettings(isVisible: true),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
