import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:outbreak_tracker/entities/app_state.dart';
import 'package:outbreak_tracker/redux/actions.dart';
import 'package:outbreak_tracker/util/GlobalAppConstants.dart';
import 'package:http/http.dart' as http;

class DialogHelpers {
  showRateOfSpreadData(BuildContext context, int countryId, int caseId) {
    getRateOfSpread(countryId, caseId).then((value) {
      StoreProvider.of<AppState>(context).dispatch(RateOfSpreadAction(value));

      return showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(
                GlobalAppConstants.rateOfSpread,
                style: TextStyle(color: GlobalAppConstants.appMainColor),
              ),
              content: StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                builder: (context, state) {
                  return Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      height: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(GlobalAppConstants.totalCases),
                              Text(GlobalAppConstants.newCases),
                              Text('Total deaths: '),
                              Text('Active cases: '),
                              Text('Total recovered: '),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(state.rateOfSpread.last['total_cases']
                                  .toString()),
                              Text(state.rateOfSpread.last['new_cases']
                                  .toString()),
                              Text(state.rateOfSpread.last['total_deaths']
                                  .toString()),
                              Text(state.rateOfSpread.last['active_cases']
                                  .toString()),
                              Text(state.rateOfSpread.last['total_recovered']
                                  .toString()),
                            ],
                          )
                        ],
                      ));
                },
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text(GlobalAppConstants.dismiss),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                )
              ],
            );
          });
    });
  }

  showCountryData(BuildContext context, int countryId, int caseId) {
    getCountryAdvisory(countryId, caseId).then((value) {
      print("original value $value");
      if (value.length == 0) {
        print("I am here");
        Map<String, dynamic> values = new Map<String, dynamic>();
        values['id'] = 0;
        values['country_id'] = countryId;
        values['case_id'] = caseId;
        values['travel_advisories'] = 'No information to show currently';
        values['special_measures'] = 'No information to show currently';
        values['quarantines'] = 'No information to show currently';
        values['prepared_hospitals'] = 'No information to show currently';
        values['additional_info'] = 'No information to show currently';
        values['created_at'] = 'No information to show currently';
        values['updated_at'] = 'No information to show currently';
        value.add(values);
      }
      print("empty value $value");
      StoreProvider.of<AppState>(context)
          .dispatch(CountryAdvisoryAction(value));

      return showCupertinoDialog(
          context: context,
          useRootNavigator: true,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(
                GlobalAppConstants.countryData,
                style: TextStyle(color: GlobalAppConstants.appMainColor),
              ),
              content: StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                builder: (context, state) {
                  return Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      height: 600,
                      width: 600,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                      'Travel Advisories: ${state.countryAdvisory.last['travel_advisories']}'),
                                ),
                                Flexible(
                                    child: Text(
                                        'Special Measures: ${state.countryAdvisory.last['special_measures']}')),
                                Flexible(
                                    child: Text(
                                        'Quarantines: ${state.countryAdvisory.last['quarantines']}')),
                                Flexible(
                                    child: Text(
                                        'Prepared Hospitals: ${state.countryAdvisory.last['prepared_hospitals']}')),
                                Flexible(
                                    child: Text(
                                        'Additional Info: ${state.countryAdvisory.last['additional_info']}')),
                              ],
                            ),
                          )
                        ],
                      ));
                },
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text(GlobalAppConstants.dismiss),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                )
              ],
            );
          });
    });
  }

  showHotspotData(BuildContext context, int countryId, int caseId) {
    return showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              GlobalAppConstants.hotspot,
              style: TextStyle(color: GlobalAppConstants.appMainColor),
            ),
            content: Container(
//                padding: EdgeInsets.symmetric(vertical: 20),
//                height: 200,
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      mainAxisSize: MainAxisSize.max,
//                      children: <Widget>[
//                        Text('Total cases: '),
//                        Text('New cases: '),
//                        Text('Total deaths: '),
//                        Text('Active cases: '),
//                        Text('Total recovered: '),
//                      ],
//                    ),
////TODO: Use provider state management
////                    Column(
////                      crossAxisAlignment: CrossAxisAlignment.start,
////                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                      mainAxisSize: MainAxisSize.max,
////                      children: <Widget>[
////                        Text('$totalCases'),
////                        Text('$totalCases'),
////                        Text('$totalCases'),
////                        Text('$totalCases'),
////                        Text('$totalCases'),
////                      ],
////                    )
//                  ],
//                )
                ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(GlobalAppConstants.dismiss),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              )
            ],
          );
        });
  }

  Future<List<dynamic>> getRateOfSpread(int countryId, int caseId) async {
    List<dynamic> rates = new List<dynamic>();

    http.Response response = await http.get(
        Uri.encodeFull(
            'http://outbreak.africanlaughterpr.com/api/growth-rates/country/case/list?country_id=$countryId&case_id=$caseId'),
        headers: {'Accept': 'application/json'});

    if (response.statusCode == 200) {
      var ratesData = json.decode(response.body);
      rates = ratesData['growth_rates'];
    }

    return rates;
  }

  Future<List<dynamic>> getCountryAdvisory(int countryId, int caseId) async {
    List<dynamic> advisory = new List<dynamic>();

    http.Response response = await http.get(
        Uri.encodeFull(
            'http://outbreak.africanlaughterpr.com/api/datasheets/country/list?country_id=$countryId'),
        headers: {'Accept': 'application/json'});

    print("response code ${response.statusCode}");
    if (response.statusCode == 200) {
      var advisoryData = json.decode(response.body);
      print("advisory data = $advisoryData");
      advisory = advisoryData['datasheets'];
    }

    print("advisory = $advisory");

    return advisory;
  }
}