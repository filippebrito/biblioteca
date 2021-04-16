import 'package:flutter/material.dart';
import 'package:bottom_sheet/bottom_sheet.dart';

class BottomSheetComponent{

  BuildContext context;
  String title;
  List<BottomSheetItems> listItems;

  BottomSheetComponent(this.context, this.title, {this.listItems});

  void show(){
    showStickyFlexibleBottomSheet<void>(
      minHeight: 0,
      initHeight: 0.28,
      maxHeight: .28,
      headerHeight: 50,
      context: context,
      decoration: _getDecoration(),
      headerBuilder: (context, offset) {
        return _getAnimatedContainer(context, offset);
      },
      builder: (context, offset) {
        return SliverChildListDelegate(_getItems());
      },
      anchors: [.2, 0.28, .28],
    );
  }

  BoxDecoration _getDecoration(){

    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
      topLeft: Radius.circular(10.0),
      topRight: Radius.circular(10.0),
      ),
    );

  }

  AnimatedContainer _getAnimatedContainer(BuildContext context, offset){
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(offset == 0.8 ? 0 : 10),
          topRight: Radius.circular(offset == 0.8 ? 0 : 10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _getItems(){

    List<Widget> items = [];
    for(int i=0; i < listItems.length; i++){
      items.add(GestureDetector(
          onTap: listItems[i].onTap,
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 0.65,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child:  Row(
                  children: [
                    Icon(listItems[i].icon, color: listItems[i].color),
                    Padding(padding: EdgeInsets.only(right: 10.0)),
                    Text(
                      listItems[i].title,
                      style: TextStyle(color: listItems[i].color),
                    )
                  ]
              ),
            ),
          )
      ));

      if(i+1 < listItems.length){
        items.add(Divider());
      }
    }

    return items;
  }

}

class BottomSheetItems {

  String title;
  IconData icon;
  Color color;
  Function onTap;

  BottomSheetItems(this.title, {this.icon, this.color:Colors.black54, this.onTap});

}