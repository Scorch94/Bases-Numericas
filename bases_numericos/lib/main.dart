import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor de Base Numérica',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ConverterPage(),
    );
  }
}

class ConverterPage extends StatefulWidget {
  @override
  _ConverterPageState createState() => _ConverterPageState();
}

class _ConverterPageState extends State<ConverterPage> {
  String _selectedBaseInput = "Decimal";
  String _selectedBaseOutput = "Decimal";
  String _inputValue = "";
  String _outputValue = "";

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

  String _convertFromBinary(String value, String baseTo) {
    int decimalValue = int.parse(value, radix: 2);
    return _convertFromDecimal(decimalValue, baseTo);
  }

  String _convertFromOctal(String value, String baseTo) {
    int decimalValue = int.parse(value, radix: 8);
    return _convertFromDecimal(decimalValue, baseTo);
  }

  String _convertFromHexadecimal(String value, String baseTo) {
    int decimalValue = int.parse(value, radix: 16);
    return _convertFromDecimal(decimalValue, baseTo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversor de Base Numérica'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Text('Resultado: $_outputValue'),
          ],
        ),
      ),
    );
  }
}
