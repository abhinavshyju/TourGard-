import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentRequest extends StatefulWidget {
  final String name;
  var amount;
  final int id;

  var number;

  var paymentid;

  PaymentRequest(
      {Key? key,
      required this.name,
      required this.amount,
      required this.id,
      required this.paymentid,
      required this.number})
      : super(key: key);

  @override
  State<PaymentRequest> createState() => _PaymentRequestState();
}

class _PaymentRequestState extends State<PaymentRequest> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Trip is completed make the payment.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Guide name: ",
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Amount: ",
                    style: TextStyle(fontSize: 14),
                  ),
                  Icon(
                    Icons.currency_rupee,
                    size: 14,
                  ),
                  Text(
                    "${widget.amount}",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              Razopayment(
                amount: widget.amount,
                number: widget.number,
                payment_id: widget.paymentid,
                trip_id: widget.id,
              )
            ],
          ),
          Container(
            width: double.infinity,
            height: 1,
            decoration: BoxDecoration(color: Colors.grey),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class Razopayment extends StatefulWidget {
  var amount;

  var number;

  var trip_id;

  var payment_id;

  Razopayment(
      {Key? key,
      required this.amount,
      required this.number,
      required this.trip_id,
      required this.payment_id})
      : super(key: key);

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

  void _handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    _showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
    await dotenv.load(fileName: "lib/.env");
    var api = dotenv.env["VAR_API"];
    final dio = Dio();
    final url = "$api/request/complete";
    try {
      final Response respones = await dio.post(url,
          data: {"id": widget.trip_id, "payment_id": widget.payment_id});
      if (respones.statusCode == 200) {
        print("Request accepted");
      }
    } catch (e) {
      print(e);
    }
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
      child: Text("Pay"),
    );
  }

  void _openRazorpay() {
    var options = {
      'key': 'rzp_test_8z7EgAqRpaW1i1',
      'amount': (widget.amount *
          100), // Amount should be in smallest currency unit (e.g., paise for INR)
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '${widget.number}', 'email': 'test@razorpay.com'},
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
