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
        title: const Text('Consulta CEP'),
        backgroundColor: Colors.purple,
        centerTitle: true,
        leading: const Icon(Icons.refresh),
      ),
      // single child é para dar scroll na tela
      body: Center(
        child: Padding(
          // padding é para dar espaço
          padding: const EdgeInsets.all(40),
          // column colocar componentes em coluna
          child: Column(
            children: [
              // textField digitar valores - inserir
              TextFormField(
                keyboardType: TextInputType.number,
                controller: cepEC,
                decoration: const InputDecoration(labelText: 'Digite o CEP'),
                style: const TextStyle(fontSize: 14),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CepInputFormatter(),
                ],
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 241, 215, 134),
                  elevation: 15,
                  shadowColor: Colors.purple,
                ),
                child: const Text(
                  "Pesquisar",
                  style: TextStyle(
                    color: Color.fromARGB(255, 65, 61, 61),
                  ),
                ),
                onPressed: () {
                  searchCep(
                      cepEC.text.replaceFirst('.', '').replaceFirst('-', ''));
                },
              ),

              SizedBox(
                height: 20,
              ),
              Text(
                "O endereço irá aparecer aqui: ",
                style: TextStyle(color: Colors.grey),
              ),

              Visibility(
                  visible: cepData?.localidade?.isNotEmpty ?? false,
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(cepData?.cep ?? 'não encontrado',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(cepData?.localidade ?? 'não encontrado',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(cepData?.uf ?? 'não encontrado',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
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

BlueBox() {}
