part of 'getmembersingroup_cubit.dart';

@immutable
abstract class GetmembersingroupState {}

class GetmembersingroupInitial extends GetmembersingroupState {}
class LoadingState4 extends GetmembersingroupState {}
class SuccessState4 extends GetmembersingroupState {
  final GetMemberModel getmembersmodle;
  SuccessState4(this.getmembersmodle);
}
class ErrorState4 extends GetmembersingroupState {}

class LoadingStatee extends GetmembersingroupState {}
class SuccessStatee extends GetmembersingroupState {

}
class ErrorStatee extends GetmembersingroupState {}


class LoadingStateedel extends GetmembersingroupState {}
class SuccessStateedel extends GetmembersingroupState {
final MessageModel messageModel;
SuccessStateedel(this.messageModel);
}
class ErrorStateedel extends GetmembersingroupState {
  final ErrorModel errormodel;
  ErrorStateedel(this.errormodel);

}