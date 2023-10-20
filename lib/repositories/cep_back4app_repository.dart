import 'package:cepapp/models/ceps_back4app.dart';
import 'package:cepapp/repositories/back4app_custom_dio.dart';

class CepBack4AppRepository {
  final _custonDio = Back4AppCustonDio();

  Future<CepsBack4App> obterCeps() async {
    var url = "/Ceps";

    var result = await _custonDio.dio.get(url);
    return CepsBack4App.fromJson(result.data);
  }

  Future<CepBack4App> obterCep(String cep) async {
    var url = "/Ceps?where={\"Cep\":\"$cep\"}";

    var result = await _custonDio.dio.get(url);
    var cepBack4App = CepsBack4App.fromJson(result.data);
    if (cepBack4App.ceps.isNotEmpty) {
      return cepBack4App.ceps[0];
    }
    return CepBack4App.vazio();
  }

  Future<void> criar(CepBack4App cepBack4App) async {
    try {
      await _custonDio.dio.post("/Ceps", data: cepBack4App.toJsonEndPoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> atualizar(CepBack4App cepBack4App) async {
    try {
      await _custonDio.dio.put("/Ceps/${cepBack4App.objectId}",
          data: cepBack4App.toJsonEndPoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> remover(String objectId) async {
    try {
      await _custonDio.dio.delete("/Ceps/$objectId");
    } catch (e) {
      rethrow;
    }
  }
}
