import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';

import '../exceptions/transaction_exceptions.dart';
import '../helpers/helper_taxes.dart';
import '../models/account.dart';
import '../models/transaction.dart';
import 'account_service.dart';
import 'api_key.dart';

class TransactionService {
  final AccountService _accountService = AccountService();
  String url = "https://api.github.com/gists/53ee483863a7735c358f7c314e0b3ad3";

  Future<void> makeTransaction({
    required String idSender,
    required String idReceiver,
    required double amount,
  }) async {
    List<Account> listAccounts = await _accountService.getAll();

    if (listAccounts.where((account) => account.id == idSender).isEmpty) {
      throw SenderNotExistsException();
    }
    if (listAccounts.where((account) => account.id == idReceiver).isEmpty) {
      throw ReceiverNotExistsException();
    }

    Account senderAccount = listAccounts.firstWhere(
      (account) => account.id == idSender,
    );

    Account receiverAccount = listAccounts.firstWhere(
      (account) => account.id == idReceiver,
    );

    double taxes = calculateTaxesByAccount(
      sender: senderAccount,
      amount: amount,
    );

    print(senderAccount);
    print(receiverAccount);
    print(taxes);

    if (senderAccount.balance < (amount + taxes)) {
      throw InsufficientBalanceException(
        cause: senderAccount,
        amount: amount,
        taxes: taxes,
      );
    }

    senderAccount.balance -= (amount + taxes);
    receiverAccount.balance += amount;

    listAccounts[listAccounts.indexWhere(
          (account) => account.id == senderAccount.id,
        )] =
        senderAccount;

    listAccounts[listAccounts.indexWhere(
          (account) => account.id == receiverAccount.id,
        )] =
        receiverAccount;

    Transaction transaction = Transaction(
      id: (Random().nextInt(89999) + 10000).toString(),
      senderAccountId: senderAccount.id,
      receiverAccountId: receiverAccount.id,
      date: DateTime.now(),
      amount: amount,
      taxes: taxes,
    );

    await _accountService.save(listAccounts);
    await addTransaction(transaction);
  }

  Future<List<Transaction>> getAll() async {
    Response response = await get(Uri.parse(url));

    Map<String, dynamic> mapResponse = json.decode(response.body);
    List<dynamic> listDynamic = json.decode(
      mapResponse["files"]["accounts.json"]["content"],
    );

    List<Transaction> listTransaction = [];

    for (dynamic dyn in listDynamic) {
      Map<String, dynamic> mapTransaction = dyn as Map<String, dynamic>;
      Transaction transaction = Transaction.fromMap(mapTransaction);
      listTransaction.add(transaction);
    }
    return listTransaction;
  }

  addTransaction(Transaction transaction) async {
    List<Transaction> listTransactions = await getAll();
    print(listTransactions);
    listTransactions.add(transaction);
    save(listTransactions);
  }

  save(List<Transaction> listTransactions) async {
    List<Map<String, dynamic>> listContent = [];

    for (Transaction transaction in listTransactions) {
      listContent.add(transaction.toMap());
    }

    String content = json.encode(listContent);

    Response response = await post(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $githubApiKey"},
      body: json.encode({
        "description": "transactions.json",
        "public": true,
        "files": {
          "transactions.json": {"content": content},
        },
      }),
    );
  }
}
