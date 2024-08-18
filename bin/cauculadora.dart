import 'CliException.dart';

List<String> operationChars = ['+','-','/','*'];
void main(List<String> args) {
  try {

    if (args.isEmpty) {
      throw CliException('Por favor informe uma expressão matemática, ultilizado a flag --exp');
    }

    if (args.length < 2) {
      throw CliException('Nenhuma expressão infrmada');
    }

    if (args.length > 2) {
      throw CliException('Argumentos inesperados');
    }

    if (args[0] != "--exp") {
      throw CliException('Flag mal formatada: ${args[0]}, [--exp] esperado');
    }

    RegExp alphabeticalChars = RegExp('[a-zA-Z]');
    if (alphabeticalChars.hasMatch(args[1])) {
        throw CliException('Caracteres alfabéticos não permitidos.');
    }
    int operationsCount = 0;
    if (args[1].contains('+')) {
      operationsCount++;
    }
    if (args[1].contains('-')) {
      operationsCount++;
    }
    if (args[1].contains('/')) {
      operationsCount++;
    }
    if (args[1].contains('*')) {
      operationsCount++;
    }
    if (operationsCount > 1)  {
      if (args[1].contains('*') || args[1].contains('/')) {
        args[1] = doInOrderLevel2(args[1]);
      }
      if (args[1].contains('+') || args[1].contains('-')) {
        args[1] = doInOrderLevel1(args[1]);
      }
    } else {
      if (args[1].contains('/')) {
        args[1]  = doDivisionOperations(args[1]);
      }
      if (args[1].contains('*')) {
        args[1]  = doMultiplicationOperations(args[1]);
      }
      if (args[1].contains('+')) {
        args[1]  = doAddOperations(args[1]);
      }
      if (args[1].contains('-')) {
        args[1]  = doSubOperations(args[1]);
      }
    }
    print('O resultado é: ${args[1].replaceAll('.', ',')}');
  } catch (e) {
    print(e.toString());
  }
}

String doDivisionOperations(String expression, {externalOrderControl = false}) {
  String leftStringOperand = '';
  String rightStringOperand = '';
  double? leftOperand;
  int operatorIndex = 0;
  double? rightOperand;
  int leftDivisionIndex = 0;
  int rightDivisionIndex = 0;


  for (int charIndex = 0; charIndex < expression.runes.length; charIndex++) {
    if (operationChars.contains(expression[charIndex])) {
      if (expression[charIndex] == '/' && leftOperand == null) {
        operatorIndex = charIndex;
        if (leftStringOperand != '' && leftOperand == null) {
          leftOperand  = double.parse(leftStringOperand);
          leftDivisionIndex =  (operatorIndex - leftStringOperand.length);
        }
      } else {
        if (leftOperand != null) {
          rightOperand  = double.parse(rightStringOperand);
          rightDivisionIndex =  (operatorIndex + leftStringOperand.length);
        }
      }
    } else {
      if (leftStringOperand == '' || (leftStringOperand != '' && leftOperand == null)) {
        leftStringOperand += expression[charIndex];
      } else {
        if (rightStringOperand == '' || (rightStringOperand != '' && rightOperand == null)) {
          rightStringOperand += expression[charIndex];
        }
      }
      if (charIndex == (expression.runes.length - 1)) {
        rightOperand ??= double.parse(rightStringOperand);
        rightDivisionIndex =  (operatorIndex + leftStringOperand.length);
      }
    }
  }
  if (leftOperand != null && rightOperand != null) {
    int leftIndexControl  = (leftStringOperand.length - 2 );
    expression = expression.replaceRange(leftDivisionIndex, (leftIndexControl <= -1
        ? rightDivisionIndex + (leftIndexControl + 2)
        :rightDivisionIndex - leftIndexControl),
        (leftOperand/rightOperand).toString());
  }
  if (expression.contains('/') && externalOrderControl == false) {
    expression = doDivisionOperations(expression);
  }

  return expression;
}

