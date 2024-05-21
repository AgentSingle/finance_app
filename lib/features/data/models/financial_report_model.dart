class FinancialReportModel {
  final int? id;
  final int year;
  final double debit;
  final double credit;

  FinancialReportModel({
    this.id,
    required this.year,
    required this.debit,
    required this.credit,
  });

  factory FinancialReportModel.fromJson(Map<String, dynamic> json) => FinancialReportModel(
    id: json['id'],
    year: json['year'],
    debit: json['debit'],
    credit: json['credit'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'year': year,
    'debit': debit,
    'credit': credit,
  };
}