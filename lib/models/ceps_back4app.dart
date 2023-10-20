class CepsBack4App {
  List<CepBack4App> ceps = [];

  CepsBack4App(this.ceps);

  CepsBack4App.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      ceps = <CepBack4App>[];
      json['results'].forEach((v) {
        ceps.add(CepBack4App.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = ceps.map((v) => v.toJson()).toList();
    return data;
  }
}

class CepBack4App {
  String objectId = "";
  String createdAt = "";
  String updatedAt = "";
  String cep = "";
  String logradouro = "";
  String complemento = "";
  String bairro = "";
  String localidade = "";
  String uf = "";
  String ibge = "";

  CepBack4App(
      this.objectId,
      this.createdAt,
      this.updatedAt,
      this.cep,
      this.logradouro,
      this.complemento,
      this.bairro,
      this.localidade,
      this.uf,
      this.ibge);

  CepBack4App.criar(this.cep, this.logradouro, this.complemento, this.bairro,
      this.localidade, this.uf, this.ibge);

  CepBack4App.vazio();

  CepBack4App.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    cep = json['Cep'];
    logradouro = json['Logradouro'];
    complemento = json['Complemento'];
    bairro = json['Bairro'];
    localidade = json['Localidade'];
    uf = json['UF'];
    ibge = json['Ibge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['Cep'] = cep;
    data['Logradouro'] = logradouro;
    data['Complemento'] = complemento;
    data['Bairro'] = bairro;
    data['Localidade'] = localidade;
    data['UF'] = uf;
    data['Ibge'] = ibge;
    return data;
  }

  Map<String, dynamic> toJsonEndPoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Cep'] = cep;
    data['Logradouro'] = logradouro;
    data['Complemento'] = complemento;
    data['Bairro'] = bairro;
    data['Localidade'] = localidade;
    data['UF'] = uf;
    data['Ibge'] = ibge;
    return data;
  }
}
