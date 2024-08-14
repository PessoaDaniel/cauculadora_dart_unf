import 'dart:io';
final String addOperation = 'S';
final String finish = 'N';
Map<int, List<double>> operationMap = {};


void main(List<String> args) {
  stdout.writeln('Bem vindo a calculadora');
  getOperation(isFirst:true);
  while (canFinish() != 'N') {
    getOperation();
  }
  String expression = '';
  operationMap.forEach((key, List<double> operation) {
    if (key == 1) {
     expression += operation[0].toString();
    } else {
      switch (int.parse(operation[0].toString())) {
        case 1:
          expression += "+ ${operation[1]}";
          break;
        case 2:
          expression += "- ${operation[1]}";
          break;
        case 3:
          expression += "/ ${operation[1]}";
          break;
        case 5:
          expression += "* ${operation[1]}";
          break;
      }
    }
    print(expression);
  });
}

void getOperation ({bool isFirst = false}) {
  stdout.write('Adiocione um operando: ');
  double operand = double.parse(stdin.readLineSync()!);
  double secondOperand = 0;
  stdout.write('Selecione a operação\n'
      '1 - Adição \n'
      '2 - Subtração \n'
      '3 - Divisão \n'
      '4 - Multiplicação \n'
  );
  double operation = double.parse(stdin.readLineSync()!);

  if (isFirst) {
    stdout.write('Adiocione um operando: ');
    secondOperand = double.parse(stdin.readLineSync()!);
    operationMap.putIfAbsent((operationMap.length + 1),  () => [operand]);
    operationMap.putIfAbsent((operationMap.length + 1),  () => [operation, secondOperand]);
  } else {
    operationMap.putIfAbsent((operationMap.length + 1), () => [operation, operand]);
  }
}

String canFinish() {
  stdout.writeln('Adiocionar novo operando?');
  stdout.writeln('$addOperation - (SIM)');
  stdout.writeln('$finish - (NÃO)');
  return stdin.readLineSync()!;
}