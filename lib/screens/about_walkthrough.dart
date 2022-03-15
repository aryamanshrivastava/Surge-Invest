// import 'package:flutter/material.dart';
// //import 'package:shared_preferences/shared_preferences.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// //import 'package:testings/main.dart';
// // ignore: unused_import
// import 'package:testings/screens/auth/login.dart';

// class AboutWalkThrough extends StatefulWidget {
//   const AboutWalkThrough({Key? key}) : super(key: key);

//   @override
//   State<AboutWalkThrough> createState() => _AboutWalkThroughState();
// }

// class _AboutWalkThroughState extends State<AboutWalkThrough> {
//   final controller = PageController();
//   final phoneController = TextEditingController();
//   int currentPage = 0;
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   // Future _viewedOnce() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   isViewed= (await prefs.setInt('isViewed', 0)) as int?;

//   // }
//   // @override
//   // void initState() {
//   //   super.initState();
//   //  // _viewedOnce();
//   // }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//     body: Container(
//       color: Color(0xff190F25),
//       child: Stack(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             child: PageView(
//               controller: controller,
//               onPageChanged: (value){
//                 setState(() {
//                   currentPage = value;
//                 });
//               },
//               children: [
//                 buildPage(
//                   urlImage: 'assets/00.png',
//                 ),
//                 buildPage(
//                   urlImage: 'assets/01.png',
//                 ),
//                 buildPage(
//                   urlImage: 'assets/02.png',
//                 ),
//                 buildPage(
//                   urlImage: 'assets/03.png',
//                 ),
//                 buildPage(
//                   urlImage: 'assets/04.png',
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 10,
//             left: 0,
//             right: 0,
//             child: Column(
//               children: [
//                 Container(
//                   color: Colors.transparent,
//                   height: MediaQuery.of(context).size.height * 0.05,
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // TextButton(
//                       //     onPressed: () => controller.jumpToPage(5),
//                       //     child: Text('Skip',
//                       //         style: TextStyle(
//                       //             fontWeight: FontWeight.bold, fontSize: 18))),
//                       Center(
//                         child: SmoothPageIndicator(
//                           controller: controller,
//                           count: 5,
//                           effect: WormEffect(
//                             dotHeight: 10,
//                             dotWidth: 10,
//                             activeDotColor: Colors.deepPurple,
//                             dotColor: Colors.white,
//                             spacing: 10,
//                           ),
//                           onDotClicked: (index) => controller.animateToPage(
//                               index,
//                               duration: Duration(milliseconds: 500),
//                               curve: Curves.easeIn),
//                         ),
//                       ),
//                       // TextButton(
//                       //     onPressed: () => controller.nextPage(
//                       //         duration: Duration(milliseconds: 500),
//                       //         curve: Curves.easeInOut),
//                       //     child: Text('Next',
//                       //         style: TextStyle(
//                       //             fontWeight: FontWeight.bold, fontSize: 18))),
//                     ],
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     if(currentPage<4){
//                       controller.animateToPage(
//                           currentPage+1,
//                           duration: Duration(milliseconds: 400),
//                           curve: Curves.easeIn
//                       );
//                     } else{
//                       Navigator.pop(context);
//                     }
//                   },
//                   child: Text(
//                     currentPage<4?'NEXT':'GOT IT!',
//                     style: TextStyle(
//                       color: Color(0xffffffff),
//                       fontWeight: FontWeight.w400,
//                       fontSize: 23,
//                     ),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     shape: new RoundedRectangleBorder(
//                       borderRadius: new BorderRadius.circular(10.0),
//                     ),
//                     elevation: 10,
//                     primary: Color(0xffD19549),
//                     padding: EdgeInsets.symmetric(
//                         horizontal:
//                         MediaQuery.of(context).size.width * 0.35,
//                         vertical:
//                         MediaQuery.of(context).size.height * 0.012),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );

//   Widget buildPage({
//     required String urlImage,
//   }) =>
//       Column(
//         children: [
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.02,
//           ),
//           Container(
//             height: MediaQuery.of(context).size.height * 0.85,
//             width: MediaQuery.of(context).size.width,
//             child: Image.asset(urlImage, fit: BoxFit.fill),
//           ),
//         ],
//       );
// }
