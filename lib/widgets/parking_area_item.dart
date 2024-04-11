
import 'package:flutter/material.dart';

class ParkingAreaItem extends StatelessWidget {
  bool isAvailable;
  int number;
  ParkingAreaItem({Key? key, required this.isAvailable,required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.28,
            width:  MediaQuery.of(context).size.width * 0.4,
            child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/background.png")
                    )
                  ),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.05),
                    child: isAvailable?Container():Image.asset("assets/car.png"),
                  ),
                )
            ),
          ),
          SizedBox(

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Text("P$number"),
                ),
                const SizedBox(width: 5,),
                ElevatedButton(

                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(isAvailable?Colors.green:Colors.grey)
                  ),
                    onPressed: (){}, child: Text(isAvailable?"Available":"Unavailable")),
              ],
            ),
          )
        ],

    );
  }
}
