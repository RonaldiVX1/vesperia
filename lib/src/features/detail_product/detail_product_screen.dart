import 'package:entrance_test/src/constants/color.dart';
import 'package:entrance_test/src/constants/font.dart';
import 'package:entrance_test/src/constants/string.dart';
import 'package:entrance_test/src/features/detail_product/component/detail_product_controller.dart';
import 'package:entrance_test/src/models/rating_model.dart';
import 'package:entrance_test/src/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailProductScreen extends GetWidget<DetailProductController> {
  const DetailProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray100,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text("Detail Product"),
      ),
      body: ListView(
        children: [
          Image.asset(
            "assets/images/img_onboarding.png",
            height: 360,
          ),
          title(),
          productDescription(),
          tacOfReturnRefund(),
          SizedBox(height: 5),
          Obx(() {
            if (controller.rating.isNotEmpty) {
              return reviewSection();
            } else {
              return const SizedBox();
            }
          })
        ],
      ),
    );
  }

  Widget title() {
    return Container(
      color: white,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.product.name,
            style: regularBlack.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            "Rp${controller.product.price.toString()}",
            style: boldBlack.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.yellow.shade600,
              ),
              Text(
                "4.8",
                style: semiBoldBlack.copyWith(
                  fontSize: 14,
                ),
              ),
              SizedBox(width: 4),
              Text(
                "(248 Review)",
                style: regularBlack.copyWith(fontSize: 14, color: gray500),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget productDescription() {
    return Container(
      color: white,
      margin: EdgeInsets.only(top: 4),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Product Description",
            style: semiBoldBlack.copyWith(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(controller.product.description ?? "")
        ],
      ),
    );
  }

  Widget tacOfReturnRefund() {
    return Container(
      color: white,
      margin: EdgeInsets.only(top: 4),
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Terms & Conditions of Return / Refund",
            style: semiBoldBlack.copyWith(fontSize: 16),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            child: Row(
              children: [
                Flexible(
                  child: Column(children: _buildNumberedText(tacRefundText)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget reviewSection() {
    return Container(
      color: white,
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Product Review",
                style: semiBoldBlack.copyWith(fontSize: 16),
              ),
              Text(
                "See More",
                style: semiBoldBlack.copyWith(fontSize: 16, color: primary),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.yellow.shade600,
                size: 20,
              ),
              SizedBox(width: 4),
              Text(
                "4.8",
                style: semiBoldBlack.copyWith(
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                "from 302 rating * 248 reviews",
                style: regularBlack.copyWith(fontSize: 14, color: gray500),
              ),
            ],
          ),
          Column(
            children: List.generate(controller.rating.length, (index) => boxReview(controller.rating[index].user, controller.rating[index])),
          ),
        ],
      ),
    );
  }

  Widget boxReview(UserModel user, RatingModel ratingModel) {
    return Container(
      height: 100,
      margin: EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: NetworkImage(user.profilePicture!)),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                children: [
                  Text(
                    user.name,
                    style: semiBoldBlack,
                  ),
                  starsRating(ratingModel.rating),
                ],
              ),
              const Spacer(),
              Text("See More", style: semiBoldBlack.copyWith(fontSize: 16, color: primary)),
            ],
          ),
          const SizedBox(height: 12),
          Text(ratingModel.review)
        ],
      ),
    );
  }

  List<Widget> _buildNumberedText(String text) {
    final lines = text.split('\n');
    return List.generate(lines.length, (index) {
      final lineNumber = index + 1;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$lineNumber. ',
            style: TextStyle(
              fontSize: 16,
              height: 1.55,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
              child: Text(
                lines[index],
                textAlign: TextAlign.left,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.55,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget starsRating(int rating) {
    return Row(
      children: [
        Icon(
          Icons.star_rate_sharp,
          color: rating == 1 ? gray200 : Colors.yellow,
        ),
        Icon(
          Icons.star_rate_sharp,
          color: rating == 2 ? gray200 : Colors.yellow,
        ),
        Icon(
          Icons.star_rate_sharp,
          color: rating == 3 ? gray200 : Colors.yellow,
        ),
        Icon(
          Icons.star_rate_sharp,
          color: rating == 4 ? gray200 : Colors.yellow,
        ),
        Icon(
          Icons.star_rate_sharp,
          color: rating == 5 ? gray200 : Colors.yellow,
        ),
      ],
    );
  }
}
