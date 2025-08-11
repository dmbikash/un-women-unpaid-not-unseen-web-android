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

Future<dynamic> taskModal(String message, var id, BuildContext context,
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
            constraints: BoxConstraints(maxWidth: 600),
            width: double.infinity,

            padding: EdgeInsets.only(left: 10,right: 10, top: 10,bottom: 5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2.5),
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                /// modal top bar
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.92,
                  // Match card width
                  height: MediaQuery.of(context).size.height * 0.07,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        spreadRadius: 1,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/logo/unpaid_not_unseen.png',

                        fit: BoxFit.contain,

                      ),

                      Expanded(

                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                            "assets/logo/un_woman.png",
                            // height: 50,
                            // width: 45,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                /// from param
                ...children,

                // SizedBox(
                //   height: 20,
                // ),
                // ///  bottom buttons
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     ElevatedButton(
                //         style: OutlinedButton.styleFrom(
                //           backgroundColor: Colors.redAccent,
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(16), // Optional rounded corners
                //           ),
                //         ),
                //         onPressed: (){
                //
                //           Navigator.pop(context);
                //         }, child: Text("Cancel",style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),))  ,
                //     ElevatedButton(
                //         style: OutlinedButton.styleFrom(
                //           backgroundColor: AppColors.white,
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(16), // Optional rounded corners
                //           ),
                //         ),
                //         onPressed: (){
                //
                //       Navigator.pop(context);
                //     }, child: Text("Submit",style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),))  ,
                //
                //
                //   ],
                //
                // ),
                // SizedBox(
                //   height: 10,
                // ),
              ],
            ),
          ),
        );
      });
}