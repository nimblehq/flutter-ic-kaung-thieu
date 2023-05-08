// a generic Listener class, used to keep track of when a provider notifies its listeners
// Ref https://codewithandrea.com/articles/unit-test-async-notifier-riverpod/
abstract class AsyncListener {
  void call<T>(T? previous, T next);
}
