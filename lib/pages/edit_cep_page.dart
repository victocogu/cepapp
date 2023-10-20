import 'package:cepapp/models/ceps_back4app.dart';
import 'package:cepapp/repositories/cep_back4app_repository.dart';
import 'package:flutter/material.dart';

class EditCepPage extends StatelessWidget {
  final CepBack4App cepBack4App;
  var cepBack4AppRepository = CepBack4AppRepository();
  var cepController = TextEditingController(text: "");
  var logradouroController = TextEditingController(text: "");
  var bairroController = TextEditingController(text: "");
  var complementoController = TextEditingController(text: "");
  var cidadeController = TextEditingController(text: "");
  var ufController = TextEditingController(text: "");

  EditCepPage({super.key, required this.cepBack4App}) {
    cepController.text = cepBack4App.cep;
    logradouroController.text = cepBack4App.logradouro;
    bairroController.text = cepBack4App.bairro;
    complementoController.text = cepBack4App.complemento;
    cidadeController.text = cepBack4App.localidade;
    ufController.text = cepBack4App.uf;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(title: const Text("Editar Cep")),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: ListView(children: [
                const Text("Cep"),
                TextField(
                  controller: cepController,
                  keyboardType: TextInputType.number,
                  maxLength: 9,
                ),
                const Text("Logradouro"),
                TextField(
                  controller: logradouroController,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Bairro"),
                TextField(
                  controller: bairroController,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Complemento"),
                TextField(
                  controller: complementoController,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Cidade"),
                TextField(
                  controller: cidadeController,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("UF"),
                TextField(
                  controller: ufController,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () async {
                      cepBack4App.cep =
                          cepController.text.replaceAll(RegExp(r"[^0-9]"), "");
                      cepBack4App.logradouro = logradouroController.text;
                      cepBack4App.bairro = bairroController.text;
                      cepBack4App.complemento = complementoController.text;
                      cepBack4App.localidade = cidadeController.text;
                      cepBack4App.uf = ufController.text;
                      await cepBack4AppRepository.atualizar(cepBack4App);
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.save),
                  ),
                )
              ]),
            )));
  }
}
