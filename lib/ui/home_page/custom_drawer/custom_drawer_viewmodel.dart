import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.network("https://i.pinimg.com/736x/ae/ea/b8/aeeab8effa35ac458bb34cdb24d3c01d.jpg", fit: BoxFit.cover,),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: CircleAvatar(
                          child: Image.network(
                              'https://i.pinimg.com/originals/18/99/07/1899072ff62e9455aed4c53be5fe9654.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 230,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4 - 30,
                      ),
                      const Text("Hello Rana!"),
                    ],
                  ),
                ),
                Positioned(
                  top: 280,
                  child: GestureDetector(
                    onTap: () {
                      print("Dashboard tapped!");
                    },
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20)),
                      child: const ListTile(
                        leading: Icon(Icons.dashboard),
                        title: Text("Dashboard"),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 360,
                  child: GestureDetector(
                    onTap: () {
                      print("Profile");
                    },
                    child: Container(
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20)),
                      child: const ListTile(
                        leading: Icon(Icons.person),
                        title: Text("Profile"),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 500,
                  left: 60,
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration:  BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade600,
                    ),
                    child: ClipOval(child: Image.network(imageLink)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

const imageLink = "https://instagram.fpat2-1.fna.fbcdn.net/v/t51.2885-19/s150x150/244459884_236683651754606_2770228632942995973_n.jpg?_nc_ht=instagram.fpat2-1.fna.fbcdn.net&_nc_cat=102&_nc_ohc=AFjXDDTjwWYAX-LOro6&edm=AI8ESKwBAAAA&ccb=7-4&oh=00_AT_HXuh70nWlEPNaSsB0C68JkFcJFf3B1aWBBcLqGvmvww&oe=61C9B6A4&_nc_sid=195af5";