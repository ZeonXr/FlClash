import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

mixin AutoDisposeNotifierMixin<T> on AnyNotifier<T, T> {
  T get value => state;

  set value(T value) {
    state = value;
  }

  bool equals(T previous, T next) {
    return false;
  }

  @override
  bool updateShouldNotify(previous, next) {
    final res = !equals(previous, next)
        ? super.updateShouldNotify(previous, next)
        : true;
    if (res) {
      onUpdate(next);
    }
    return res;
  }

  void onUpdate(T value) {}

  void update(T? Function(T) builder) {
<<<<<<< HEAD
    final value = builder(state);
    if (value == null) {
      return;
    }
    this.value = value;
=======
    final res = builder(value);
    if (res == null) {
      return;
    }
    value = res;
>>>>>>> 672eaccd35dcd84f7a0492638adc779a3fd97735
  }
}

mixin AsyncNotifierMixin<T> on AnyNotifier<AsyncValue<T>, T> {
  T get value;

  set value(T value) {
    state = AsyncData(value);
  }
}
