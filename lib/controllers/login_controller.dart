import 'package:flutter/material.dart';
import 'package:gerenciamento_pessoal_mobile/models/user_model.dart';
import 'package:gerenciamento_pessoal_mobile/repositories/global_api.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {

    final GlobalApi rep = GetIt.I.get<GlobalApi>();


  TextEditingController name= TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController registerName = TextEditingController();
  TextEditingController registerEmail = TextEditingController();
  TextEditingController registerPassword = TextEditingController();

  @observable
  bool isLoading = false;

  @action
  changeLoading(bool value) => isLoading = value;

  @observable
  UserModel? user;

  @action
  Future<bool> login() async {
    bool success = true;
    changeLoading(true);
    var data = {
      "email": name.text,
      "password": password.text 
    };
    try {
      UserModel res = await rep.login(data);
      user = res;
    }catch(e) {
      success = false;
    }
    changeLoading(false);
    return success;
  }

  @action
  register() async {
    changeLoading(true);
    var data = {
      "name": registerName.text,
      "email": registerEmail.text,
      "password": registerPassword.text
    };
    bool res = await rep.register(data);
    changeLoading(false);
    return res;
  }

  dispose() {
    name.clear();
    password.clear();
    registerName.clear();
    registerEmail.clear();
    registerPassword.clear();
    changeLoading(false);
  }

  registerDispose() {
    registerName.clear();
    registerEmail.clear();
    registerPassword.clear();
    changeLoading(false);
  }
  
}
