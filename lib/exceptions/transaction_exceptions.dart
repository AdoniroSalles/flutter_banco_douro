import '../models/account.dart';

class SenderNotExistsException implements Exception{}

class ReceiverNotExistsException implements Exception{}

class InsufficientBalanceException implements Exception{
  String message; // Mensagem de erro personalizada
  Account cause;  //objeto causador da exceção
  double amount;  //informações especificas 
  double taxes;   //informações especificas

  InsufficientBalanceException({
    this.message = "Saldo insuficiente na conta remetente.",
    required this.cause,
    required this.amount,
    required this.taxes,
  });
}