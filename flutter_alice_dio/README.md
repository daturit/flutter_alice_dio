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

## Usage
### Alice configuration
1. Create Alice instance:

```dart
// Define a navigator key
final navigatorKey = GlobalKey<NavigatorState>();

// Create Alice with the navigator key
final alice = Alice(
      navigatorKey: navigatorKey,
      showInspectorOnShake: true,
      showNotification: true,
      darkTheme: true);
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

### Show inspector by shake gesture
```dart
ShakeDetectWrap(
enabled: true,
onShake: () {
alice.showInspector();
}
child: Container(
  child: Text('Your app content here'),
));

```

## Commemoration

This package was originally authored by
[Anh Tuan](https://github.com/daturit).