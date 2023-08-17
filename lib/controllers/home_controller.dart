import 'package:gerenciamento_pessoal_mobile/models/tasks_model.dart';
import 'package:gerenciamento_pessoal_mobile/models/wallet.dart';
import 'package:gerenciamento_pessoal_mobile/repositories/global_api.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  GlobalApi rep = GetIt.I.get<GlobalApi>();

  @observable
  bool isLoading = false;

  @action
  changeLoading(value) => isLoading = value;

  @observable
  WalletModel wallet = WalletModel();

  @observable
  ObservableList<TasksModel> tasks = ObservableList<TasksModel>();

  @action
  getData() async {
    changeLoading(true);

    DateTime now = DateTime.now();
    String nowFormatted = '${now.year}-${now.month}-${now.day}';

    WalletModel temp = await rep.getWallet();
    List<TasksModel> tempList = await rep.getTasks(filter: nowFormatted);

    wallet = temp;
    tasks = tempList.asObservable();
    changeLoading(false);
  }
}