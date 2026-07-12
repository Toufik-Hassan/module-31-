class Urls {
  static const String _baseUrl =
      "https://craftybay.teamrabbil.com/api";

  // ===========================
  // User
  // ===========================

  static String userLogin(String email) =>
      "$_baseUrl/UserLogin/$email";

  static String verifyOtp(
    String email,
    String otp,
  ) =>
      "$_baseUrl/VerifyLogin/$email/$otp";

  static const String createProfile =
      "$_baseUrl/CreateProfile";

  static const String readProfile =
      "$_baseUrl/ReadProfile";

  // ===========================
  // Home
  // ===========================

  static const String sliderList =
      "$_baseUrl/ListProductSlider";

  static const String categoryList =
      "$_baseUrl/CategoryList";

  static const String brandList =
      "$_baseUrl/BrandList";

  // ===========================
  // Product
  // ===========================

  static String productByCategory(int id) =>
      "$_baseUrl/ListProductByCategory/$id";

  static String productByBrand(int id) =>
      "$_baseUrl/ListProductByBrand/$id";

  static String productByRemark(String remark) =>
      "$_baseUrl/ListProductByRemark/$remark";

  static String productDetails(int id) =>
      "$_baseUrl/ProductDetailsById/$id";

  // ===========================
  // Review
  // ===========================

  static String reviewList(int productId) =>
      "$_baseUrl/ListReviewByProduct/$productId";

  static const String createReview =
      "$_baseUrl/CreateProductReview";

  // ===========================
  // Wishlist
  // ===========================

  static const String wishlist =
      "$_baseUrl/ProductWishList";

  static String createWishlist(int productId) =>
      "$_baseUrl/CreateWishList/$productId";

  // ===========================
  // Cart
  // ===========================

  static const String cartList =
      "$_baseUrl/CartList";

  static const String createCart =
      "$_baseUrl/CreateCartList";

  static String deleteCart(int id) =>
      "$_baseUrl/DeleteCartList/$id";
}
