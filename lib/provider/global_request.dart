import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gerenciamento_pessoal_mobile/controllers/login_controller.dart';
import 'package:get_it/get_it.dart';

import '../resources/global_colors.dart';
import '../resources/global_scafold.dart';

class GlobalProvider {
  final Dio _connection = Dio();

  _configDioNetwork() {
    _connection.options.connectTimeout = 300000;
    _connection.options.receiveTimeout = 600000;
  }

  GlobalProvider() {
    _configDioNetwork();
  }

  getToken() {
    // return _connection.options.headers['authorization'] = 'Bearer 32|KjL8C7GyqRAeANgee4npFN2kP2AQBxJ1avFeq9Cu';

    final loginController = GetIt.I.get<LoginController>();

    debugPrint(loginController.user?.token);
    return _connection.options.headers['authorization'] = 'Bearer ${loginController.user?.token}';
  }

  final String apiUrl = "http://127.0.0.1:8000/api/";

  sendPost(route, data, requestType) async {
    try {
      
      if(requestType != 'register' && requestType != 'login') {
        getToken();
      }

      String endPoint = apiUrl + route;

      var response = await _connection.post(endPoint, data: data);

      _showMessage(requestType, type: "success");
      return response.data;
    } on DioError catch (e) {
      debugPrint(e.response.toString());
      Exception(e.response);
      _showMessage(e.response?.data['message'] ?? "Error", type: "error");
      return false;
    }
  }

  sendGet(route) async {
    try {
      getToken();
      String endPoint = apiUrl + route;

      var response = await _connection.get(endPoint);
      debugPrint(response.toString());
      return response.data;
    } on DioError catch (e) {
      debugPrint(e.response.toString());
      Exception(e.response);
      _showMessage(e.response?.data['message'] ?? "Error", type: "error");
      return false;
    }
  }

  sendPut(route, data, requestType) async {
    try {
      getToken();
      String endPoint = apiUrl + route;

      var response = await _connection.put(endPoint, data: data);

      _showMessage(requestType, type: "success");
      return response.data;
    } on DioError catch (e) {
      Exception(e.response);
      _showMessage(e.response?.data['message'] ?? "Error", type: "error");
      return false;
    }
  }

  sendDelete(route, {data}) async {
    try {
      getToken();
      String endPoint = apiUrl + route;

      var response = await _connection.delete(endPoint, data: data);

      _showMessage("delete", type: "success");
      return response.data;
    } on DioError catch (e) {
      Exception(e.response);
      _showMessage(e.response?.data['message'] ?? "Error", type: "error");
      return false;
    }
  }

  _getMessage(type) {
    switch (type) {
      case "update":
        return "The item has been successfully updated!";
      case "cancel":
        return "The item has been successfully canceled!";
      case "create":
        return "The item has been successfully created!";
      case "delete":
        return "The item has been successfully deleted!";
      case "login":
        return "Login efetuado com sucesso";
      default:
        return type;
    }
  }

  _showMessage(request, {type}) {
    GlobalScaffold.instance.snackBarStatus(_getMessage(request),
        color: type != null
            ? type == "success"
                ? GlobalColors.green
                : GlobalColors.red
            : null);
  }
}
