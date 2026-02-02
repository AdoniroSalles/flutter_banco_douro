import 'package:banco_douro/models/account.dart';
import 'package:banco_douro/ui/styles/colors.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatelessWidget {
  final Account account;
  //precisa receber uma conta para exibir os dados
  const AccountWidget({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColor.lighOrange,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${account.name} ${account.lastName}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text("ID: ${account.id}"),
              Text("Saldo: ${account.balance.toStringAsFixed(2)}"),
              Text("Tipo: ${account.accountType ?? "Não informado"}"),
            ],
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        ],
      ),
    );
  }
}
