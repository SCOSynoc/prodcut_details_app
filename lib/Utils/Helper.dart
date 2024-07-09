import 'package:flutter/cupertino.dart';

class Helper {
   static int crossAxisCount({required BuildContext context}){
      if(MediaQuery.of(context).size.width > 1000) {
        return 4;
      } else if (MediaQuery.of(context).size.width > 750){
        return 3;
      }else{
        return 2;
      }
   }
}