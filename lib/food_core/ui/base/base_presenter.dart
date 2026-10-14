abstract class BasePresenter {
  bool isDisposed = false;

  dispose() {
    isDisposed = true;
  }
}
