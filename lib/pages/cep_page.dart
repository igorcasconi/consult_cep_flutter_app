import 'package:consult_cep_flutter_app/models/cep_model.dart';
import 'package:consult_cep_flutter_app/repositories/cep_repository.dart';
import 'package:flutter/material.dart';

class CepPage extends StatefulWidget {
  const CepPage({super.key});

  @override
  State<CepPage> createState() => _CepPageState();
}

class _CepPageState extends State<CepPage> {
  var isLoading = false;
  var _cepListData = CepsModel([]);
  var cepRepository = CepRepository();

  @override
  void initState() {
    super.initState();
    loadCEPS();
  }

  void loadCEPS() async {
    setState(() {
      isLoading = true;
    });

    _cepListData = await cepRepository.getCepList();

    setState(() {
      isLoading = false;
    });
  }

  handleDeleteCep(String id) async {
    try {
      await cepRepository.deleteCep(id);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('CEP Excluído com sucesso!')));

      loadCEPS();
    } catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Ocorreu um erro ao excluir CEP')));
    }
  }

  Future<void> handleOpenAlertDelete(String id) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excluir dados do CEP'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text("Deseja excluir os dados do CEP selecionado?")],
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
                handleDeleteCep(id);
                Navigator.pop(context);
              },
              child: Text('Excluir', style: TextStyle(color: Colors.red)),
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
        title: Text("CEP's"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator(color: Colors.amber))
            : _cepListData.ceps.isEmpty
            ? Center(child: Text("Não há nenhum CEP salvo!"))
            : ListView.builder(
                itemCount: _cepListData.ceps.length,
                itemBuilder: (BuildContext buildContext, int index) {
                  var cep = _cepListData.ceps[index];

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
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
                                  "${cep.cep!.substring(0, 5)}-${cep.cep!.substring(5)}",
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
                                  Text(cep.logradouro.toString()),
                                  Text(cep.bairro.toString()),
                                  Text("${cep.localidade}, ${cep.uf}"),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                onPressed: () {
                                  handleOpenAlertDelete(cep.objectId!);
                                },
                                child: Text(
                                  "Excluir",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
