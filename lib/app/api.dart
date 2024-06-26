class ApiUrl {
  static const baseUrl = "https://social-api-trlr.onrender.com";

  //endpoints

  //auth
  static const signUp = "/api/users/signUp";
  static const signIn = "/api/users/login";
  static const signOut = "/api/users/logout";
  static const forgotPassword = "/api/users/forgotPassword";

  //posts
  static const getPosts = "/api/posts/";
  static const createPost = "/api/posts/";
  static const deletePost = "/api/posts/deleteMyPost/";
  static const updatePost = "/api/posts/";
  static const updatePostPhoto = "/api/posts/uploadPostPhoto/";

  //chats
  static const getChats = "/api/messages/all";
  static const sendChat = "/api/messages/send/";

  //comments
  static const getComments = "/api/comments/";
  static const createComment = "/api/comments/";
  static const deleteComment = "/api/comments/deleteMyComment/";
  static const updateComment = "/api/comments/";
  static const updateCommentPhoto = "/api/comments/uploadCommentPhoto/";

  //likes
  static const getLikes = "/api/likes/";
  static const createLike = "/api/likes/";
  static const deleteLike = "/api/likes/";

  //campaigns
  static const getCampaigns = "/api/donationCampaigns/";
  static const createCampaign = "/api/donationCampaigns/";
  static const deleteCampaign = "/api/donationCampaigns/";
  static const updateCampaign = "/api/donationCampaigns/";
  static const updateCampaignPhoto =
      "/api/donationCampaigns/uploadDonationCampaignPhoto/";
  static const payment = "/api/payments/payment";

  //profile
  static const getProfile = "/api/users/getMe";
  static const updateProfile = "/api/users/updateMe";
  static const deleteProfile = "/api/users/deleteMe";
}
//seyexey683@morxin.com
