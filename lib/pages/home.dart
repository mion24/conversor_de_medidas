import 'package:conversor_de_medidas/core/converte_medidas_comprimento.dart';
import 'package:conversor_de_medidas/core/converte_medidas_volume.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  //stl atalho p criar classes
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController baseController = TextEditingController();
  TextEditingController resultadoController = TextEditingController();

  double base = 0;
  double resultado = 0;

  String medidaBase = 'Quilomêtro';
  String medidaResultado = 'Metro';

  String tipo = 'Comprimento';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Conversor de Medidas :)"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButtonFormField(
                items: <DropdownMenuItem<String>>[
                  DropdownMenuItem(
                    child: Text("Comprimento"),
                    value: 'Comprimento',
                  ),
                  DropdownMenuItem(
                    child: Text("Volume"),
                    value: 'Volume',
                  ),
                  //shift alt duplica
                ],
                value: tipo,
                onChanged: (String? texto) {
                  setState(() {
                    tipo = texto!;

                    if (tipo == 'Comprimento') {
                      medidaBase = 'Metro';
                      medidaResultado = 'Centimetro';
                    } else {
                      medidaBase = 'Litro';
                      medidaResultado = 'Mililitro';
                    }
                  });
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    TextFormField(
                      //criação de um campo de texto e decoração do mesmo
                      decoration: InputDecoration(
                        hintText: 'Digite o Valor:', //valor que fica de fundo
                        border: InputBorder.none, //sem borda
                      ),
                      keyboardType: TextInputType
                          .number, //Tipo de teclado q vai ser mostrado
                      textAlign: TextAlign.center,
                      controller:
                          baseController, //guarda informacoes do que a pessoa idgitou
                      onChanged: (String? valorDigitado) {
                        setState(() {
                          if (tipo == 'Comprimento') {
                            calculaMedidasComprimento(valorDigitado);
                          } else {
                            calculaMedidasVolume(valorDigitado);
                          }
                        });
                      },
                    ),
                    DropdownButtonFormField(
                      items: tipo == 'Comprimento'
                          ? medidasDeComprimento()
                          : medidasDeVolume(),
                      value: medidaBase,
                      onChanged: (String? texto) {
                        setState(() {
                          if (texto == medidaResultado) {
                            medidaResultado = medidaBase;
                          }

                          medidaBase = texto!;

                          if (tipo == 'Comprimento') {
                            calculaMedidasComprimento(base.toString());
                          } else {
                            calculaMedidasVolume(base.toString());
                          }
                          calculaMedidasComprimento(base.toString());
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Text(
              '=',
              style: TextStyle(
                  //o - que aparece entre as colunas e tamanho de fonte
                  fontSize: 36),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 32.0, vertical: 8.0), //espaçamento interno
              child: Container(
                //conteiner é uma caixa imaginaria que envolve o codigo
                decoration: BoxDecoration(
                    //criação da borda
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    TextFormField(
                      //criação de um campo de texto e decoração do mesmo
                      decoration: InputDecoration(
                        hintText: 'Digite o Valor:', //valor que fica de fundo
                        border: InputBorder.none, //sem borda
                      ),
                      keyboardType: TextInputType
                          .number, //Tipo de teclado q vai ser mostrado
                      textAlign: TextAlign.center,
                      controller:
                          resultadoController, //guarda informacoes do que a pessoa idgitou
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: DropdownButtonFormField(
                        items: tipo == 'Comprimento'
                            ? medidasDeComprimento()
                            : medidasDeVolume(),
                        value: medidaResultado,
                        onChanged: (String? texto) {
                          setState(() {
                            if (texto == medidaBase) {
                              medidaBase = medidaResultado;
                            }

                            medidaResultado = texto!;
                            if (tipo == 'Comprimento') {
                              calculaMedidasComprimento(base.toString());
                            } else {
                              calculaMedidasVolume(base.toString());
                            }
                            calculaMedidasComprimento(base.toString());
                          });
                        },
                        //Valor que vem selecionado por padrao na caixa de itens
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  medidasDeComprimento() {
    return <DropdownMenuItem<String>>[
      //funcao que retorna a lista de itens.
      DropdownMenuItem(
        child: Text("Quilomêtro"),
        value: 'Quilomêtro',
      ),
      DropdownMenuItem(
        child: Text("Metro"),
        value: 'Metro',
      ),
      DropdownMenuItem(
        child: Text("Centimetro"),
        value: 'Centimetro',
      ),
      DropdownMenuItem(
        child: Text("Milímetros"),
        value: 'Milímetros',
      ),
    ].toList();
  }

  medidasDeVolume() {
    return <DropdownMenuItem<String>>[
      DropdownMenuItem(
        child: Text('Metro Cúbico'),
        value: 'Metro Cúbico',
      ),
      DropdownMenuItem(
        child: Text('Litro'),
        value: 'Litro',
      ),
      DropdownMenuItem(
        child: Text('Mililitro'),
        value: 'Mililitro',
      ),
    ].toList();
  }

  calculaMedidasComprimento(String? value) {
    if (value != null && value.isNotEmpty) {
      base = double.tryParse(value)!;
      final conversor = ConverteMedidasComprimento();

      switch (medidaResultado) {
        case 'Quilomêtro':
          resultadoController.text = conversor
              .converteQuilometro(medida: medidaBase, valor: base)
              .toString();
          break;
        case 'Metro':
          resultadoController.text = conversor
              .converteMetro(medida: medidaBase, valor: base)
              .toString();
          break;
        case 'Centimetro':
          resultadoController.text = conversor
              .converteCentimetro(medida: medidaBase, valor: base)
              .toString();
          break;
        case 'Milímetros':
          resultadoController.text = conversor
              .converteMilimetro(medida: medidaBase, valor: base)
              .toString();
          break;
        default:
      }
    } else {
      resultadoController.text = '';
    }
  }

  void calculaMedidasVolume(String? value) {
    if (value != null && value.isNotEmpty) {
      base = double.tryParse(value)!;
      final conversor = ConverteMedidasVolume();

      switch (medidaResultado) {
        case 'Metro Cubico':
          resultadoController.text = conversor
              .converteMetroCubico(medida: medidaBase, valor: base)
              .toString();
          break;
        case 'Litro':
          resultadoController.text = conversor
              .converteLitro(medida: medidaBase, valor: base)
              .toString();
          break;
        case 'Mililitro':
          resultadoController.text = conversor
              .converteMililitro(medida: medidaBase, valor: base)
              .toString();
          break;
        default:
      }
    } else {
      resultadoController.text = '';
    }
  }
}
