import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:zwiggy/service/database.dart';
import 'package:zwiggy/service/shared_preference.dart';
import 'package:zwiggy/widget/app_constant.dart';
import 'package:zwiggy/widget/widget_support.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  String? wallet,id;
  int? add;
  TextEditingController amountController=new TextEditingController();
  getthesharedpref()async{
    wallet =await SharedPreferenceHelper().getUserWallet();
    id= await SharedPreferenceHelper().getUserId();
    setState(() {

    });
  }
  ontheload()async{
    await getthesharedpref();
    setState(() {

    });
  }
  @override
  void initState() {
    ontheload();
    super.initState();
  }
  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: wallet==null? CircularProgressIndicator():  Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
                elevation: 5,
                child: Container(
                    child: Center(
                        child: Text(
                          "Wallet",
                          style: AppWidget.headlineTextFieldStyle(),
                        )))),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: BoxDecoration(color: Color(0xfff2f2f2)),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/wallet.png",
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Wallet",
                        style: AppWidget.lightTextFieldStyle(),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "₹"+wallet!,
                        style: AppWidget.boldTextFieldStyle(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Add money",
                style: AppWidget.boldTextFieldStyle(),
              ),
            ), SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Padding(padding: EdgeInsets.all(5)),
                GestureDetector(
                  onTap: (){
                    makePayment("100");
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffe9e2e2)),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text(
                      "₹""100", style: AppWidget.semiboldTextFieldStyle(),),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    makePayment("150");
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),

                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffe9e2e2)),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text(
                      "₹""150", style: AppWidget.semiboldTextFieldStyle(),),
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    makePayment("500");
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),

                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffe9e2e2)),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text(
                      "₹""500", style: AppWidget.semiboldTextFieldStyle(),),
                  ),
                ),

                GestureDetector(
                  onTap: (){
                    makePayment("1000");
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),

                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffe9e2e2)),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text(
                      "₹""1000", style: AppWidget.semiboldTextFieldStyle(),),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: (){
                openEdit();
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                padding: EdgeInsets.symmetric(vertical: 12),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xff008080)
                ),
                child: Center(child: Text("Add money",
                  style: AppWidget.boldTextFieldStyle(),)),

              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, "INR");
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!["client_secret"],
              style: ThemeMode.dark,
              merchantDisplayName: "Nikhil"
          )).then((value) {});

      displayPaymentSheet(amount);
    } catch (e, s) {
      print("exception:$e$s");
    }
  }

  displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {

        add =int.parse(wallet!)+int.parse(amount);
        await SharedPreferenceHelper().saveUserWallet(add.toString());
        await DatabaseMethods().updateUserwallet(id!, add.toString());

        showDialog(
            context: context,
            builder: (_) =>
                AlertDialog(content:
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle,
                          color: Colors.green,
                        ),
                        Text("Payment Sucessfull")
                      ],
                    )
                  ],
                ),
                ));

        await getthesharedpref();

        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) =>
          const AlertDialog(
            content: Text("Cancelled"),
          ));
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $seceretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;

    return calculatedAmout.toString();
  }
  Future openEdit()=>showDialog(context: context, builder: (context)=>AlertDialog(
    content: SingleChildScrollView(
      child:Container(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                    child
                    : Icon(Icons.cancel)),
                SizedBox(width: 60,),
                Center(child: Text("Add Money",style:
                TextStyle(color: Color(0xff008080),
                    fontWeight: FontWeight.bold),))
              ],
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black38,width: 2),
               borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: amountController,
                decoration: InputDecoration(
                  border:InputBorder.none,hintText: "Enter amount"
                ),
              )

            ),
            SizedBox(height: 20,),
            Center(
              child: GestureDetector(
                onTap: (){
                 Navigator.pop(context);
                 makePayment(amountController.text);
                },
                child: Container(
                  width: 100,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xff008080),
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Center(child: Text("Pay",style: TextStyle(color: Colors.white),))),
              ),
            ),

          ],
        ),
      ),

    ),
  ));
}


