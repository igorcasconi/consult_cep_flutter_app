import 'package:consult_cep_flutter_app/models/cep_model.dart';
import 'package:consult_cep_flutter_app/repositories/cep_repository.dart';
import 'package:consult_cep_flutter_app/shared/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _cepController = TextEditingController(text: '');
  var isLoadingCep = false;
  var cepData = CepModel();
  var cepRepository = CepRepository();

  handleGetCep() async {
    if (_cepController.text.isEmpty) return;

    setState(() {
      isLoadingCep = true;
    });

    FocusManager.instance.primaryFocus?.unfocus();
    cepData = await cepRepository.getCep(_cepController.text);

    setState(() {
      isLoadingCep = false;
    });
  }

  handleSaveCEP() async {
    try {
      var cepSaveData = CepModel.create(
        cepData.cep,
        cepData.logradouro,
        cepData.bairro,
        cepData.localidade,
        cepData.uf,
      );

      await cepRepository.saveCep(cepSaveData);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('CEP Salvo com sucesso!')));
    } catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  Future<void> handleOpenAlertSave() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Salvar dados do CEP'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text("Deseja salvar os dados do CEP pesquisado?")],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar', style: TextStyle(color: Colors.amber)),
            ),
            TextButton(
              onPressed: () {
                handleSaveCEP();
                Navigator.pop(context);
              },
              child: Text('Adicionar', style: TextStyle(color: Colors.amber)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consulte o CEP", style: TextStyle(color: Colors.black87)),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Consulte um CEP, digitando o número abaixo",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _cepController,
              keyboardType: TextInputType.number,
              maxLength: 8,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'CEP',
              ),
            ),
            SizedBox(height: 12),
            FilledButton(
              onPressed: () {
                handleGetCep();
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  isLoadingCep ? Colors.grey : Colors.amber,
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              child: Text("Pesquisar", style: TextStyle(color: Colors.black)),
            ),
            SizedBox(height: 12),
            cepData.cep == null
                ? Column(children: [Text("Não foi pesquisado nenhum CEP")])
                : isLoadingCep
                ? Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: CircularProgressIndicator(color: Colors.amber),
                  )
                : Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.numbers),
                                Text(
                                  cepData.cep.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(cepData.logradouro.toString()),
                                  Text(cepData.bairro.toString()),
                                  Text("${cepData.localidade}, ${cepData.uf}"),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                onPressed: () {
                                  handleOpenAlertSave();
                                },
                                child: Text(
                                  "Salvar",
                                  style: TextStyle(color: Colors.amber),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
