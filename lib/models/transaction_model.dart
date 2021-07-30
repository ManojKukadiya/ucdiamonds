import 'package:ucdiamonds/utilities/utility.dart';

class TransactionModel {
  var timeStamp;
  int amount;
  var description;
  String type;
  int status;

  TransactionModel(
      {this.timeStamp, this.amount, this.description, this.type, this.status});

  factory TransactionModel.fromMap(Map map) {
    return TransactionModel(
        timeStamp: map['timeStamp'],
        amount: map['amount'],
        description: map['description'],
        type: map['type'],
        status: map['status']);
  }

  toMap() {
    return {
      'timeStamp': Utilities.getTimeStamp(),
      'amount': amount,
      'description': description,
      'type': type,
      'status': status
    };
  }
}

enum TranasctionType {
  CAPTCHAPOINTADDED,
  REDEEM,
  REFERRAL,
  DAILYBONUS,
  TASKS,
  SPIN,
  SCRATCH,
}
enum TranasctionStatus { COMPLETED, PENDING }
