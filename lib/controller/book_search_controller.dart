import 'package:get/get.dart';
import 'package:library_management_app/constants/enums.dart';

import '../models/book.dart';
import '../services/book_service.dart';

class BookSearchController extends GetxController {
  final searchParam = SearchParam.id.obs;
  final isLoading = false.obs;
  final bookService = BookService();

  // final searchResult = [].obs;
  // ignore: unnecessary_cast
  final Rx<List<Book>?> searchResult = (null as List<Book>?).obs;

  List<Book>? get result => [...?searchResult.value];

  void changeParam(SearchParam param) {
    searchParam(param);
  }

  Future<void> searchBook(String value) async {
    Map<String, dynamic> result;
    isLoading(true);
    if (searchParam.value == SearchParam.id) {
      result = await bookService.findBookById(value);
    } else {
      result = await bookService.findBookByName(value);
    }
    if (result['status'] == 200) {
      if (result['book'] != null) {
        searchResult([result['book']]);
      } else {
        searchResult(result['books']);
      }
    } else {
      searchResult([]);
    }
    isLoading(false);
  }
}
