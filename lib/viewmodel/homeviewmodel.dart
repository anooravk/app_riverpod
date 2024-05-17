import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm/model/moviesmodel.dart';

import '../repository/homerepository.dart';

final homeRepositoryProvider = Provider((ref) => HomeRepository());

final moviesListProvider = FutureProvider<MoviesModel>((ref) async {
  final homeRepository = ref.read(homeRepositoryProvider);
  return homeRepository.fetchMoivesList();
});
