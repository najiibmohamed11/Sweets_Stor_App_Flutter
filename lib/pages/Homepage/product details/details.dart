import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 400,
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.vertical(
                    bottom: Radius.circular(200.0)),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFF9CBDF), // #F9CBDF
                    Color.fromARGB(255, 216, 217, 225), // #EBE4F5
                  ],
                  stops: [0.1, 0.4],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.arrow_back_ios),
                            Spacer(),
                            Icon(Icons.favorite_border)
                          ],
                        ),
                        Container(
                          width: 300,
                          height: 300,
                          child: Image.asset("images/strawberry_blast.webp"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pink Donuts",
                    style:
                        TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Sugar,flour,butter,strowbery jam,pink glazo",
                    style: TextStyle(letterSpacing: 2.0),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "⭐ 5.0",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        "🔥 560 cal",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        "⏰ 5-10minuts",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: 350.0,
                    child: Text(
                      "the sweet and juicy combo of pink glaze and strawberry jam. introduce with the pink Donut as soon as possible",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "\$5.0",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                        ),
                      ),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xffCED6E8),
                            borderRadius: BorderRadius.circular(15.0)),
                        width: 50,
                        height: 50,
                        child: Center(
                          child: Text(
                            "➖",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "1",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xffC3CBF3),
                            borderRadius: BorderRadius.circular(15.0)),
                        width: 50,
                        height: 50,
                        child: Icon(Icons.add),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50.0,
                    decoration: BoxDecoration(
                        color: Color(0xff445BEF),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Center(
                        child: Text(
                      "add to bag",
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
