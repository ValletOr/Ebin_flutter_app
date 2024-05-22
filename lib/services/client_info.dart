import 'package:client_information/client_information.dart';

class ClientInfo {

  ClientInfo._internal();

  static final ClientInfo _instance = ClientInfo._internal();

  static ClientInfo get instance => _instance;

  late ClientInformation info;

  Future<void> fetchClientInfo() async{
    info = await ClientInformation.fetch();
  }

}