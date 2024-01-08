part of 'getmemberoutofgroup_cubit.dart';

@immutable
abstract class GetmemberoutofgroupState {}

class GetmemberoutofgroupInitial extends GetmemberoutofgroupState {}


class LoadingState5 extends GetmemberoutofgroupState {}
class SuccessState5 extends GetmemberoutofgroupState {

}
class ErrorState5 extends GetmemberoutofgroupState {}


class LoadingState6 extends GetmemberoutofgroupState {}
class SuccessState6 extends GetmemberoutofgroupState {
 final MessageModel messageModel;
 SuccessState6(this.messageModel);

}
class ErrorState6 extends GetmemberoutofgroupState {
  final ErrorModel errorModel;
  ErrorState6(this.errorModel);
}