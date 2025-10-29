import 'package:flutter/material.dart';
class ErorrConnection extends StatelessWidget {
  const ErorrConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/img_erorr_connection.png",
            width: 220,
            height: 220,
            ),

            SizedBox(height: 24.0),

            Text(
              'Tidak Terhubung ke Internet.',
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