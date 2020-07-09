abstract class ListResponse<T>{

  int totalPages;
  int perPage;
  int currentPage;
  int nextPage;
  int previousPage;
  List<T> results; 

}