import 'package:expence_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<transaction> transactions;
  Function DeleteTran;
  TransactionList(this.transactions, this.DeleteTran);
  @override
  Widget build(BuildContext context) {
    //list of the transaction and the implimentation
    return  transactions.isEmpty
          ? LayoutBuilder(builder: (ctx,constrains){
            return Column(
              children: <Widget>[
                const Text(
                  'No transaction added yet!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: constrains.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: FittedBox(
                          child: Text('\$${transactions[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      //  Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                   trailing: MediaQuery.of(context).size.width > 460
                      ? TextButton.icon(
                        
                          icon: Icon(Icons.delete), 
                           
                          label: Text(
                            'delete',
                            style: TextStyle(color: Colors.red),
                          ),   
                          
                          onPressed:()=>DeleteTran(transactions[index].id), 
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed:()=>DeleteTran(transactions[index].id), 
                    ),
                  ),
          );
              },
              itemCount: transactions.length,
            
    );
  }
}
