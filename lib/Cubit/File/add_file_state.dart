part of 'add_file_cubit.dart';

@immutable
abstract class AddFileState {}

class AddFileInitial extends AddFileState {}

class LoadingState11 extends AddFileState {}
class SuccessState11 extends AddFileState {
  // final Addnewgroup addnewgroup;
  // SuccessState11(this.addnewgroup);
}
class ErrorState11 extends AddFileState {
  // final ErrorModel errormodel;
  // ErrorState11(this.errormodel);

}
class SelectItemState extends AddFileState{
}

class UnSelectItemState extends AddFileState{
}


class LoadingState13 extends AddFileState {}
class SuccessState13 extends AddFileState {
  // final Addnewgroup addnewgroup;
  // SuccessState11(this.addnewgroup);
}
class ErrorState13 extends AddFileState {
  // final ErrorModel errormodel;
  // ErrorState11(this.errormodel);

}

class LoadingStatecheckin extends AddFileState {}
class SuccessStatecheckin extends AddFileState {
  final MessageModel messageModel;
  SuccessStatecheckin(this.messageModel);
}
class ErrorStatecheckin extends AddFileState {
  final ErrorModel errormodel;
  ErrorStatecheckin(this.errormodel);

}


class LoadingStatecheckout extends AddFileState {}
class SuccessStatecheckout extends AddFileState {
  final MessageModel messageModel;
  SuccessStatecheckout(this.messageModel);
}
class ErrorStatecheckout extends AddFileState {
  final ErrorModel errormodel;
  ErrorStatecheckout(this.errormodel);

}

class LoadingStatedeleteallfile extends AddFileState {}
class SuccessStatedeleteallfile extends AddFileState {
  final MessageModel messageModel;
  SuccessStatedeleteallfile(this.messageModel);
}
class ErrorStatedeleteallfile extends AddFileState {
  final ErrorModel errormodel;
  ErrorStatedeleteallfile(this.errormodel);

}


class LoadingState134 extends AddFileState {}
class SuccessState134 extends AddFileState {
  // final Addnewgroup addnewgroup;
  // SuccessState11(this.addnewgroup);
}
class ErrorState134 extends AddFileState {
  // final ErrorModel errormodel;
  // ErrorState11(this.errormodel);

}



class LoadingStateupdate extends AddFileState {}
class SuccessStateupdate extends AddFileState {
  final MessageModel messageModel;
  SuccessStateupdate(this.messageModel);
}
class ErrorStateupdate extends AddFileState {
  final ErrorModel errormodel;
  ErrorStateupdate(this.errormodel);

}



class LoadingStateadd extends AddFileState {}
class SuccessStateadd extends AddFileState {
  final MessageModel messageModel;
  SuccessStateadd(this.messageModel);
}
class ErrorStateadd extends AddFileState {
  final ErrorModel errormodel;
  ErrorStateadd(this.errormodel);

}


class LoadingStatedelfile extends AddFileState {}
class SuccessStatedelfile extends AddFileState {
  final MessageModel messageModel;
  SuccessStatedelfile(this.messageModel);
}
class ErrorStatedelfile extends AddFileState {
  final ErrorModel errormodel;
  ErrorStatedelfile(this.errormodel);

}
