part of 'addgroup_cubit.dart';

@immutable
abstract class AddgroupState {}

class AddgroupInitial extends AddgroupState {}
class LoadingState extends AddgroupState {}
class SuccessState extends AddgroupState {
  final Addnewgroup addnewgroup;
  SuccessState(this.addnewgroup);
}
class ErrorState extends AddgroupState {
  final ErrorModel errormodel;
  ErrorState(this.errormodel);

}

