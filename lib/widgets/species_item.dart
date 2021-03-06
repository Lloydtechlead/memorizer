import 'package:flutter/material.dart';
import 'package:memorizer/entities/category_content.dart';
import 'package:memorizer/entities/species_item.dart';
import 'package:memorizer/pages/category_detail.dart';
import 'package:memorizer/utils/shared_preferences.dart';
import 'package:memorizer/widgets/round_icon.dart';

class SpeciesItemWidget extends StatefulWidget {
  final SpeciesItem item;
  final VoidCallback onPressed;

  SpeciesItemWidget({
    @required this.item,
    @required this.onPressed,
  });

  @override
  SpeciesItemWidgetState createState() {
    return new SpeciesItemWidgetState(item);
  }
}

class SpeciesItemWidgetState extends State<SpeciesItemWidget> {
  SpeciesItem item;
  String langCode;

  SpeciesItemWidgetState(this.item);

  @override
  Widget build(BuildContext context) {
    return new SharedPreferencesBuilder(
        pref: PREF_LANG_CODE,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          langCode = snapshot.data;
          return new Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
              child: _buildListTile(),
            ),
          );
        });
  }

  Widget _buildListTile() {
    return ListTile(
      onTap: widget.onPressed,
      contentPadding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: _buildImage(),
      title: Text(
        item.name.getString(langCode),
        style: TextStyle(color: Colors.white),
      ),
      trailing:
      Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
    );
  }

  Widget _buildImage() {
    var avatar = new RoundIconWidget(item.imageUrl ?? '', false);

    var placeholder = new Container(
        width: 70.0,
        height: 70.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          gradient: new LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black54, Colors.black, Colors.blueGrey[600]],
          ),
        ),
        alignment: Alignment.center);

    var crossFade = new AnimatedCrossFade(
      firstChild: placeholder,
      secondChild: avatar,
      crossFadeState: item.imageUrl == null
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: new Duration(milliseconds: 1000),
    );

    return crossFade;
  }
}
