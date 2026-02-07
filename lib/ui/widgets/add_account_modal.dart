import 'package:banco_douro/services/account_service.dart';
import 'package:banco_douro/ui/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../models/account.dart';

class AddAccountModal extends StatefulWidget {
  const AddAccountModal({super.key});

  @override
  State<AddAccountModal> createState() => _AddAccountModalState();
}

class _AddAccountModalState extends State<AddAccountModal> {
  String _accountType = "AMBROSIA";

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    print("Simulando operação demorada...");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 32,
        right: 32,
        top: 32,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: AppColor.lighOrange,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.75,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("assets/images/icon_add_account.png", height: 70),
            SizedBox(height: 32),
            Text(
              "Adicionar Nova Conta",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 16),
            Text(
              "Preencha os dados abaixo.",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                label: Text("Nome", style: TextStyle(fontSize: 14)),
              ),
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: InputDecoration(
                label: Text("Último Nome", style: TextStyle(fontSize: 14)),
              ),
            ),
            SizedBox(height: 16),
            Text("Tipo de Conta", style: TextStyle(fontSize: 14)),
            DropdownButton<String>(
              value: _accountType,
              isExpanded: true,
              items: [
                DropdownMenuItem(value: "AMBROSIA", child: Text("Ambrosia")),
                DropdownMenuItem(value: "CANJICA", child: Text("Canjica")),
                DropdownMenuItem(value: "PUDIM", child: Text("Pudim")),
                DropdownMenuItem(
                  value: "BRIGADEIRO",
                  child: Text("Brigadeiro"),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _accountType = value;
                  });
                }
              },
            ),
            SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: (isLoading)
                        ? null
                        : () {
                            onButtonCancelClicked();
                          },
                    child: Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      onButtonSendClicked();
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(AppColor.orange),
                    ),
                    child: (isLoading)
                        ? SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                              color: Colors.white, 
                            ),
                        )
                        : Text(
                            "Adicionar",
                            style: TextStyle(color: Colors.black,),
                            
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  onButtonCancelClicked() {
    if (!isLoading) Navigator.pop(context);
  }

  onButtonSendClicked() {
    if (isLoading) return;
    setState(() => isLoading = true);

    String name = _nameController.text;
    String lastName = _lastNameController.text;

    Account account = Account(
      id: Uuid().v1(),
      name: name,
      lastName: lastName,
      accountType: _accountType,
      balance: 0.0,
    );

    AccountService().addAccount(account);

    closeModal();
  }

  closeModal(){
    Navigator.pop(context);
  }
}
