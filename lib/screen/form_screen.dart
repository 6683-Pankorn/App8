import 'package:flutter/material.dart';
import 'package:flutter_application_8/model/transaction.dart';
import 'package:flutter_application_8/model/transaction_provider.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Title')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: new InputDecoration(labelText: "ชื่อรายการ"),
                autofocus: true,
                controller: titleController,
                validator: (String? str) {
                  if (str == '') return "กรุณาป้อนชื่อรายการ";
                  return null;
                },
              ),
              TextFormField(
                decoration: new InputDecoration(labelText: "จํานวนเงิน"),
                keyboardType: TextInputType.number,
                controller: amountController,
                validator: (String? str) {
                  if (str!.isEmpty) return "กรุณาป้อนจำนวนเงิน";
                  if (double.parse(str.toString()) <= 0)
                    return "กรุณาป้อนจำนวนเงินมากกว่า 0";
                  return null;
                },
              ),
              TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    var title = titleController.text;
                    var amount = amountController.text;
                    Transactions statement = Transactions(
                      title: title,
                      amount: double.parse(amount),
                      date: DateTime.now(),
                    );
                    var provider = Provider.of<TransactionProvider>(
                      context,
                      listen: false,
                    );
                    provider.addTransaction(statement);
                    Navigator.pop(context);
                  }
                },
                style: TextButton.styleFrom(
                  textStyle: TextStyle(fontSize: 20),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                ),
                child: Text("บันทึก"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
