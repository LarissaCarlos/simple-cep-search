import 'package:brasil_fields/brasil_fields.dart';
import 'package:consuming_cep/controller/cep_search.dart';
import 'package:consuming_cep/models/cep_model.dart';
import 'package:consuming_cep/pages/second_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CepModel? cepData;

  Future<CepModel> searchCep(String cep) async {
    var result = await Dio().get('https://viacep.com.br/ws/$cep/json/');
    try {
      if (result.statusCode == 200) {
        print(result.data);
      } else {
        print('erro');
      }
    } catch (e) {
      print(e);
    }

    setState(() {
      cepData = CepModel.fromMap(result.data);
    });
    return cepData = CepModel.fromMap(result.data);
  }

  final cepEC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultando um CEP via API'),
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: const Icon(Icons.person),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SecondPage()),
              );
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      // single child é para dar scroll na tela
      body: SingleChildScrollView(
        child: Padding(
          // padding é para dar espaço
          padding: const EdgeInsets.all(20),
          // column colocar componentes em coluna
          child: Column(
            children: [
              // textField digitar valores - inserir
              TextFormField(
                controller: cepEC,
                decoration: InputDecoration(hintText: 'Digite o Cep'),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CepInputFormatter(),
                ],
              ),
              ElevatedButton(
                child: Text("Pesquisar"),
                onPressed: () {
                  searchCep(
                      cepEC.text.replaceFirst('.', '').replaceFirst('-', ''));
                },
              ),

              Visibility(
                  visible: cepData?.localidade?.isNotEmpty ?? false,
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          cepData?.localidade ?? 'não encontrado',
                          style: TextStyle(),
                        ),
                        Text(cepData?.cep ?? 'não encontrado'),
                        Text(cepData?.complemento ?? 'não encontrado'),
                        Text(cepData?.uf ?? 'não encontrado'),
                        Text(cepData?.ddd ?? 'não encontrado')
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
