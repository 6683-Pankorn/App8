import 'package:flutter/material.dart';
import 'package:flutter_application_8/screen/form_screen.dart';
import 'package:flutter_application_8/model/transaction.dart';
import 'package:flutter_application_8/model/transaction_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return TransactionProvider();
          },
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MyHomePage(title: 'แอปรายจ่าย'),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return FormScreen();
                  },
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Consumer(
        builder: (context, TransactionProvider provider, child) {
          var count = provider.transactions.length;
          if (count <= 0) {
            return Center(
              child: Text(
              "ไม่พบข้อมูล",
              style: TextStyle(fontSize: 35),
              ));
          }else{
          return ListView.builder(
            itemCount: provider.transactions.length,
            itemBuilder: (context, int index) {
              Transactions data = provider.transactions[index];
              return Card(
                elevation: 5,
                //margin: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: FittedBox(child: Text(data.amount.toString())),
                  ),
                  title: Text(data.title),
                  subtitle: Text(
                    DateFormat("dd/MM/yyyy HH:mm:ss").format(data.date),
                  ),
                ),
              );
            },
          );
          }
        },
      ),
    );
  }
}
