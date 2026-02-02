import 'package:banco_douro/models/account.dart';
import 'package:banco_douro/services/account_service.dart';
import 'package:banco_douro/ui/styles/colors.dart';
import 'package:banco_douro/ui/widgets/account_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.lightGray,
        title: Text("Sistema de Gestão de Contas"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "login");
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: AccountService().getAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                {
                  if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return Center(child: Text("Nenhuma conta encontrada"));
                  } else {
                    List<Account> accounts = snapshot.data!;
                    return ListView.builder(
                      itemCount: accounts.length,
                      itemBuilder: (context, index) {
                        Account account = accounts[index];
                        return AccountWidget(account: account);
                      },
                    );
                  }
                }
            }
          },
        ),
      ),
    );
  }
}
