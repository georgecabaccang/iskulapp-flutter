
class TextConstants {
 
static String loginMessage = "Hi Student";
static String signinMessage = "Sign in to continue";


  // Constants with dynamic parameters
  static String homePageMessage(String username, String lastname) {
    return "Hi, $username $lastname";
  }

}
