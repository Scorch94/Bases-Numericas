import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Classe MyApp, representa o aplicativo
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Configurações do aplicativo
      title: 'Conversor de Base Numérica',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Página inicial do aplicativo
      home: ConverterPage(),
    );
  }
}

// Página principal do aplicativo
class ConverterPage extends StatefulWidget {
  @override
  _ConverterPageState createState() => _ConverterPageState();
}

// Estado da página principal do aplicativo
class _ConverterPageState extends State<ConverterPage> {
  // Variáveis para controlar a base de entrada e saída, valores de entrada e saída
  String _selectedBaseInput = "Decimal";
  String _selectedBaseOutput = "Decimal";
  String _inputValue = "";
  String _outputValue = "";

  // Método para converter o valor entre bases numéricas
  void _convertValue(String value, String baseFrom, String baseTo) {
    setState(() {
      switch (baseFrom) {
        case "Decimal":
          _outputValue = _convertFromDecimal(int.parse(value), baseTo);
          break;
        case "Binário":
          _outputValue = _convertFromBinary(value, baseTo);
          break;
        case "Octal":
          _outputValue = _convertFromOctal(value, baseTo);
          break;
        case "Hexadecimal":
          _outputValue = _convertFromHexadecimal(value, baseTo);
          break;
      }
    });
  }

  // Métodos para converter valores específicos de bases numéricas

  // Converter de Decimal para outra base
  String _convertFromDecimal(int value, String baseTo) {
    switch (baseTo) {
      case "Decimal":
        return value.toString();
      case "Binário":
        return value.toRadixString(2);
      case "Octal":
        return value.toRadixString(8);
      case "Hexadecimal":
        return value.toRadixString(16).toUpperCase();
      default:
        return "";
    }
  }

// Converter de Binário para outra base
  String _convertFromBinary(String value, String baseTo) {
    int decimalValue = int.parse(value, radix: 2);
    return _convertFromDecimal(decimalValue, baseTo);
  }

  // Converter de Octal para outra base
  String _convertFromOctal(String value, String baseTo) {
    int decimalValue = int.parse(value, radix: 8);
    return _convertFromDecimal(decimalValue, baseTo);
  }

  // Converter de Hexadecimal para outra base
  String _convertFromHexadecimal(String value, String baseTo) {
    int decimalValue = int.parse(value, radix: 16);
    return _convertFromDecimal(decimalValue, baseTo);
  }

  @override
  Widget build(BuildContext context) {
    // Interface do aplicativo
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversor de Base Numérica'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo de entrada para o valor a ser convertido
            Text('Valor:'),
            TextField(
              onChanged: (value) {
                setState(() {
                  _inputValue = value;
                  _convertValue(
                      _inputValue, _selectedBaseInput, _selectedBaseOutput);
                });
              },
            ),
            SizedBox(height: 20.0),
            // Dropdown para selecionar a base de entrada
            Text('Base de Entrada:'),
            DropdownButton<String>(
              value: _selectedBaseInput,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedBaseInput = newValue!;
                  _outputValue = "";
                });
              },
              items: <String>['Decimal', 'Binário', 'Octal', 'Hexadecimal']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            // Dropdown para selecionar a base de saída
            Text('Base de Saída:'),
            DropdownButton<String>(
              value: _selectedBaseOutput,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedBaseOutput = newValue!;
                  _outputValue = "";
                });
              },
              items: <String>['Decimal', 'Binário', 'Octal', 'Hexadecimal']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            // Exibição do resultado da conversão
            Text('Resultado: $_outputValue'),
          ],
        ),
      ),
    );
  }
}
