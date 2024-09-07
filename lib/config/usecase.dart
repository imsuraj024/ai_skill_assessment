abstract class UsecaseWithParams<Type, Params> {
  UsecaseWithParams();
  Future<Type> call(Params params);
}

abstract class UsecaseWithoutParams<Type> {
  UsecaseWithoutParams();
  Future<Type> call();
}
