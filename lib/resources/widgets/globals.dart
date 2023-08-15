import 'dart:ui';

import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    required this.topPadding,
    Key? key,
  }) : super(key: key);

  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: SizedBox(
          // width: 150,
          // height: 150,
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 300,
            height: 64,
            margin: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/large_logo.png'),
                    fit: BoxFit.contain)),
          ),
        ],
      )),
    );
  }
}

class BackgraoundImage extends StatelessWidget {
  const BackgraoundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover)),
    );
  }
}

class GlassEfect extends StatelessWidget {
  const GlassEfect({
    required this.bodyWidget,
    Key? key,
  }) : super(key: key);
  final Widget bodyWidget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: ClipRRect(
          child: Container(
            height: double.infinity,
            color: Colors.transparent,
            child: Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                          Colors.white.withOpacity(0.50),
                          Colors.white.withOpacity(0.10)
                        ])),
                    child: Center(child: bodyWidget),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoadWidget extends StatelessWidget {
  const LoadWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: const Center(
        child: CircularProgressIndicator(color: Colors.amber),
      ),
    );
  }
}