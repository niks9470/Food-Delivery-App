import 'package:flutter/material.dart';
import 'package:zwiggy/service/database.dart';
import 'package:zwiggy/service/shared_preference.dart';
import 'package:zwiggy/widget/widget_support.dart';

class Details extends StatefulWidget {
  String image,name,details,price;
  Details({required this.details,
    required this.name,
    required this.image,
    required this.price});
  // const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a=1,total=0;
  String? id;
  getthesharepref()async{
    id  =await SharedPreferenceHelper().getUserId();
    setState(() {

    });
  }
  ontheload()async{
    await getthesharepref();
    setState(() {

    });
  }
  @override
  void initState() {
    super.initState();
    ontheload();
    total=int.parse(widget.price);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 10, top: 40,right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                )),
            ClipRRect(
               borderRadius: BorderRadius.circular(10),
              child: Image.network(
               widget.image,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.2,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name, style: AppWidget.headlineTextFieldStyle(),
                    ),

                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    if(a>1) {
                      --a;
                      total=total-int.parse(widget.price);
                    }
                    setState(() {
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black
                    ),
                    margin: EdgeInsets.only(right: 10 ),
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),SizedBox(width: 10,),
                Text(a.toString(),style: AppWidget.semiboldTextFieldStyle(),),
                SizedBox(width: 20,),
                GestureDetector(
                  onTap: (){
                    ++a;
                    total=total+int.parse(widget.price);
                    setState(() {

                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black
                    ),
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),SizedBox(height: 20,),
            Text(widget.details,style: AppWidget.lightTextFieldStyle(),maxLines: 3,),
            SizedBox(height: 20 ,),
            Row(
              children: [
                Text("Delivery Time",style: AppWidget.boldTextFieldStyle(),),
                SizedBox(width: 15,),Icon(Icons.alarm,color: Colors.black38,),
                SizedBox(width: 5,),
                Text("30 min",style: AppWidget.semiboldTextFieldStyle(),),
                
              ],
            ),
            Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total price",style: AppWidget.boldTextFieldStyle(),),

                        Text("₹"+total.toString(),style: AppWidget.boldTextFieldStyle(),),

                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10,),
                      padding: EdgeInsets.only(right: 10,left: 10,top: 8,bottom: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                          color: Colors.black),
                      child: Row(
                        children: [
                          GestureDetector(onTap:
                          ()async{
                            Map<String,dynamic> addFoodtoCart=
                            { "Name":widget.name,
                              "Quantity":a.toString(),
                              "Total":total.toString(),
                              "Image":widget.image
                            };
                            await DatabaseMethods().addFoodtoCart(addFoodtoCart,id! );
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.deepOrangeAccent,
                                content: Text("Food added to cart",style: TextStyle(color: Colors.white,fontSize: 24),)));

                          }
                            ,child: Container(
                                child: Text("Add to Cart",
                                    style: TextStyle(color: Colors.white,
                                        fontSize: 18,fontFamily: "Poppins"))),
                          ),
                          SizedBox(width: 30,),
                          Container(
                            padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.grey),
                              
                              child: Icon(Icons.shopping_cart_outlined,color: Colors.white,))
                        ],
                      ),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
