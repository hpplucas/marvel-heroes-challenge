class Utils {
  Utils._();

  static String convertCharImagePathToAssetPath(String charImagePath) {
    return 'assets/${charImagePath.split('./')[1]}';
  }
}