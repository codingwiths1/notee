import 'dart:developer';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CustomPagination<T> {
  final PagingController<int, T> pagingController = PagingController(
    firstPageKey: 0,
  );

  final Future<List<T>> Function(int offset, int limit) fetchData;
  final int pageSize;

  CustomPagination({required this.fetchData, this.pageSize = 5}) {
    pagingController.addPageRequestListener((offset) {
      _loadMore(offset);
    });
  }

  Future<void> _loadMore(int offset) async {
    try {
      log("THIS IS INIT OFFSET $offset");
      final newItems = await fetchData(offset, pageSize);
      final isLastPage = newItems.length < pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(newItems);
        log("THIS IS LAST ITEM $newItems");
        log("THIS IS LAST OFFSET $isLastPage");
      } else {
        final nextOffset = offset + newItems.length;
        pagingController.appendPage(newItems, nextOffset);
        log("THIS IS NEXT OFFSET $nextOffset");
      }
    } catch (error) {
      pagingController.error = error;
      log("THIS IS ERROR ${pagingController.error}");
    }
  }

  void refresh() => pagingController.refresh();
}
