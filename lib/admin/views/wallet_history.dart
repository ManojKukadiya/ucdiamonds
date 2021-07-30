import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ucdiamonds/models/transaction_model.dart';
import 'package:ucdiamonds/utilities/utility.dart';
import 'package:ucdiamonds/widgets/circle_loading.dart';

class AdminRedeemHistory extends StatelessWidget {
  final TranasctionType tranasctionType;
  AdminRedeemHistory({@required this.tranasctionType});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utilities.appBar(context, "Redeem Requests"),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("transactions")
              .doc(FirebaseAuth.instance.currentUser.uid)
              .collection("transactions")
              .where("type",
                  isEqualTo:
                      TranasctionType.REDEEM == tranasctionType ? "1" : "0")
              // .orderBy("timeStamp")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length == 0) {
                return Center(
                  child: Text("No Transactions found"),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return RedeemWalletTransactionItem(
                      transactionModel: TransactionModel.fromMap(
                          snapshot.data.docs[index].data()),
                    );
                  });
            }
            if (snapshot.hasError) {
              Utilities.showSnackBarScaffold(
                  context, snapshot.error.toString());
            }

            return MyCircleLoading();
          },
        ),
      ),
    );
  }
}

class RedeemWalletTransactionItem extends StatelessWidget {
  final TransactionModel transactionModel;
  RedeemWalletTransactionItem({@required this.transactionModel});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8),
        child: ListTile(
          title: Text(
            transactionModel.description ?? "Added",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          subtitle: Text(
            transactionModel.timeStamp ?? "",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          trailing: Text(
            transactionModel.amount.toString(),
            style: Theme.of(context).textTheme.headline6.copyWith(
                  color:
                      transactionModel.amount > 0 ? Colors.green : Colors.red,
                ),
          ),
        ),
      ),
    );
  }
}
