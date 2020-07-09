import 'package:dailyfactsng/bloc/bloc_provider.dart';
import 'package:dailyfactsng/models/category.dart';
import 'package:dailyfactsng/services/local/fact_local.dart';
import 'package:rxdart/rxdart.dart';

class CategoryBloc extends BlocBase {
  List<Category> _categories = [];

  FactLocal factLocal;
  final _categoriesSubject = BehaviorSubject<List<Category>>();

  //stream
  Stream<List<Category>> get categories => _categoriesSubject.stream;

  CategoryBloc({this.factLocal}) {
    getCategories();
  }

  getCategories() async {
    if (_categories.isEmpty) {
      try {
        List<Category> categories = await factLocal.getAllCategories();
        _categoriesSubject.add(categories);
        _categories = categories;
      } catch (error) {
        _categoriesSubject.addError('Failed to get Categories');
      }
    }
  }

  @override
  void dispose() {
    _categoriesSubject.close();
  }
}
