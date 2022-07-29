import 'package:flutter/foundation.dart' show ValueNotifier, mapEquals, immutable;

@immutable
abstract class AppFormState<K, V> {
  AppFormState(Map<K, V> formState)
      : _formState = formState,
        _stateNotifier = ValueNotifier<Map<K, V>>(
          formState,
        );

  final Map<K, V> _formState;
  final ValueNotifier<Map<K, V>> _stateNotifier;

  ValueNotifier<Map<K, V>> get notifier => _stateNotifier;

  Map<K, V> get state => {..._formState};

  void delete(K key) {
    _formState.remove(key);
    _stateNotifier.value = {..._formState};
  }

  void updateValues(Map<K, V> values) {
    _formState.addEntries(values.entries);
    _stateNotifier.value = {..._formState};
  }

  void updateValue(K key, V newValue) {
    _formState.update(key, (value) => newValue);
    _stateNotifier.value = {..._formState};
  }

  V getValue(String key) => _formState[key]!;

  operator [](K key) => _formState[key];
  operator []=(K key, V newValue) {
    _formState.update(key, (value) => newValue);
    _stateNotifier.value = {..._formState};
  }

  @override
  String toString() => {..._formState}.toString();

  @override
  bool operator ==(Object other) {
    return other is AppFormState<K, V> && mapEquals(_formState, other._formState);
  }

  @override
  int get hashCode => _formState.hashCode ^ _stateNotifier.hashCode;
}
