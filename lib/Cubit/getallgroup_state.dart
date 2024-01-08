part of 'getallgroup_cubit.dart';

@immutable
abstract class GetallgroupState {}

class GetallgroupInitial extends GetallgroupState {}

class SuccessState extends GetallgroupState{

}

class LoadingState extends GetallgroupState{

}
class ErrorState extends GetallgroupState{

}


/////////////////
class SuccessStateleavegroup extends GetallgroupState{
  final MessageModel messageModel;
  SuccessStateleavegroup(this.messageModel);
}

class LoadingStateleavegroup extends GetallgroupState{

}
class ErrorStateleavegroup extends GetallgroupState{
  final ErrorModel errormodel;
  ErrorStateleavegroup(this.errormodel);
}

