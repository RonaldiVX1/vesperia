import 'package:entrance_test/src/models/product_model.dart';
import 'package:entrance_test/src/models/rating_model.dart';
import 'package:entrance_test/src/models/request/rating_request_model.dart';
import 'package:entrance_test/src/repositories/product_repository.dart';
import 'package:entrance_test/src/utils/networking_util.dart';
import 'package:entrance_test/src/widgets/snackbar_widget.dart';
import 'package:get/get.dart';

class DetailProductController extends GetxController {
  final ProductRepository _productRepository;

  DetailProductController({
    required ProductRepository productRepository,
  }) : _productRepository = productRepository;

  late ProductModel product;
  // late RatingModel rating;

  final _rating = Rx<List<RatingModel>>([]);

  List<RatingModel> get rating => _rating.value;

  @override
  void onInit() {
    super.onInit();
    product = Get.arguments as ProductModel;
    getRating(product);
  }

  Future<void> getRating(ProductModel product) async {
    try {
      final ratingList = await _productRepository.getRatingProduct(RatingRequestModel(
        limit: 3,
        page: 1,
      ));
      _rating.value = ratingList.data;
      _rating.refresh();
    } catch (error) {
      SnackbarWidget.showFailedSnackbar(NetworkingUtil.errorMessage("$error  errorr"));
    }
  }
}