String doMultiplicationOperations(String expression,
    {externalOrderControl = false}) {
  String leftStringOperand = '';
  String rightStringOperand = '';
  double? leftOperand;
  int operatorIndex = 0;
  double? rightOperand;
  int leftDivisionIndex = 0;
  int rightDivisionIndex = 0;


  for (int charIndex = 0; charIndex < expression.runes.length; charIndex++) {
    if (operationChars.contains(expression[charIndex])) {
      if (expression[charIndex] == '*' && leftOperand == null) {
        operatorIndex = charIndex;
        if (leftStringOperand != '' && leftOperand == null) {
          leftOperand  = double.parse(leftStringOperand);
          leftDivisionIndex =  (operatorIndex - leftStringOperand.length);
        }
      } else {
        if (leftOperand != null) {
          rightOperand  = double.parse(rightStringOperand);
          rightDivisionIndex =  (operatorIndex + leftStringOperand.length);
        }
      }
    } else {
      if (leftStringOperand == '' || (leftStringOperand != '' && leftOperand == null)) {
        leftStringOperand += expression[charIndex];
      } else {
        if (rightStringOperand == '' || (rightStringOperand != '' && rightOperand == null)) {
          rightStringOperand += expression[charIndex];
        }
      }
      if (charIndex == (expression.runes.length - 1)) {
        rightOperand ??= double.parse(rightStringOperand);
        rightDivisionIndex =  (operatorIndex + leftStringOperand.length);
      }
    }
  }
  if (leftOperand != null && rightOperand != null) {
    int leftIndexControl  = (leftStringOperand.length - 2 );
    expression = expression.replaceRange(leftDivisionIndex, (leftIndexControl <= -1
        ? rightDivisionIndex + (leftIndexControl + 2)
        :rightDivisionIndex - leftIndexControl),
        (leftOperand * rightOperand).toString());
  }
  if (expression.contains('*') && externalOrderControl == false) {
    expression = doMultiplicationOperations(expression);
  }

  return expression;
}
String doAddOperations(String expression, {externalOrderControl = false}) {
  String leftStringOperand = '';
  String rightStringOperand = '';
  double? leftOperand;
  int operatorIndex = 0;
  double? rightOperand;
  int leftDivisionIndex = 0;
  int rightDivisionIndex = 0;


  for (int charIndex = 0; charIndex < expression.runes.length; charIndex++) {
    if (operationChars.contains(expression[charIndex])) {
      if (expression[charIndex] == '+' && leftOperand == null) {
        operatorIndex = charIndex;
        if (leftStringOperand != '' && leftOperand == null) {
          leftOperand  = double.parse(leftStringOperand);
          leftDivisionIndex =  (operatorIndex - leftStringOperand.length);
        }
      } else {
        if (leftOperand != null) {
          rightOperand  = double.parse(rightStringOperand);
          rightDivisionIndex =  (operatorIndex + leftStringOperand.length);
        }
      }
    } else {
      if (leftStringOperand == '' || (leftStringOperand != '' && leftOperand == null)) {
        leftStringOperand += expression[charIndex];
      } else {
        if (rightStringOperand == '' || (rightStringOperand != '' && rightOperand == null)) {
          rightStringOperand += expression[charIndex];
        }
      }
      if (charIndex == (expression.runes.length - 1)) {
        rightOperand ??= double.parse(rightStringOperand);
        rightDivisionIndex =  (operatorIndex + leftStringOperand.length);
      }
    }
  }
  if (leftOperand != null && rightOperand != null) {
    int leftIndexControl  = (leftStringOperand.length - 2 );
    expression = expression.replaceRange(leftDivisionIndex, (leftIndexControl <= -1
        ? rightDivisionIndex + (leftIndexControl + 2)
        :rightDivisionIndex - leftIndexControl),
        (leftOperand + rightOperand).toString());
  }
  if (expression.contains('+') && externalOrderControl == false) {
    expression = doAddOperations(expression);
  }

  return expression;
}

String doSubOperations(String expression, {externalOrderControl = false}) {
  String leftStringOperand = '';
  String rightStringOperand = '';
  double? leftOperand;
  int operatorIndex = 0;
  double? rightOperand;
  int leftDivisionIndex = 0;
  int rightDivisionIndex = 0;


  for (int charIndex = 0; charIndex < expression.runes.length; charIndex++) {
    if (operationChars.contains(expression[charIndex])) {
      if (expression[charIndex] == '-' && leftOperand == null) {
        operatorIndex = charIndex;
        if (leftStringOperand != '' && leftOperand == null) {
          leftOperand  = double.parse(leftStringOperand);
          leftDivisionIndex =  (operatorIndex - leftStringOperand.length);
        }
      } else {
        if (leftOperand != null) {
          rightOperand  = double.parse(rightStringOperand);
          rightDivisionIndex =  (operatorIndex + leftStringOperand.length);
        }
      }
    } else {
      if (leftStringOperand == '' || (leftStringOperand != '' && leftOperand == null)) {
        leftStringOperand += expression[charIndex];
      } else {
        if (rightStringOperand == '' || (rightStringOperand != '' && rightOperand == null)) {
          rightStringOperand += expression[charIndex];
        }
      }
      if (charIndex == (expression.runes.length - 1)) {
        rightOperand ??= double.parse(rightStringOperand);
        rightDivisionIndex =  (operatorIndex + leftStringOperand.length);
      }
    }
  }
  if (leftOperand != null && rightOperand != null) {
    int leftIndexControl  = (leftStringOperand.length - 2 );
    expression = expression.replaceRange(leftDivisionIndex, (leftIndexControl <= -1
        ? rightDivisionIndex + (leftIndexControl + 2)
        :rightDivisionIndex - leftIndexControl),
        (leftOperand - rightOperand).toString());
  }
  if (expression.contains('-') && externalOrderControl == false) {
    expression = doSubOperations(expression);
  }

  return expression;
}
String doInOrderLevel2 (String expression) {
  for (int index = 0; index < expression.length; index++) {
    if (expression[index] == '*') {
      expression = doMultiplicationOperations(expression,externalOrderControl: true);
    }
    if (expression[index] == '/') {
      expression = doDivisionOperations(expression,externalOrderControl: true);
    }
  }
  if (expression.contains('*') || expression.contains('/')) {
    expression = doInOrderLevel2(expression);
  }
  return expression;
}
String doInOrderLevel1 (String expression) {
  for (int index = 0; index < expression.length; index++) {
    if (expression[index] == '+') {
      expression = doAddOperations(expression,externalOrderControl: true);
    }
    if (expression[index] == '-') {
      expression = doSubOperations(expression,externalOrderControl: true);
    }
  }
  if (expression.contains('-') || expression.contains('+')) {
    expression = doInOrderLevel2(expression);
  }
  return expression;
}