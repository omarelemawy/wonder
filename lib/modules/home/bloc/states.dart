abstract class HomeStates{}

class InitialHomeStates extends HomeStates{}

class GetSuccessMostSharingDataHomeStates extends HomeStates{}

class GetLoadingMostSharingDataHomeStates extends HomeStates{}

class GetErrorMostSharingDataHomeStates extends HomeStates{
  String error;
  GetErrorMostSharingDataHomeStates(this.error);
}
class GetSuccessSearchDataHomeStates extends HomeStates{}

class GetLoadingSearchDataHomeStates extends HomeStates{}

class GetErrorSearchDataHomeStates extends HomeStates{
  String error;
  GetErrorSearchDataHomeStates(this.error);
}
class GetSuccessNewDataHomeStates extends HomeStates{}

class GetLoadingNewDataHomeStates extends HomeStates{}

class GetErrorNewDataHomeStates extends HomeStates{
  String error;
  GetErrorNewDataHomeStates(this.error);
}

class ChangeBottomNevHomeStates extends HomeStates{}
class ChangeBottomNevHomeStatesOrganizer extends HomeStates{}

class LangChangeHomeState extends HomeStates{}
class ChangeCommentState extends HomeStates{}

class GetSuccessProfileDataHomeStates extends HomeStates{}

class GetLoadingProfileDataHomeStates extends HomeStates{}


class GetErrorProfileDataHomeStates extends HomeStates{
  String error;
  GetErrorProfileDataHomeStates(this.error);
}
class GetSuccessFavoriteDataHomeStates extends HomeStates{}

class GetLoadingFavoriteDataHomeStates extends HomeStates{}

class GetErrorFavoriteDataHomeStates extends HomeStates{
  String error;
  GetErrorFavoriteDataHomeStates(this.error);
}
class GetSuccessEditProfileHomeStates extends HomeStates{}

class GetLoadingEditProfileHomeStates extends HomeStates{}

class GetErrorEditProfileHomeStates extends HomeStates{
  String error;
  GetErrorEditProfileHomeStates(this.error);
}
class LogOutSuccessStates extends HomeStates{}

class LogOutLoadingStates extends HomeStates{}

class GetImageEditProfileStates extends HomeStates{}

class GetIsLikeStates extends HomeStates{}

class LogOutErrorStates extends HomeStates{
  String error;
  LogOutErrorStates(this.error);
}

class GetSuccessEventDetailDataHomeStates extends HomeStates{}

class SendCommentSuccessHomeStates extends HomeStates{}

class SendCommentLoadingHomeStates extends HomeStates{}

class GetLoadingEventDetailDataHomeStates extends HomeStates{}

class ChangeCityHomeStates extends HomeStates{}

class ChangeCategoryHomeStates extends HomeStates{}

class GetErrorEventDetailDataHomeStates extends HomeStates{
  String error;
  GetErrorEventDetailDataHomeStates(this.error);
}

class SendMailSuccessStates extends HomeStates{}

class SendMailLoadingStates extends HomeStates{}

class SendMailErrorStates extends HomeStates{
  String error;
  SendMailErrorStates(this.error);
}

