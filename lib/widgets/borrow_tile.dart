import 'package:flutter/material.dart';
import 'package:library_management_app/models/borrow.dart';

import '../size_config.dart';

class BorrowTile extends StatelessWidget {
  const BorrowTile(this.borrow, {Key? key}) : super(key: key);
  final Borrow borrow;

  String getDate(String date) {
    return date.substring(0, date.indexOf('T'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical,
          left: SizeConfig.blockSizeHorizontal * 5,
          right: SizeConfig.blockSizeHorizontal * 5),
      decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal * 2,
          vertical: SizeConfig.blockSizeVertical),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Book #${borrow.bookId}',
            style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2.5),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Issue: ${getDate(borrow.createdAt)}'),
              borrow.returnDate != null
                  ? Text('Return: ${getDate(borrow.returnDate!)}')
                  : Container(),
            ],
          )
        ],
      ),
    );
  }
}
