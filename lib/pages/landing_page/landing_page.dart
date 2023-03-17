import 'package:flutter/material.dart';

import '../home_page/home_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // no mixin here because the widget is stateless so no need to make complex
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).height * 0.1),
                  child: const Text(
                    'Hello there!',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.1,
                    vertical: MediaQuery.sizeOf(context).height * 0.1,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(HomePage.routeName);
                    },
                    child: const Text('Get Started'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
