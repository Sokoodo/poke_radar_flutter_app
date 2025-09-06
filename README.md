# PokeTrendRadar Flutter

Versione Flutter dell'applicazione PokeTrendRadar per il monitoraggio dei prezzi delle carte Pokemon.

## Descrizione

PokeTrendRadar è un'applicazione che permette di:

- Visualizzare carte Pokemon singole e prodotti sealed
- Monitorare l'andamento dei prezzi nel tempo
- Gestire la propria collezione di carte
- Visualizzare statistiche di mercato

## Conversione da Angular

Questo progetto è la conversione in Flutter dell'applicazione Angular originale, mantenendo le stesse funzionalità e API.

## Caratteristiche

- **Responsive Design**: Compatibile con Android, Windows e web
- **Material Design 3**: Interfaccia moderna e consistente
- **Architettura GetX**: State management e navigazione
- **Grafici Interattivi**: Visualizzazione dell'andamento prezzi
- **Cache Immagini**: Caricamento ottimizzato delle immagini delle carte
- **API RESTful**: Integrazione con il backend esistente

## Struttura del Progetto

```
lib/
├── main.dart                 # Entry point dell'app
├── app/                      # Configurazione app e routing
├── models/                   # Modelli dati
├── services/                 # Servizi per API e business logic
├── screens/                  # Schermate dell'applicazione
├── widgets/                  # Widget riutilizzabili
├── utils/                    # Utilità e costanti
└── common/                   # Componenti base
```

## API Endpoints

L'app si connette al backend tramite le seguenti API:

- `GET /api/products/singlesPokemon` - Lista carte singole
- `GET /api/products/sealedPokemon` - Lista prodotti sealed
- `GET /api/products/product_detail` - Dettagli prodotto
- `GET /api/owned_products/get_owned_products` - Carte possedute
- `POST /api/owned_products/add_owned_products` - Aggiungi carta posseduta

## Librerie Utilizzate

- **GetX**: State management, dependency injection e routing
- **HTTP**: Chiamate API REST
- **Cached Network Image**: Cache e caricamento immagini
- **FL Chart**: Grafici e visualizzazioni
- **Responsive Framework**: Design responsive multi-piattaforma
- **URL Launcher**: Apertura link esterni

## Setup e Installazione

1. **Prerequisiti**

   ```bash
   flutter --version  # Flutter 3.10+
   dart --version     # Dart 3.0+
   ```

2. **Clona e installa dipendenze**

   ```bash
   flutter pub get
   ```

3. **Configura l'URL del backend**
   Modifica `lib/utils/constants.dart` per impostare l'URL del tuo backend:

   ```dart
   static const String apiBaseUrl = 'http://localhost:8000';
   ```

4. **Esegui l'app**

   ```bash
   # Android
   flutter run

   # Windows
   flutter run -d windows

   # Web
   flutter run -d web-server --web-port 3000
   ```

## Build per Produzione

### Android APK

```bash
flutter build apk --release
```

### Windows

```bash
flutter build windows --release
```

### Web

```bash
flutter build web --release
```

## Differenze dall'Originale Angular

### Migliorate

- **Performance**: Flutter offre performance native superiori
- **Responsive**: Migliore supporto per diversi form factor
- **State Management**: GetX semplifica la gestione dello stato
- **Navigation**: Sistema di routing più intuitivo

### Equivalenze

- **Servizi Angular** → **Services Flutter con GetX**
- **Componenti Angular** → **StatefulWidget/StatelessWidget**
- **HttpClient Angular** → **HTTP package + ApiClient**
- **Angular Material** → **Material 3**
- **ECharts** → **FL Chart**
- **Bootstrap** → **Responsive Framework**

## Struttura Responsive

L'app si adatta automaticamente a diversi schermi:

- **Mobile**: < 800px (layout a colonna)
- **Tablet**: 800-1000px (layout ibrido)
- **Desktop**: > 1000px (layout multi-colonna)

## Performance

- **Lazy Loading**: Caricamento on-demand delle schermate
- **Image Caching**: Cache persistente delle immagini
- **State Persistence**: Mantenimento stato durante la navigazione
- **API Caching**: Cache intelligente delle chiamate API

## Contribuire

Per contribuire al progetto:

1. Fork del repository
2. Crea un branch per la feature (`git checkout -b feature/AmazingFeature`)
3. Commit delle modifiche (`git commit -m 'Add AmazingFeature'`)
4. Push del branch (`git push origin feature/AmazingFeature`)
5. Apri una Pull Request

## Licenza

Questo progetto mantiene la stessa licenza del progetto Angular originale.
