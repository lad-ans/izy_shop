import 'package:mobx/mobx.dart';
part 'size_selector_store.g.dart';

class SizeSelectorStore = _SizeSelectorStoreBase with _$SizeSelectorStore;

abstract class _SizeSelectorStoreBase with Store {
  @observable
  int index;

  @action
  selector(int index) => this.index = index;
}
