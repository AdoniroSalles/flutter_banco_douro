import 'dart:convert';

class Account {
  String id;
  String name;
  String lastName;
  double balance;
  String? accountType;

  Account({
    required this.id,
    required this.name,
    required this.lastName,
    required this.balance,
    required this.accountType,
  });

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map["id"],
      name: map["name"],
      lastName: map["lastName"],
      balance: map["balance"],
      accountType: (map["accountType"] != null) ? map["accountType"] as String : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "lastName": lastName,
      "balance": balance,
      'accountType': accountType,
    };
  }

  String toJson() => json.encode(toMap());

  Account copyWith({
    String? id,
    String? name,
    String? lastName,
    double? balance,
    String? accountType,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      balance: balance ?? this.balance,
      accountType: accountType ?? this.accountType,
    );
  }

  @override
  String toString() {
    return 'Conta $id: $name $lastName Saldo: $balance';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Account &&
        other.id == id &&
        other.name == name &&
        other.lastName == lastName &&
        other.balance == balance;
  }

// ^ bitwise XOR operator
  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ lastName.hashCode ^ balance.hashCode;
  }
}
