import 'dart:math' as math;
List<Map<String, dynamic>> calculateBalance(List<Map<String, dynamic>> data) {
  double balance = 0.0;
  final result = data.map((item) {
    final newItem = Map<String, dynamic>.from(item);
    newItem['balance'] = balance + item['amount'];
    balance = newItem['balance'];
    return newItem;
  }).toList();
  return result;
}

// Individual Transaction Total Calculation
Map<String, dynamic> ittCalculation(List<Map<String, dynamic>> dateWiseTransaction, List<Map<String, dynamic>> financialTransaction) {
  double balanceResultOne = 0.0;
  double balanceResultTwo = 0.0;
  double totalDebit = 0.0;
  double totalCredit = 0.0;

  final resultOne = dateWiseTransaction.map((item) {
    final newItem = Map<String, dynamic>.from(item);
    totalDebit = totalDebit + item['debit'];
    totalCredit = totalCredit + item['credit'];
    balanceResultOne = balanceResultOne + item['balance'];
    return newItem;
  }).toList();

  final resultTwo = financialTransaction.map((item) {
    final newItem = Map<String, dynamic>.from(item);
    balanceResultTwo = balanceResultTwo + (item['debit'] + item['credit']);
    return newItem;
  }).toList();

  double balance = balanceResultOne + balanceResultTwo;
  Map<String, dynamic> resultData = {
    'total': balance,
    'totalDebit': totalDebit,
    'totalCredit': totalCredit,
  };
  return resultData;
}
