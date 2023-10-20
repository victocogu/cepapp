import 'package:cepapp/models/ceps_back4app.dart';
import 'package:cepapp/models/via_cep.dart';
import 'package:cepapp/pages/edit_cep_page.dart';
import 'package:cepapp/repositories/cep_back4app_repository.dart';
import 'package:cepapp/repositories/via_cep_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var cepController = TextEditingController(text: "");
  bool loading = false;
  var viaCep = ViaCep();
  var viaCepRepository = ViaCepRepository();
  var _ceps = CepsBack4App([]);
  var cepBack4AppRepository = CepBack4AppRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obterCeps();
  }

  void obterCeps() async {
    _ceps = await cepBack4AppRepository.obterCeps();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Cep App"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: const Text(
                      "Consulta de CEP",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: TextField(
                      controller: cepController,
                      keyboardType: TextInputType.number,
                      maxLength: 9,
                      // onChanged: (String value) async {
                      //   var cep = value.replaceAll(RegExp(r"[^0-9]"), "");
                      //   if (cep.length == 8) {
                      //     setState(() {
                      //       loading = true;
                      //     });
                      //     viaCep = await viaCepRepository.consultarCep(cep);
                      //   }
                      //   setState(() {
                      //     loading = false;
                      //   }
                      //   );
                      // },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                TextButton(
                    onPressed: () async {
                      var cep =
                          cepController.text.replaceAll(RegExp(r"[^0-9]"), "");
                      if (cep.length == 8) {
                        setState(() {
                          loading = true;
                        });
                        viaCep = await viaCepRepository.consultarCep(cep);

                        var cepCadastrado =
                            await cepBack4AppRepository.obterCep(viaCep.cep
                                .toString()
                                .replaceAll(RegExp(r"[^0-9]"), ""));
                        if (cepCadastrado.cep == "") {
                          await cepBack4AppRepository.criar(CepBack4App.criar(
                              viaCep.cep
                                  .toString()
                                  .replaceAll(RegExp(r"[^0-9]"), ""),
                              viaCep.logradouro.toString(),
                              viaCep.complemento.toString(),
                              viaCep.bairro.toString(),
                              viaCep.localidade.toString(),
                              viaCep.uf.toString(),
                              viaCep.ibge.toString()));
                        }
                      }
                      cepController.text = "";
                      obterCeps();
                      setState(() {
                        loading = false;
                      });
                    },
                    child: const Text("Buscar")),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              viaCep.logradouro ?? "",
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              "${viaCep.localidade ?? ""} - ${viaCep.uf ?? ""}",
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Ceps Cadastrados",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            if (loading) const CircularProgressIndicator(),
            Expanded(
              child: ListView.builder(
                itemCount: _ceps.ceps.length,
                itemBuilder: (BuildContext bc, int index) {
                  var cep = _ceps.ceps[index];
                  return Dismissible(
                    onDismissed: (DismissDirection dismissDirection) async {
                      await cepBack4AppRepository.remover(cep.objectId);
                      obterCeps();
                    },
                    key: Key(cep.objectId),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "Cep: ${cep.cep} - Logradouro: ${cep.logradouro}"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditCepPage(
                                        cepBack4App: cep,
                                      ),
                                    )).then((value) => obterCeps());
                              },
                              child: const Icon(Icons.edit),
                            )
                          ],
                        ),
                        Text(
                            "Bairro: ${cep.bairro} - Cidade: ${cep.localidade} - ${cep.uf}"),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
