class Transaction {
  String id;
  String senderAccountId;
  String receiverAccountId;
  DateTime date;
  double amount;
  double taxes;


  Transaction({
    required this.id,
    required this.senderAccountId,
    required this.receiverAccountId,
    required this.date,
    required this.amount,
    required this.taxes,
  });

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map["id"],
      senderAccountId: map["senderAccountId"] as String,
      receiverAccountId: map["receiverAccountId"] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map["date"] as int),
      amount: map["amount"] as double,
      taxes: map["taxes"] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "senderAccountId": senderAccountId,
      "receiverAccountId": receiverAccountId,
      "date": date.millisecondsSinceEpoch,
      "amount": amount,
      "taxes": taxes,
    };
  }

  Transaction copyWith({
    String? id,
    String? senderAccountId,
    String? receiverAccountId,
    DateTime? date,
    double? amount,
    double? taxes,
  }) {
    return Transaction(
      id: id ?? this.id,
      senderAccountId: senderAccountId ?? this.senderAccountId,
      receiverAccountId: receiverAccountId ?? this.receiverAccountId,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      taxes: taxes ?? this.taxes,
    );
  }


}
