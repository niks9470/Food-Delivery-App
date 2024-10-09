import 'package:flutter/material.dart';
import 'package:zwiggy/widget/widget_support.dart';

class Termsandconditions extends StatefulWidget {
  const Termsandconditions({super.key});

  @override
  State<Termsandconditions> createState() => _TermsandconditionsState();
}

class _TermsandconditionsState extends State<Termsandconditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.only(top: 40,),
              child:
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                Material(
                    elevation: 5,
                    child: Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Center(
                            child: Text(
                          "Terms and Conditions",
                          style:TextStyle(color: Colors.red,fontSize: 25,fontFamily: "Poppins")
                        )))),
                        Material(
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Last Updated:27/09/2024\n",style: TextStyle(color: Colors.green,fontSize: 20),),
                                Text("Welcome to Zwiggy,you agree to comply with and be bound by the following terms and conditions. Please read them carefully before using the App.",style: AppWidget.semiboldTextFieldStyle(),)
                              ],
                            ),
                          ),
                        ),SizedBox(height: 20,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                                   Text("1.Acceptance of Terms\nBy using our App, you agree to these Terms and Conditions, as well as any u"
                                  "pdates or changes made from time to time. If you do not agree with any part of these"
                                  " terms, you should stop using the App immediately.",style: TextStyle(fontSize: 20),),
                              SizedBox(height: 10,),
                              Text("2. Eligibility\n You must be at least 18 years old and have the legal capacity to enter into contracts to use the App. If you are under 18, your use of the App must be supervised by a parent or legal guardian",style: TextStyle(fontSize: 20),),
                              SizedBox(height: 10,),Text("3. Account Registration\n To use certain features of the App, you must create an account. You agree to: Provide accurate and complete information during the registration process. Keep your login credentials secure and confidential. Notify us immediately if you suspect any unauthorized use of your account.",style: TextStyle(fontSize: 20),),
                              SizedBox(height: 10,),Text("4. Ordering and Payment\n Placing Orders When placing an order through the App, you agree that all information provided (such as delivery address and payment details) is accurate. Once an order is placed, it cannot be canceled or modified unless permitted by the restaurant or service provider.",style: TextStyle(fontSize: 20)),
                              SizedBox(height: 10,), Text("5. Delivery and Pick-Up \nDelivery times provided are estimates and may vary due to traffic, weather conditions, or restaurant preparation time. If you have any special instructions or requests, you must include them when placing your order. We are not responsible for any errors or issues related to incomplete or unclear instructions. You agree to be available to accept the order at the specified delivery location. If you are not present, the order may be left at the delivery location or returned, depending on the restaurant’s policies. Additional fees may apply for re-delivery attempts.",style: TextStyle(fontSize: 20),),
                              SizedBox(height: 10,),Text("6. User Conduct \nYou agree to use the App for lawful purposes only. You must not: Engage in any fraudulent, illegal, or abusive behavior. Impersonate any person or entity or misrepresent your identity. Use the App to send unsolicited messages or spam. Interfere with or disrupt the App’s security or functionality.",style: TextStyle(fontSize: 20),)
                            ],
                          ),
                        )
                        ,
            ]
                  )
          ),
        ),
      
    );
  }
}
