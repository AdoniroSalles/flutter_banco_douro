import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import '../models/account.dart';
import 'api_key.dart';

class AccountService {
  final StreamController<String> _streamController = StreamController<String>();
  Stream<String> get streamInfo => _streamController.stream;
  String url = "https://api.github.com/gists/53ee483863a7735c358f7c314e0b3ad3";

  //Tratamento assincrono com async/await. Precisa esperar a resposta para continuar o código
  Future<List<Account>> getAll() async {
    // await usado sempre que tiver um Future. Pausa até esperar a resposta
    Response response = await get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $githubApiKey"},
    );
    _streamController.add(
      "${DateTime.now()}| Requisição de leitura (usando async/await).",
    );

    Map<String, dynamic> mapResponse = json.decode(response.body);
    List<dynamic> listDynamic = json.decode(
      mapResponse["files"]["accounts.json"]["content"],
    );
    List<Account> listAccount = [];

    for (dynamic dyn in listDynamic) {
      Map<String, dynamic> mapAccount = dyn as Map<String, dynamic>;
      Account account = Account.fromMap(mapAccount);
      listAccount.add(account);
    }
    return listAccount;
  }

  addAccount(Account account) async {
    List<Account> listAccounts = await getAll();
    listAccounts.add(account);
    save(listAccounts, accountName: account.name);
  }

  save(List<Account> listAccounts, {String accountName = ""}) async {
    List<Map<String, dynamic>> listContent = [];

    for (Account account in listAccounts) {
      listContent.add(account.toMap());
    }

    String content = json.encode(listContent);

    Response response = await post(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $githubApiKey"},
      body: json.encode({
        "description": "accounts.json",
        "public": true,
        "files": {
          "accounts.json": {"content": content},
        },
      }),
    );

    if (response.statusCode.toString()[0] == "2") {
      _streamController.add(
        "${DateTime.now()}| Requisição de adição  bem sucedida ($accountName).",
      );
    } else {
      _streamController.add(
        "${DateTime.now()}| Requisição de adição falhou ($accountName).",
      );
    }
  }
}
