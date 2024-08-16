import 'dart:io';
import 'CliException.dart';
final String addOperation = 'S';
final String finish = 'N';
Map<int, List<double>> operationMap = {};


void main(List<String> args) {
  try {
    if (args.isEmpty) {
      throw CliException('Por favor informe uma expressão matemática, ultilizado a flag --exp');
    }
    if (args.length < 2) {
      throw CliException('Nenhuma expressão infrmada');
    }
    if (args[0] != "--exp") {
      throw CliException('Flag mal formatada: ${args[0]}, [--exp] esperado');
    }

    RegExp alphabeticalChars = RegExp('[a-zA-Z^*]');
    if (alphabeticalChars.hasMatch(args[1])) {
        throw CliException('Caracteres alfabéticos não permitidos.');
    }
  } catch (e) {
    print(e.toString());
  }
}