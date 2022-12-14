import 'package:get/get.dart';
import 'package:library_management_app/models/book.dart';
import 'package:library_management_app/services/book_service.dart';

class HomeController extends GetxController {
  final allBooks = [].obs;
  final bookService = BookService();
  final isLoading = false.obs;
  String errorMessage = '';

  bool get loading => isLoading.value;

  List get books => [...allBooks.value];

  Future<void> fetchBooks() async {
    isLoading(true);
    final result = await bookService.getAllBooks();
    if (result is List) {
      allBooks(result);
    }
    isLoading(false);
  }

  Future<bool> addBook(String name, String description, String publisher,
      String author, String? imageUrl) async {
    isLoading(true);
    final result = await bookService.addBook(
      name: name,
      description: description,
      publisher: publisher,
      author: author,
      imageUrl: imageUrl,
    );
    isLoading(false);
    if (result['status'] == 200) {
      List newList = books;
      newList.add(result['book']);
      allBooks(newList);
      return true;
    }
    errorMessage = result['message'];
    return false;
  }

  Future<Map<String, dynamic>> issueBook(
      String studentId, String bookId) async {
    isLoading(true);
    final result = await bookService.issueBook(studentId, bookId);
    isLoading(false);
    if (result['status'] == 200) {
      return {
        'status': true,
        'message': 'Book Issued!',
      };
    }
    // errorMessage = result['message'];
    return {
      'status': false,
      'message': result['message'],
    };
  }

  Future<Map<String, dynamic>> returnBook(
      String studentId, String bookId) async {
    isLoading(true);
    final result = await bookService.returnBook(studentId, bookId);
    isLoading(false);
    if (result['status'] == 200) {
      return {'status': true, 'message': 'Book Returned'};
    }
    // errorMessage = result['message'];
    return {'status': false, 'message': result['message']};
  }

  Future<bool> delete(int bookId) async {
    isLoading(true);
    final result = await bookService.deleteBook(bookId);
    isLoading(false);
    if (result['status'] == 200) {
      List newList = books;
      newList.removeWhere((book) => book.id == bookId);
      allBooks(newList);
      return true;
    }
    errorMessage = result['message'];
    return false;
  }

  Future<bool> toggleAvailability(int bookId) async {
    isLoading(true);
    final result = await bookService.toggleAvailability(bookId);
    isLoading(false);
    if (result['status'] == 200) {
      List newList = books;
      // newList.removeWhere((book) => book.id == bookId);
      final book = newList.firstWhere((book) => book.id == bookId);
      int index = newList.indexWhere((book) => book.id == bookId);
      newList.removeWhere((book) => book.id == bookId);
      newList.insert(
          index,
          Book(
              id: book.id,
              name: book.name,
              description: book.description,
              publisher: book.publisher,
              author: book.author,
              available: !book.available));
      allBooks(newList);
      return true;
    }
    errorMessage = result['message'];
    return false;
  }
}
