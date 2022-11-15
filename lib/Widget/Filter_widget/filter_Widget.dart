import 'package:flutter/material.dart';
import 'package:kasrzero_flutter/Widget/Filter_widget/color_dots.dart';
import 'package:kasrzero_flutter/Widget/detailsWidget/custom_app_bar.dart';
import 'package:kasrzero_flutter/Widget/Filter_widget/filterItem.dart';
import 'package:kasrzero_flutter/Widget/detailsWidget/default_button.dart';
import 'package:kasrzero_flutter/Widget/detailsWidget/top_rounded_container.dart';
import 'package:kasrzero_flutter/constants.dart';
import 'package:kasrzero_flutter/models/category.dart';
import 'package:kasrzero_flutter/providers/Filter_provider.dart';
import 'package:provider/provider.dart';

// import 'package:flutter_xlider/flutter_xlider.dart';

class Filtre extends StatefulWidget {
  @override
  _FiltreState createState() => _FiltreState();
}

class _FiltreState extends State<Filtre> {
  double _lowerValue = 60;
  double _upperValue = 1000;
  @override
  void initState() {}

  String durationOfUseSlected = "";

  void isdurationOfUseSlected(String la) {
    setState(() {
      durationOfUseSlected = la;
    });
  }

  String colorsSlected = "";
  void iscolorsSlected(String la) {
    print(la);
    setState(() {
      colorsSlected = la;
    });
  }

  String brandesSelected = "";
  void isbrandesSelected(String la) {
    setState(() {
      brandesSelected = la;
    });
  }

  String firstfilterSelected = "";
  void isfirstfilterSelected(String la) {
    setState(() {
      firstfilterSelected = la;
    });
  }

  String secondfilterSelected = "";
  void issecondfilterSelected(String la) {
    setState(() {
      secondfilterSelected = la;
    });
  }

  String thirdfilterSelected = "";
  void isthirdfilterSelected(String la) {
    setState(() {
      thirdfilterSelected = la;
    });
  }

  RangeValues currentRangeValues = const RangeValues(0, 50000);

  @override
  Widget build(BuildContext context) {
    final Category agrs =
        ModalRoute.of(context)!.settings.arguments as Category;
    final filterprovider = Provider.of<FilterProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(Title: "Filter"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text("Duration Of Use"),
            ),
            Expanded(
                flex: 1,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: KDurationsOfUse.length,
                  itemBuilder: ((context, index) => FilterItem(
                        label: KDurationsOfUse[index],
                        color: Colors.white,
                        textColor: Colors.grey,
                        s: (durationOfUseSlected == KDurationsOfUse[index])
                            ? true
                            : false,
                        getlabal: isdurationOfUseSlected,
                      )),
                )),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text("Colors"),
            ),
            Expanded(
                flex: 1,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ColorDote(
                        label: "black",
                        color: Colors.black,
                        s: (colorsSlected == "black") ? true : false,
                        getlabal: iscolorsSlected),
                    ColorDote(
                        label: "white",
                        color: Colors.white,
                        s: (colorsSlected == "white") ? true : false,
                        getlabal: iscolorsSlected),
                    ColorDote(
                        label: "grey",
                        color: Colors.grey,
                        s: (colorsSlected == "grey") ? true : false,
                        getlabal: iscolorsSlected),
                    ColorDote(
                        label: "red",
                        color: Colors.red,
                        s: (colorsSlected == "red") ? true : false,
                        getlabal: iscolorsSlected),
                    ColorDote(
                        label: "green",
                        color: Colors.green,
                        s: (colorsSlected == "green") ? true : false,
                        getlabal: iscolorsSlected),
                    ColorDote(
                        label: "blue",
                        color: Colors.blue,
                        s: (colorsSlected == "blue") ? true : false,
                        getlabal: iscolorsSlected),
                    ColorDote(
                        label: "yellow",
                        color: Colors.yellow,
                        s: (colorsSlected == "yellow") ? true : false,
                        getlabal: iscolorsSlected),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text("price"),
            ),
            Expanded(
                flex: 1,
                child: RangeSlider(
                  values: currentRangeValues,
                  max: 50000,
                  divisions: 1000,
                  labels: RangeLabels(
                    currentRangeValues.start.round().toString(),
                    currentRangeValues.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      currentRangeValues = values;
                    });
                  },
                )),
            (agrs.brands.length == 0
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text("Brands"),
                  )),
            Expanded(
              flex: 1,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: agrs.brands
                    .map((e) => FilterItem(
                          label: e,
                          color: Colors.white,
                          textColor: Colors.grey,
                          s: (brandesSelected == e) ? true : false,
                          getlabal: isbrandesSelected,
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(agrs.titlefirstFilter),
            ),
            Expanded(
              flex: 1,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: agrs.optionsfirstFilter
                    .map((e) => FilterItem(
                          label: e,
                          color: Colors.white,
                          textColor: Colors.grey,
                          s: (firstfilterSelected == e) ? true : false,
                          getlabal: isfirstfilterSelected,
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(agrs.titlesecondFilter),
            ),
            Expanded(
              flex: 1,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: agrs.optionssecondFilter
                    .map((e) => FilterItem(
                          label: e,
                          color: Colors.white,
                          textColor: Colors.grey,
                          s: (secondfilterSelected == e) ? true : false,
                          getlabal: issecondfilterSelected,
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(agrs.titlethirdFilter),
            ),
            Expanded(
              flex: 1,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: agrs.optionsthirdFilter
                    .map((e) => FilterItem(
                          label: e,
                          color: Colors.white,
                          textColor: Colors.grey,
                          s: (thirdfilterSelected == e) ? true : false,
                          getlabal: isthirdfilterSelected,
                        ))
                    .toList(),
              ),
            ),
            Expanded(
                flex: 2,
                child: TopRoundedContainer(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Row(
                        children: [
                          DefaultButton(
                            text: "cancel",
                            press: () {
                              filterprovider.setfilterno();
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          DefaultButton(
                            text: "filter",
                            press: () {
                              Filtermodel fil = Filtermodel(
                                state: true,
                                brand: brandesSelected,
                                color: "",
                                durationOfUse: durationOfUseSlected,
                                firstFilter: firstfilterSelected,
                                secondFilter: secondfilterSelected,
                                thirdFilter: thirdfilterSelected,
                                colorf: colorsSlected,
                                price: currentRangeValues,
                              );
                              filterprovider.setFilter(fil);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
