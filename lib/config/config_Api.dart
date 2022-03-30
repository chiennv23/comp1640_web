// ignore_for_file: file_names

String urlApi = 'https://feedback-system-backend.herokuapp.com';

// register account
String urlRegister = '$urlApi/auth/register';

// login account
String urlLogin = '$urlApi/auth/login';

// get refresh token
String urlRefreshToken = '$urlApi/auth/refresh';

// urlPost
String urlPostProfile = '$urlApi/my-profile/';

//TODO COMMENTS
// get all comment a Post
String urlGetAllComments({String threadSlug, String postSlug}) {
  return '$urlApi/threads/$threadSlug/posts/$postSlug/comments';
}

// get a comment
String urlGetOneComment(
    {String threadSlug, String postSlug, String commentSlug}) {
  return '$urlApi/threads/$threadSlug/posts/$postSlug/comments/$commentSlug';
}

// create a comment
String urlPostNewComment({String threadSlug, String postSlug}) {
  return '$urlApi/threads/$threadSlug/posts/$postSlug/comments/create';
}

// update a comment
String urlPutUpdateComment(
    {String threadSlug, String postSlug, String commentSlug}) {
  return '$urlApi/threads/$threadSlug/posts/$postSlug/comments/update/$commentSlug';
}

// delete a comment
String urlDeleteComment(
    {String threadSlug, String postSlug, String commentSlug}) {
  return '$urlApi/threads/$threadSlug/posts/$postSlug/comments/delete/$commentSlug';
}

// like a comment
String urlLikeComment({String threadSlug, String postSlug, String cmtSlug}) {
  return '$urlApi/threads/$threadSlug/posts/$postSlug/comments/upvote/$cmtSlug';
}

// dislike a comment
String urlDislikeComment({String threadSlug, String postSlug, String cmtSlug}) {
  return '$urlApi/threads/$threadSlug/posts/$postSlug/comments/downvote/$cmtSlug';
}

//TODO POST
// get all posts in thread
String urlGetAllPosts({String threadSlug}) {
  return '$urlApi/threads/$threadSlug/posts';
}

// get a post by slug
String urlGetPostBySlug({String threadSlug, String postSlug}) {
  return '$urlApi/threads/$threadSlug/posts/$postSlug';
}

// create a post
String urlCreateNewPost(String threadSlug) {
  return '$urlApi/threads/$threadSlug/posts/create';
}

// Update a post
String urlUpdatePost({String threadSlug, String postSlug}) {
  return '$urlApi/threads/$threadSlug/posts/update/$postSlug';
}

// Delete a post
String urlDeletePost({String threadSlug, String postSlug}) {
  return '$urlApi/threads/$threadSlug/posts/delete/$postSlug';
}

// like a post
String urlLikePost({String threadSlug, String postSlug}) {
  return '$urlApi/threads/$threadSlug/posts/upvote/$postSlug';
}

// dislike a post
String urlDislikePost({String threadSlug, String postSlug}) {
  return '$urlApi/threads/$threadSlug/posts/downvote/$postSlug';
}

//TODO THREAD
// get threads list
String urlGetAllThread = '$urlApi/threads';

// get thread by slug
String urlGetThreadBySlug({String threadSlug}) {
  return '$urlApi/threads/$threadSlug';
}

// create a thread
String urlCreateThread = '$urlApi/threads/create';

// update a thread
String urlUpdateThread({String threadSlug}) {
  return '$urlApi/threads/update/$threadSlug';
}

// delete a thread
String urlDeleteThread({String threadSlug}) {
  return '$urlApi/threads/delete/$threadSlug';
}

///TODO MANAGE
String urlGetAllManageThread = '$urlApi/manage/threads';
