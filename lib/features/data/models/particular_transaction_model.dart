class ParticularTransactionModel {
  final int? id;
  final int year;
  final String date;
  final double amount;
  final String? payer;

  ParticularTransactionModel({
    this.id,
    required this.year,
    required this.date,
    required this.amount,
    this.payer,
  });

  factory ParticularTransactionModel.fromJson(Map<String, dynamic> json) => ParticularTransactionModel(
    id: json['id'],
    year: json['year'],
    date: json['date'],
    amount: json['amount'],
    payer: json['payer'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'year': year,
    'date': date,
    'amount': amount,
    'payer': payer,
  };
}

class PTModelWithBalance {
  final int? id;
  final int year;
  final String date;
  final double amount;
  final double balance;
  final String? payer;

  PTModelWithBalance({
    this.id,
    required this.year,
    required this.date,
    required this.amount,
    required this.balance,
    this.payer,
  });

  factory PTModelWithBalance.fromJson(Map<String, dynamic> json) => PTModelWithBalance(
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

// Function to convert a map to PTModelWithBalance
PTModelWithBalance convertMapToModel(Map<String, dynamic> data){
  return PTModelWithBalance(
    id: data['id'] as int?,
    year: data['year'] as int,
    date: data['date'] as String,
    amount: data['amount'] as double,
    balance: data['balance'] as double, // Assuming balance might be null initially
    payer: data['payer'] as String?,
  );
}