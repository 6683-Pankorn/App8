import 'package:flutter/foundation.dart';
import 'package:flutter_application_8/model/transaction.dart';

class TransactionProvider with ChangeNotifier {
  List<Transactions> transactions = [];

  List<Transactions> getTransaction() {
    return transactions;
  }

  void addTransaction(Transactions statement) {
    transactions.add(statement);
    //แจ้งเตือน Consumer
    notifyListeners();
  }
}
