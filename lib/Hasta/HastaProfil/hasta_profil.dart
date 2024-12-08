
import 'package:flutter/material.dart';

class HastaProfil extends StatefulWidget {
  const HastaProfil({super.key});

  @override
  HastaProfilState createState() => HastaProfilState();
}

class HastaProfilState extends State<HastaProfil> {

  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex:5,
                child:Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.red,Colors.red],
                    ),
                  ),
                  child: const Column(
                      children: [
                        SizedBox(height: 110.0,),
                        CircleAvatar(
                          radius: 65.0,
                          backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/387/387585.png'),
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(height: 10.0,),
                        Text('Erza Scarlet',
                            style: TextStyle(
                              color:Colors.white,
                              fontSize: 20.0,
                            )),
                        SizedBox(height: 10.0,),
                      ]
                  ),
                ),
              ),

              Expanded(
                flex:5,
                child: Container(
                  color: Colors.grey[200],
                  child: Center(
                      child:Card(
                          margin: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                          child: Container(
                              width: 310.0,
                              height:290.0,
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Information",
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w800,
                                      ),),
                                    Divider(color: Colors.grey[300],),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          color: Colors.blueAccent[400],
                                          size: 35,
                                        ),
                                        SizedBox(width: 20.0,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("Telefon No",
                                              style: TextStyle(
                                                fontSize: 15.0,
                                              ),),
                                            Text("053485932482",
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.grey[400],
                                              ),)
                                          ],
                                        )

                                      ],
                                    ),
                                    SizedBox(height: 20.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.mail,
                                          color: Colors.yellowAccent[400],
                                          size: 35,
                                        ),
                                        SizedBox(width: 20.0,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("E Mail",
                                              style: TextStyle(
                                                fontSize: 15.0,
                                              ),),
                                            Text("ayberkoz@gmail.com",
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.grey[400],
                                              ),)
                                          ],
                                        )

                                      ],
                                    ),
                                    const SizedBox(height: 20.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.lock_outline,
                                          color: Colors.pinkAccent[400],
                                          size: 35,
                                        ),
                                        const SizedBox(width: 20.0,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("Şifre",
                                              style: TextStyle(
                                                fontSize: 15.0,
                                              ),),
                                            Text("1234",
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.grey[400],
                                              ),)
                                          ],
                                        )

                                      ],
                                    ),
                                    const SizedBox(height: 20.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.people,
                                          color: Colors.lightGreen[400],
                                          size: 35,
                                        ),
                                        const SizedBox(width: 20.0,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("Team",
                                              style: TextStyle(
                                                fontSize: 15.0,
                                              ),),
                                            Text("Team Natsu",
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.grey[400],
                                              ),)
                                          ],
                                        )

                                      ],
                                    ),
                                  ],
                                ),
                              )
                          )
                      )
                  ),
                ),
              ),

            ],
          ),
          Positioned(
              top:MediaQuery.of(context).size.height*0.45,
              left: 20.0,
              right: 20.0,
              child: Card(
                  child: Padding(
                    padding:EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            child:Column(
                              children: [
                                Text('Ad',
                                  style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 14.0
                                  ),),
                                const SizedBox(height: 5.0,),
                                const Text("Erza",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),)
                              ],
                            )
                        ),

                        Container(
                          child: Column(
                              children: [
                                Text('Soyad',
                                  style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 14.0
                                  ),),
                                const SizedBox(height: 5.0,),
                                const Text('Scarlet',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),)
                              ]),
                        ),

                        Container(
                            child:Column(
                              children: [
                                Text('Yaş',
                                  style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 14.0
                                  ),),
                                const SizedBox(height: 5.0,),
                                const Text('19 yrs',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),)
                              ],
                            )
                        ),
                      ],
                    ),
                  )
              )
          )
        ],
      ),
    );
  }
}


