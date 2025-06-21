
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_alice_dio/alice_core/alice_core.dart';
import 'package:flutter_alice_dio/alice_core/alice_dio_interceptor.dart';

class Alice {
  /// Should user be notified with notification if there's new request catched
  /// by Alice
  final bool showNotification;

  /// Should inspector be opened on device shake (works only with physical
  /// with sensors)
  final bool showInspectorOnShake;

  /// Should inspector use dark theme
  final bool darkTheme;

  /// Icon url for notification
  final String notificationIcon;

  GlobalKey<NavigatorState>? _navigatorKey;
  late AliceCore _aliceCore;

  /// Creates alice instance.
  Alice(
      {GlobalKey<NavigatorState>? navigatorKey,
        this.showNotification = true,
        this.showInspectorOnShake = false,
        this.darkTheme = false,
        this.notificationIcon = "@mipmap/ic_launcher"}) {
    _navigatorKey = navigatorKey ?? GlobalKey<NavigatorState>();
    _aliceCore = AliceCore(
      _navigatorKey,
      showNotification,
      showInspectorOnShake,
      darkTheme,
      notificationIcon,
    );
  }

  /// Set custom navigation key. This will help if there's route library.
  void setNavigatorKey(GlobalKey<NavigatorState> navigatorKey) {
    _aliceCore.setNavigatorKey(navigatorKey);
  }

  /// Get currently used navigation key
  GlobalKey<NavigatorState>? getNavigatorKey() {
    return _navigatorKey;
  }

  /// Get Dio interceptor which should be applied to Dio instance.
  AliceDioInterceptor getDioInterceptor() {
    return AliceDioInterceptor(_aliceCore);
  }

  /// Opens Http calls inspector. This will navigate user to the new fullscreen
  /// page where all listened http calls can be viewed.
  void showInspector() {
    _aliceCore.navigateToCallListScreen();
  }
}
