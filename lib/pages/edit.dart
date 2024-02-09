import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_api/app/app_service_setup.dart';
import 'package:teste_api/app/models/transformador.dart';
import 'package:teste_api/pages/login.dart';

class Edit extends StatefulWidget {
  final FiltroModel filtroModel;
  const Edit({super.key, required this.filtroModel});

  @override
  // ignore: no_logic_in_create_state
  State<Edit> createState() => _EditState(filtroModel: filtroModel);
}

class _EditState extends State<Edit> {
  final FiltroModel filtroModel;
  List<SearchController> controllers = [];
  final TextEditingController itemsController = TextEditingController();
  _EditState({required this.filtroModel});

  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null && selectedDate != currentDate) {
      // Lógica para lidar com a data selecionada
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppService>(builder: (context, appService, child) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Edit'),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
              ),
            ],
          ),
          body: Center(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: filtroModel.campos.length,
              itemBuilder: (BuildContext context, int index) {
                // Adicione este log

                var campo = filtroModel.campos[index];

                switch (campo.tipo) {
                  case 'textfield':
                    return TextField(
                      decoration: InputDecoration(labelText: campo.titulo),
                    );

                  case 'label':
                    return Text(
                      campo.titulo,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    );

                  case 'divider':
                    return const Divider(
                      color: Colors.black, // ou qualquer outra cor desejada
                      thickness: 4.0,
                    );

                  case 'search':
                    SearchController controller;
                    if (controllers.length > index) {
                      controller = controllers[index];
                    } else {
                      controller = SearchController();
                      controllers.add(controller);
                    }

                    return Row(
                      children: <Widget>[
                        SearchAnchor(
                          searchController: controller,
                          builder: (BuildContext context,
                              SearchController controller) {
                            return IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                controller.openView();
                              },
                            );
                          },
                          suggestionsBuilder: (BuildContext context,
                              SearchController controller) {
                            return List<ListTile>.generate(5, (int index) {
                              final String item = 'item $index';
                              return ListTile(
                                title: Text(item),
                                onTap: () {
                                  setState(() {
                                    controller.closeView(item);
                                  });
                                },
                              );
                            });
                          },
                        ),
                        Text(controller.value.text),
                      ],
                    );

                  case 'dropdown':
                    final dropValue = ValueNotifier('');
                    final dropOpcoes = [
                      'Item1',
                      'Item2',
                      'Item3',
                      'Item4',
                      'Item5',
                      'Item6'
                    ];
                    return ValueListenableBuilder(
                      valueListenable: dropValue,
                      builder: (context, value, _) {
                        return DropdownButton(
                          hint: const Text('Escolha a marca'),
                          value: (value.isEmpty) ? null : value,
                          onChanged: (escolha) =>
                              dropValue.value = escolha.toString(),
                          items: dropOpcoes
                              .map(
                                (op) => DropdownMenuItem(
                                  value: op,
                                  child: Text(op),
                                ),
                              )
                              .toList(),
                        );
                      },
                    );

                  case 'barcode':
                    return TextField(
                      decoration: InputDecoration(labelText: campo.titulo),
                      // Adicione a lógica de manipulação do código de barras conforme necessário
                    );

                  case 'date':
                    return ElevatedButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      child: Text(campo.titulo),
                    );

                  default:
                    return const SizedBox
                        .shrink(); // Retorna um widget vazio para tipos desconhecidos
                }
              },
              separatorBuilder: (_, ___) => const Divider(),
            ),
          ));
    });
  }
}

class Items {
  final items = ['item1,item2,item3,item4,item5'];

  Items(this.label);
  final String label;
}
