enum STATUS {requested,accepted,declined,paid}

class Transaction {
  final String transactionRefId;
  final String custUpiId;
  final String merchantUpiId;
  final double amount;
  final int createdMillis;
  final bool onCredit;
  final STATUS credStatus;
  const Transaction({this.transactionRefId, this.custUpiId, this.merchantUpiId, this.amount, this.createdMillis,this.onCredit, this.credStatus});
}