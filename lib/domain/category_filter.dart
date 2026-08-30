import 'package:collection/collection.dart';
import 'package:impulse_app/models/product.dart';
import 'package:impulse_app/utils/app_constants.dart';

class CategoryFilterCriteria {
  final bool isFeedAdditive;
  final int? categoryId;
  final int? targetGroupId;

  CategoryFilterCriteria({
    this.isFeedAdditive = false,
    this.categoryId,
    this.targetGroupId,
  });
}

CategoryFilterCriteria resolveCategoryFilter(
  String category,
  List<Category> categories,
  List<TargetGroup> targetGroups,
) {
  if (category == AppConstants.categoryAll) return CategoryFilterCriteria();

  final catLower = category.toLowerCase().trim();

  if (catLower == AppConstants.categoryFeedAdditives.toLowerCase() ||
      catLower == AppConstants.categoryFeedAdditive.toLowerCase()) {
    return CategoryFilterCriteria(isFeedAdditive: true);
  } else if (catLower == AppConstants.categoryVaccine.toLowerCase() ||
      catLower == AppConstants.categoryVaccines.toLowerCase()) {
    final matchedCategory = categories.firstWhereOrNull(
      (c) =>
          c.nameEn.toLowerCase() ==
              AppConstants.categoryVaccine.toLowerCase() ||
          c.nameEn.toLowerCase() == AppConstants.categoryVaccines.toLowerCase(),
    );
    return CategoryFilterCriteria(categoryId: matchedCategory?.id ?? -1);
  } else {
    final matchedGroup = targetGroups.firstWhereOrNull(
      (g) =>
          g.nameEn.toLowerCase() == catLower ||
          '${g.nameEn.toLowerCase()}s' == catLower ||
          g.nameEn.toLowerCase() == '${catLower}s',
    );
    if (matchedGroup != null) {
      return CategoryFilterCriteria(targetGroupId: matchedGroup.id);
    } else {
      final matchedCategory = categories.firstWhereOrNull(
        (c) =>
            c.nameEn.toLowerCase() == catLower ||
            '${c.nameEn.toLowerCase()}s' == catLower ||
            c.nameEn.toLowerCase() == '${catLower}s',
      );
      if (matchedCategory != null) {
        return CategoryFilterCriteria(categoryId: matchedCategory.id);
      } else {
        return CategoryFilterCriteria(categoryId: -1);
      }
    }
  }
}
