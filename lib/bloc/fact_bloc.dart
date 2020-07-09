import 'package:dailyfactsng/bloc/list_bloc.dart';
import 'package:dailyfactsng/models/category.dart';
import 'package:dailyfactsng/models/fact.dart';
import 'package:dailyfactsng/models/fact_list_response.dart';
import 'package:dailyfactsng/services/local/fact_local.dart';
import 'package:flutter/material.dart';

class FactBloc extends ListBloc<Fact>{
 
 final FactLocal factLocal;
 final FactListFetchType fetchType;
 final Category category;
 String searchTerm;
 
 FactBloc({this.factLocal, @required this.fetchType, this.category}){
          searchTerm  = '';
          getItems();
 }
 
  @override
  void dispose() {
        super.dispose();
        _dispose();
  }


  searchFact(String searchTerm){
    this.searchTerm = searchTerm;
    getItems();
  }

  toggleBookmark({Fact fact, Function(bool toggled) toggleCallback}) async{
     try{
      fact.isBookmarked  = !fact.isBookmarked;
      updateItem(fact);
      await factLocal.toggleFactBookmark(fact.id, fact.isBookmarked);
      if(toggleCallback != null){
        toggleCallback(true);
      }
     }catch(error){
      fact.isBookmarked  = !fact.isBookmarked;
      updateItem(fact);
      if(toggleCallback != null){
        toggleCallback(true);
      }
     }
        
  }

  @override
  Future<FactListResponse> fetchFromServer() async{

    switch (fetchType) {
      case FactListFetchType.randomFacts:
       return await factLocal.getRandomFacts(page: currentPage);
      break;
      case FactListFetchType.bookmarkedFacts:
        return await factLocal.getBookMarkedFacts(page: currentPage);
      case FactListFetchType.categoryFacts:
        return await factLocal.getCategoryFacts(category: category, page: currentPage);
      case FactListFetchType.searchFacts:
        return await factLocal.getSearchedFacts(searchTerm: searchTerm, page: currentPage);
      default:
        return null;

    }
  }


  _dispose(){}

  @override
  bool itemIdentificationCondition(Fact currentFact, Fact updatedFact) {
    return currentFact.id == updatedFact.id;
  }

  @override
  String getEmptyResultMessage() {
    return 'No Fact found';
  }
}

enum FactListFetchType{randomFacts , bookmarkedFacts, categoryFacts, searchFacts}