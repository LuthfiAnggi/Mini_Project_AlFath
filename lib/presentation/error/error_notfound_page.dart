import 'package:flutter/material.dart';
class ErorrNotfound extends StatelessWidget {
  const ErorrNotfound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/img_erorr_404.png",
            width: 220,
            height: 220,
            ),

            SizedBox(height: 16.0),

            Text(
              'Lowongan sudah dihapus atau\ntidak tersedia',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w400
              ),
            )
          ],
        ),
      ),
    );
  }
}