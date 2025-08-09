import 'package:flutter/material.dart';
import 'package:unwomen_unpaid_not_unseen/design/themes/colors.dart';

Future<dynamic> customPopUpModal(String message, var id, BuildContext context,
    {required List<Widget>children }) {

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,

          // title: const Center(child: Text("Warning!",
          //   style: TextStyle(
          //       color: Colors.red,
          //       fontWeight: FontWeight.w700
          //   ),
          // )),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          contentPadding: EdgeInsets.all(15),
          content: Container(
            width: double.infinity,

            padding: EdgeInsets.only(left: 10,right: 10, top: 10,bottom: 5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2.5),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)),
            child: Stack(
              alignment: Alignment.center,
              children: [

                Column(
                  children: [

                    Center(child: Icon(Icons.info_outline,color: AppColors.primary,),),
                    SizedBox(
                      height: 20,
                    ),


                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        message,

                        textAlign: TextAlign.center,
                        style:  TextStyle(fontSize: 17, fontWeight: FontWeight.w600,color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ...children,

                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       ElevatedButton(onPressed: (){
                         Navigator.pop(context);
                       }, child: Text("Okay"))
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      });
}