class ParticularTransactionModel {
  final int? id;
  final int year;
  final String date;
  final double amount;
  final double balance;
  final String? payer;

  ParticularTransactionModel({
    this.id,
    required this.year,
    required this.date,
    required this.amount,
    required this.balance,
    this.payer,
  });

  factory ParticularTransactionModel.fromJson(Map<String, dynamic> json) => ParticularTransactionModel(
    id: json['id'],
    year: json['year'],
    date: json['date'],
    amount: json['amount'],
    balance: json['balance'],
    payer: json['payer'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'year': year,
    'date': date,
    'amount': amount,
    'balance': balance,
    'payer': payer,
  };
}