import 'package:banco_douro/models/account.dart';

import '../enums/enAccountType.dart';

double calculateTaxesByAccount({
  required Account sender,
  required double amount,
}) {
  if (amount < 5000) return 0.0;

  if (sender.accountType != null) {
    if (sender.accountType!.toUpperCase() == AccountType.AMBROSIA.name) {
      return amount * 0.005;
    } else if (sender.accountType!.toUpperCase() == AccountType.CANJICA.name) {
      return amount * 0.0033;
    } else if (sender.accountType!.toUpperCase() == AccountType.PUDIM.name) {
      return amount * 0.0025;
    } else {
      return amount * 0.0001;
    } // É BRIGADEIRO
  }

  return 0.1;
}
