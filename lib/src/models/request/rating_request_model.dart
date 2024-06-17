class RatingRequestModel {
  RatingRequestModel({int? limit, int? page, String? productId})
      : _limit = limit ?? 10,
        _page = page ?? 0,
        _productId = productId ?? "995a435d-f2ef-436f-90ed-f65a5260ee52";

  final int _limit;
  final int _page;
  final String _productId;

  Map<String, dynamic> toJson() => {'page': _page, 'limit': _limit, 'product_id': _productId};

  @override
  String toString() {
    return toJson().toString();
  }
}
