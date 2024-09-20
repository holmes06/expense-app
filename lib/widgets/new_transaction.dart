import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  //statefull wigdet of the new transaction
  final Function addTx;

  const NewTransaction(this.addTx, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // ignore: non_constant_identifier_names
  final TitleController = TextEditingController();

  // ignore: non_constant_identifier_names
  final AmountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void addSubmitData() {
    if (AmountController.text.isEmpty) {
      return;
    }
    final enteredtitle = TitleController.text;
    final enteredamount = double.parse(AmountController.text);
    if (enteredtitle.isEmpty ||
        enteredamount <= 0 ||
        _selectedDate == null ||
        enteredamount == null) {
      return;
    }
    widget.addTx(enteredtitle, enteredamount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //text lable to write th name of the folder
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'title'),
                controller: TitleController, //keeping the name of the folder
                onSubmitted: (_) => addSubmitData(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: AmountController, //keeping folder info
                keyboardType: TextInputType.number,
                onSubmitted: (_) => addSubmitData(),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'NO date chosen!'
                            : DateFormat.yMd().format(_selectedDate),
                      ),
                    ),
                    TextButton(
                      onPressed: _presentDatePicker,
                      child: Text(
                        'chose date',
                        style: TextStyle(
                            color: Colors.purple, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: addSubmitData,
                child: const Text(
                  "Add transaction",
                  style: TextStyle(color: Colors.purple),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
