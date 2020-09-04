import 'package:flutter/material.dart';

class Stocks {
  List<Map<String, dynamic>> data = [
    {
      'id': '61as61fsa',
      'display': 'Fetching data',
      'full_name': 'Wait..',
      'photo':
          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
    },
  ];

  void insertData(List Data) {
    print(Data.length);
    // data.insertAll(0, Data);
    data.clear();
    for (int i = 0; i < Data.length; i++) {
      data.add({
        'id': Data[i]['_id'],
        'display': Data[i]['symbol'],
        'full_name': Data[i]['value'],
        'photo':
          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
      });
    }
    // print('data is $data');
  }
}
