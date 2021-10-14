// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/slide_tile.dart';

// class HomePage extends StatelessWidget {
  
//   final PageController _pageController = PageController(viewportFraction: 0.8);
// int _currentPage=0;
// var _listSlide=[

//   {'id': 0, 'image':'assets/MartialPeak.jpg'},
//   {'id': 1, 'image':'assets/SoloLeveling.jpg'},
//   {'id': 2, 'image':'assets/OnePiece.jpg'}
// ];

//   HomePage({Key key}) : super(key: key);

// void initState(){
//  _pageController.addListener(() {
// int next =_pageController.page.round();
// if(_currentPage != next){
//   setState(() {
// _currentPage =next;
//   });
// }
//   });
//   super.initState();
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               alignment: Alignment.topCenter,
//               height: 160,
//               width: 50,
//               child: PageView.builder(
//                 controller: _pageController,
//                 itemCount: _listSlide.length,
//                 itemBuilder: (_, currentIndex) {
//                  bool activePage = currentIndex == _currentPage;  
//                   return SlideTile(
//                     get activePage => false;
//                     activePage: activePage,
//                     image: _listSlide[currentIndex]['image'],);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
