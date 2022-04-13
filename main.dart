import 'package:anchor_point_scroll_view/anchor_point_scroll_view.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'dart:math';

/*
  anchor_point_scroll_view:
  buttons_tabbar:
 */


void main() => runApp(
    const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    )
);


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  TabController? tabController;
  final GlobalKey<AnchorPointScrollViewState> _anchorKey = GlobalKey();
  Random random = Random();
  _onPress(int index) {
    _anchorKey.currentState?.jumpToIndex(index);
  }
  List topListString = [
    'بيض',
    'مرتديلا',
    'مربى',
    'زيتون اسود',
    'زيتون اخضر',
    'زعتر',
    'هريس الفستق',
    'رقائق الفطور',
    'طحينة',
    'عسل',
    'دبس',
    'فول',
    'فلافل',
    'حمص',
    'متنوعة'
  ];


  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: topListString.length,
      vsync: this,
    );
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF7F7F7),
        body: Column(
            children: [

              /// Top List
              DefaultTabController(
                length: topListString.length,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: ButtonsTabBar(
                      onTap: (i){
                        _onPress(i);
                      },
                      backgroundColor: Colors.redAccent,
                      controller: tabController,
                      unselectedBackgroundColor: Colors.grey[300],
                      unselectedLabelStyle: const TextStyle(color: Colors.black),
                      labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                      tabs: List.generate(topListString.length, (index) => Tab(
                        text: '${topListString[index]}',
                      ),)
                  ),
                )
              ),

              /// Product List
              Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowGlow();
                    return false;
                  },
                  child: AnchorPointScrollView(
                    key: _anchorKey,
                    onIndexChanged: (index) {
                      tabController?.animateTo(index);
                    },
                    children: List.generate(topListString.length, (indexx) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: indexx == topListString.length -1 ? MediaQuery.of(context).size.height : 60),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Card(
                                  color: Colors.lightGreen,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('${topListString[indexx]}',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),),
                                    ],
                                  )
                              ),
                            ),
                            Wrap(
                              spacing: 15,
                              runSpacing: 15,
                              children: List.generate(indexx == 0 ? 2 :indexx == 1 ? 3 : indexx == 2 ? 10 : indexx == 3 ? 4 : indexx == 4 ? 8 : 6, (index) => SizedBox(
                                width: MediaQuery.of(context).size.width / 2 - 20,
                                child: Container(
                                  height: 275,
                                  width: MediaQuery.of(context).size.width / 2,
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start ,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: index.isEven ? const Icon(Icons.favorite,color: Color(0xff9b1003),) : const Icon(Icons.favorite_border,color: Color(0xff9b1003),)
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Align(
                                          alignment: FractionalOffset.topCenter,
                                          child: Image(image: NetworkImage("https://source.unsplash.com/300x300/?portrait?${random.nextInt(100)}"),),
                                        ),
                                      ),
                                      const SizedBox(height: 5,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Text("دينار",textDirection: TextDirection.rtl,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 15,letterSpacing: 1.5,color: Color(0xff1D1A2C)),strutStyle: StrutStyle(forceStrutHeight: true,height: 1,)),
                                          SizedBox(width: 5,),
                                          Text('1,000',textDirection: TextDirection.rtl,style: TextStyle(fontWeight: FontWeight.w900,fontSize: 15,letterSpacing: 1.5,color: Color(0xff9b1003)),strutStyle: StrutStyle(forceStrutHeight: true,height: 1,)),
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      const Expanded(
                                        child: Align(
                                          alignment: FractionalOffset.topCenter,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 5,left: 2),
                                            child: Text("قرنفل مطحون عبيدو 50غ",textDirection: TextDirection.rtl,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 13,letterSpacing: 1.5,color: Color(0xff1D1A2C)),strutStyle: StrutStyle(forceStrutHeight: true,height: 1,)),
                                          ),
                                        ),
                                      ),
                                      const Expanded(
                                          child: Align(
                                              alignment: FractionalOffset.bottomRight,
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Icon(Icons.add_circle_rounded,color: Color(0xff1D1A2C),size: 30,),
                                              )))
                                    ],
                                  ),
                                ),
                              )),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}