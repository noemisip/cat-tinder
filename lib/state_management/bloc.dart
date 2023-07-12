import 'package:bloc/bloc.dart';
import 'package:cat_tinder/cat_store.dart';
import 'package:get_it/get_it.dart';
import 'package:cat_tinder/model/cat.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  CatBloc() : super(CatInitial()) {
    final catStore = GetIt.instance.get<CatStore>();
    on<UpdateCat>((event, emit) async {
      try {
        emit(CatLoading());
        final cat = await catStore.chooseCurrentCat();
        emit(CatLoaded(cat!));
      } catch (error) {
        emit(CatError(error.toString()));
      }
    });
  }
}

abstract class CatEvent {}

class UpdateCat extends CatEvent {
  UpdateCat();
}

abstract class CatState {}

class CatInitial extends CatState {}

class CatLoading extends CatState {}

class CatLoaded extends CatState {
  final Cat cat;
  CatLoaded(this.cat);
}

class CatError extends CatState {
  final String error;
  CatError(this.error);
}
