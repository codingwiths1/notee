// import 'dart:developer';
// import 'dart:ffi';

// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// class CustomPagination<T> {
//   final int limit;
//   final PagingController _pagingController = PagingController(firstPageKey: 0);
//   final Future<List<T>> Function(int offset, int limit) fetchdata;

//   CustomPagination({required this.fetchdata, this.limit = 10}) {
//     _pagingController.addPageRequestListener((offset) {
//       _loadmore(offset);
//     });
//   }
//   Future<void> _loadmore(int offset) async {
//     try {
//       final newItems = await fetchdata(offset, limit);

//       final isLastPage = newItems.length < limit;
//       if (isLastPage) {
//         _pagingController.appendLastPage(newItems);
//       } else {
//         final nextPageKey = offset + newItems.length;
//         _pagingController.appendPage(newItems, nextPageKey);
//       }
//     } catch (e) {
//       _pagingController.error = e;
//       log("THIS IS ERROR ${_pagingController.error = e}");
//     }
//   }

//   void refresh() => _pagingController.refresh();
//   void dispose() => _pagingController.dispose();
// }
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
