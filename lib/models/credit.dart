enum STATUS {requested,accepted,declined,paid}

class Credit {
  final String creditRefId;
  final String custUpiId; //payer's id
  final String merchantUpiId;
  final double amount;
  final int createdMillis;
  final STATUS credStatus;
  const Credit({this.creditRefId, this.custUpiId, this.merchantUpiId, this.amount, this.createdMillis, this.credStatus});
}