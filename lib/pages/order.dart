//import 'dart:nativewrappers/_internal/vm/lib/async_patch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zwiggy/service/database.dart';
import 'package:zwiggy/service/shared_preference.dart';
import 'package:zwiggy/widget/widget_support.dart';
import 'dart:async'as async;

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String? id,wallet;
  int total =0,amount2=0;
  void startTimer() {
    async.Timer(Duration(seconds: 1), () {
      amount2=total;
      setState(() {

        });
    });
  }

  getthesharedpref() async {
    id = await SharedPreferenceHelper().getUserId();
    wallet=await SharedPreferenceHelper().getUserWallet();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    foodStream = await DatabaseMethods().getFoodCart(id!);
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    startTimer();
    super.initState();
  }

  Stream? foodStream;
  Widget foodCart() {
    return StreamBuilder(
        stream: foodStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    total =total+int.parse(ds["Total"]);

                    return Container(
                      margin: EdgeInsets.only(left: 15,right: 15,bottom: 20),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 5,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              SizedBox(width: 5,),
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(11),
                                ),
                                child: Center(
                                    child: Text(
                                  ds["Quantity"],
                                  style: TextStyle(fontSize: 20),
                                )),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.network(
                                    ds["Image"],
                                    height: 90,
                                    width: 90,
                                    fit: BoxFit.cover,
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    ds["Name"],
                                    style: AppWidget.semiboldTextFieldStyle(),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                   "₹"+ ds["Total"],
                                    style: AppWidget.semiboldTextFieldStyle(),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50),
        child: Column(children: [
          Material(
              elevation: 5,
              child: Container(
                  child: Center(
                      child: Text(
                "Food cart",
                style: AppWidget.headlineTextFieldStyle(),
              )))),
          SizedBox(
            height: 20,
          ),
          Container(
              height: MediaQuery.of(context).size.height/1.7,
              child: foodCart()),
          Spacer(),
          Divider(thickness: 9,),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Price", style: AppWidget.boldTextFieldStyle()),
                Text("₹"+total.toString()+" Only", style: AppWidget.boldTextFieldStyle()),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: ()async{
int amount=int.parse(wallet!)-amount2;
await DatabaseMethods().updateUserwallet(id!, amount.toString());
await SharedPreferenceHelper().saveUserWallet(amount.toString());
ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.deepOrangeAccent,
    content: Text("Order Sucessfully",style: TextStyle(color: Colors.white,fontSize: 24),)));
            },
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20,
                  bottom: 20),
              padding: EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black),
              child: Center(
                  child: Text(
                "Order Now",
                style: TextStyle(
                    color: Colors.white, fontSize: 20,
                    fontFamily: "poppins"),
              )),
            ),
          )
        ]),
      ),
    );
  }
}
