import 'package:consult_cep_flutter_app/models/cep_model.dart';
import 'package:consult_cep_flutter_app/providers/provider.dart';
import 'package:consult_cep_flutter_app/providers/viacep_provider.dart';

class CepRepository {
  final _provider = Provider();
  final _providerViaCep = ViaCepProvider();

  CepRepository();

  Future<CepsModel> getCepList() async {
    var result = await _provider.dio.get('/cep');
    return CepsModel.fromListJson(result.data);
  }

  Future<CepModel> getCep(String cep) async {
    var result = await _providerViaCep.dio.get("/$cep/json/");

    if (result.statusCode == 200) {
      return CepModel.fromJson(result.data);
    }

    return CepModel();
  }

  Future<bool> getCepDetailWithCepNumber(String cep) async {
    var result = await _provider.dio.get(
      "/cep?limit=1&where={\"cep_number\": ${int.parse(cep.replaceAll('-', ''))} }",
    );

    if (result.statusCode == 200) {
      if (result.data['results'] != null && result.data['results'].length > 0) {
        var cepData = CepModel.fromDatabaseJson(result.data['results'][0]);
        return cepData.cep != null;
      }
    }

    return false;
  }

  Future<void> saveCep(CepModel cep) async {
    try {
      var existCepRegistered = await getCepDetailWithCepNumber(cep.cep!);

      if (existCepRegistered) throw "Esse CEP já está salvo!";

      await _provider.dio.post(
        '/cep',
        data: {
          "cep_number": int.parse(cep.cep!.replaceAll('-', '')),
          "state": cep.uf,
          "city": cep.localidade,
          "neighborhood": cep.bairro,
          "street": cep.logradouro,
        },
      );
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteCep(String id) async {
    try {
      await _provider.dio.delete("/cep/$id");
    } catch (error) {
      throw error;
    }
  }
}
