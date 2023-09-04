class AppConst {
  static const APP_STORE_URL = '';
  static const PLAY_STORE_URL = '';

  static const String KEY = "lkzsejhfdcao87634w76w5ejzzhdgfci37qw64egAzjgxhc";
  static const String app_url = "https://animerush.in/api";
  // static const String app_url = "http://10.0.0.4:9923/api";

  static const String verion = "$app_url/website-details/";
  static const String signUp = "$app_url/sign-up/";
  static const String otpVerify = "$app_url/verify-otp/";
  static const String forgotPassword = "$app_url/forgot-password/";
  static const String changePassword = "$app_url/change-password/";
  static const String login = "$app_url/login/";
  static const String home = "$app_url/home-details/";
  static const String details = "$app_url/anime-details/";
  static const String episode = "$app_url/episode-details/";
  static const String search = "$app_url/filter/";
  static const String userFun = "$app_url/user-function/";
  static const String addWatch = "$app_url/add-watchlist/";

  static const String FONT = "Quicksand";
  static const String loginStatus = "false";

  static const String userName = "user_name";
  static const String email = "email";
  static const String token = "token";
  static const String otp = "otp";
  static const String apiStatus = "api_status";
  static const String dateJoined = "date_joined";
  static const String lastHomeApi = "last_home_api";
  static const String lastProfileApi = "last_profile_api";

  static const int duration = 1800;

  static RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static RegExp passwordRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  static const Map<String, String> exampleResolutionsUrls = {
    "360p":
        "https://tc-005.agetcdn.com/1ab5d45273a9183bebb58eb74d5722d8ea6384f350caf008f08cf018f1f0566d0cb82a2a799830d1af97cd3f4b6a9a81ef3aed2fb783292b1abcf1b8560a1d1aa308008b88420298522a9f761e5aa1024fbe74e5aa853cfc933cd1219327d1232e91847a185021b184c027f97ae732b3708ee6beb80ba5db6628ced43f1196fe/a80af13ae85820b664b87e68fa55f4c8/ep.1.1677593409.360.m3u8",
    "480p":
        "https://tc-005.agetcdn.com/1ab5d45273a9183bebb58eb74d5722d8ea6384f350caf008f08cf018f1f0566d0cb82a2a799830d1af97cd3f4b6a9a81ef3aed2fb783292b1abcf1b8560a1d1aa308008b88420298522a9f761e5aa1024fbe74e5aa853cfc933cd1219327d1232e91847a185021b184c027f97ae732b3708ee6beb80ba5db6628ced43f1196fe/a80af13ae85820b664b87e68fa55f4c8/ep.1.1677593409.480.m3u8",
    "720p":
        "https://tc-005.agetcdn.com/1ab5d45273a9183bebb58eb74d5722d8ea6384f350caf008f08cf018f1f0566d0cb82a2a799830d1af97cd3f4b6a9a81ef3aed2fb783292b1abcf1b8560a1d1aa308008b88420298522a9f761e5aa1024fbe74e5aa853cfc933cd1219327d1232e91847a185021b184c027f97ae732b3708ee6beb80ba5db6628ced43f1196fe/a80af13ae85820b664b87e68fa55f4c8/ep.1.1677593409.720.m3u8",
    "1080p":
        "https://tc-005.agetcdn.com/1ab5d45273a9183bebb58eb74d5722d8ea6384f350caf008f08cf018f1f0566d0cb82a2a799830d1af97cd3f4b6a9a81ef3aed2fb783292b1abcf1b8560a1d1aa308008b88420298522a9f761e5aa1024fbe74e5aa853cfc933cd1219327d1232e91847a185021b184c027f97ae732b3708ee6beb80ba5db6628ced43f1196fe/a80af13ae85820b664b87e68fa55f4c8/ep.1.1677593409.1080.m3u8",
  };
}
