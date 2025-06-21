# A lightweight version of Alice for Dio, designed for simple logging in Flutter.

Alice is an HTTP Inspector tool for Flutter which helps debugging http requests.
It catches and stores http requests and responses, which can be viewed via simple UI.

Overlay bubble version of Alice: https://github.com/jhomlala/alice



**Supported Dart http client plugins:**
- Dio

**Features:**  
✔️ Detailed logs for each HTTP calls (HTTP Request, HTTP Response)  
✔️ Inspector UI for viewing HTTP calls  
✔️ Statistics  
✔️ Support for top used HTTP clients in Dart  
✔️ Error handling  
✔️ HTTP calls search
✔️ Bubble overlay entry

## Install

1. Add this to your **pubspec.yaml** file:

```yaml
dependencies:
  flutter_alice_dio: ^1.0.0
```

2. Install it

```bash
$ flutter pub get
```

3. Import it

```dart
import 'package:flutter_alice_dio/flutter_alice_dio.dart';
```

## Usage
### Alice configuration
1. Create Alice instance:

```dart
// Define a navigator key
final navigatorKey = GlobalKey<NavigatorState>();

// Create Alice with the navigator key
final alice = Alice(navigatorKey: navigatorKey);
```

2. Add navigator key to your application:

```dart
dio.interceptors.add(alice.getDioInterceptor());
```

You need to add this navigator key in order to show inspector UI.

### HTTP Client configuration
#### For Dio
Add interceptor to your Dio instance:

```dart
final dio = Dio();
dio.interceptors.add(alice.getDioInterceptor());
```
