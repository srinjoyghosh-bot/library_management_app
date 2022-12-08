import 'package:flutter/material.dart';
import 'package:library_management_app/size_config.dart';

import '../models/book.dart';

class BookContainer extends StatelessWidget {
  const BookContainer(this.book, {Key? key}) : super(key: key);
  final Book book;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
        width: SizeConfig.blockSizeHorizontal * 30,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/book.png',
              height: SizeConfig.blockSizeVertical * 15,
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1.5,
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                book.name,
                style: TextStyle(
                    fontSize: SizeConfig.blockSizeVertical * 2,
                    fontWeight: FontWeight.bold),
              ),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                book.author,
                style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 1.75),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
