import "package:flutter/material.dart";

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      color: Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            left: -15,
            child: Image.asset("assets/Go.png",
                fit: BoxFit.fill,
                scale: 1,
                width: size.width*1.1,
                height: size.height),
          ),
          child,
        ],
      ),
    );
  }
}
