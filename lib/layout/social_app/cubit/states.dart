abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

class SocialUserLoadingErrorState extends SocialStates {}

class SocialUserUpdateLoadingState extends SocialStates {}

//create post
class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

//get post

class SocialGetPostSuccessState extends SocialStates {}

class SocialGetPostLoadingState extends SocialStates {}

class SocialGetPostErrorState extends SocialStates {
  final String error;

  SocialGetPostErrorState(this.error);
}

//post likes
class SocialPostLikesSuccessState extends SocialStates {}

class SocialPostLikesErrorState extends SocialStates {
  final String error;

  SocialPostLikesErrorState(this.error);
}
//comments
class SocialPostCommentsSuccessState extends SocialStates {}

class SocialPostCommentErrorState extends SocialStates {
  final String error;

  SocialPostCommentErrorState(this.error);
}