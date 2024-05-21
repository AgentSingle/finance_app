class DateWiseTransactionModel {
  final int? id;
  final int year;
  final String date;
  final double debit;
  final double credit;
  final double balance;

  DateWiseTransactionModel({
    this.id,
    required this.year,
    required this.date,
    required this.debit,
    required this.credit,
    required this.balance,
  });

  factory DateWiseTransactionModel.fromJson(Map<String, dynamic> json) => DateWiseTransactionModel(
    id: json['id'],
    year: json['year'],
    date: json['date'],
    debit: json['debit'],
    credit: json['credit'],
    balance: json['balance'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'year': year,
    'date': date,
    'debit': debit,
    'credit': credit,
    'balance': balance,
  };
}