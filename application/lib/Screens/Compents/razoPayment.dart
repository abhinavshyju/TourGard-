import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Razopayment extends StatefulWidget {
  var amount;

  Razopayment({Key? key, required this.amount}) : super(key: key);

  @override
  State<Razopayment> createState() => _RazopaymentState();
}

class _RazopaymentState extends State<Razopayment> {
  late Razorpay _razorpay;
  String mobileNumber = "";

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentErrorResponse);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccessResponse);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWalletSelected);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentErrorResponse(PaymentFailureResponse response) {
    _showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void _handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    _showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void _handleExternalWalletSelected(ExternalWalletResponse response) {
    _showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void _showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _openRazorpay();
      },
      child: Text("Pay with Razorpay"),
    );
  }

  void _openRazorpay() {
    var options = {
      'key': 'rzp_test_8z7EgAqRpaW1i1',
      'amount': widget.amount,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
    };
    _razorpay.open(options);
  }

  void _linkNewUpiAccount() {
    // Use mobileNumber variable to link new UPI account
  }

  void _manageUpiAccounts() {
    // Use mobileNumber variable to manage UPI accounts
  }
}
