part of 'get_my_group_cubit.dart';

@immutable
abstract class GetMyGroupState {}

class GetMyGroupInitial extends GetMyGroupState {}
class SuccessStateee extends GetMyGroupState{

}

class LoadingStateee extends GetMyGroupState{

}
class ErrorStateee extends GetMyGroupState{

}

class SuccessStatedeletegroup1 extends GetMyGroupState{
  final MessageModel messageModel;
  SuccessStatedeletegroup1(this.messageModel);
}

class LoadingStatedeletegroup1 extends GetMyGroupState{

}
class ErrorStatedeletegroup1 extends GetMyGroupState{
  final ErrorModel errormodel;
  ErrorStatedeletegroup1(this.errormodel);
}
