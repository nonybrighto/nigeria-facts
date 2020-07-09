import 'package:dailyfactsng/constants/constants.dart';

class Pagination {
  
  final int page;
  final int limit;
  int totalCount;
  
  Pagination({this.page, this.limit = kFetchLimit});

  setTotalCount(count) {
    this.totalCount = count;
  }

  getOffset() {
    return (this.page - 1) * this.limit;
  }

  getTotalPages() {
    return (this.totalCount / this.limit).ceil();
  }

  hasNextPage() {
    return this.page < this.getTotalPages();
  }

  hasPreviousPage() {
    return this.page > 1;
  }

  // generatePaginationObject() {
  //   const paginationObject = {
  //     totalPages: this.getTotalPages(),
  //     perPage: this.limit,
  //     itemCount: this.totalCount,
  //     currentPage: this.page,
  //     ...(this.hasPreviousPage() && { previousPage: this.page - 1 }),
  //     ...(this.hasNextPage() && { nextPage: this.page + 1 })
  //   };

  //   return paginationObject;
  // }
}
