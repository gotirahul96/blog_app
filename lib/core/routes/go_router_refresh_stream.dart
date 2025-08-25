// go_router_refresh.dart
import 'dart:async';
import 'package:flutter/foundation.dart';

//To refresh the Router when cubit updates
class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription _sub;
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _sub = stream.listen((_) => notifyListeners());
  }
  @override
  void dispose() { _sub.cancel(); super.dispose(); }
}