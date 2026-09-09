import 'package:collection/collection.dart';
import 'package:impulse_app/constants/app_constants.dart';
import 'package:impulse_app/models/product.dart';

/// Encapsulates resolved filtering criteria for querying products.
///
/// Disambiguates whether a user-selected tab corresponds to a special feed additive
/// attribute, a target group identifier, or a category identifier.
class CategoryFilterCriteria {
  final bool isFeedAdditive;
  final int? categoryId;
  final int? targetGroupId;

  const CategoryFilterCriteria({
    this.isFeedAdditive = false,
    this.categoryId,
    this.targetGroupId,
  });
}

/// Resolves a localized or English [category] label into concrete [CategoryFilterCriteria].
///
/// Follows priority matching order:
/// 1. 'All' tab (no filters applied)
/// 2. Feed Additives special domain filter
/// 3. Vaccines category matching
/// 4. Target Group fuzzy matching (singular/plural)
/// 5. Category fuzzy matching (singular/plural)
CategoryFilterCriteria resolveCategoryFilter(
  String category,
  List<Category> categories,
  List<TargetGroup> targetGroups,
) {
  if (category == AppConstants.categoryAll) {
    return const CategoryFilterCriteria();
  }

  final catLower = category.toLowerCase().trim();

  if (catLower == AppConstants.categoryFeedAdditives.toLowerCase() ||
      catLower == AppConstants.categoryFeedAdditive.toLowerCase()) {
    return const CategoryFilterCriteria(isFeedAdditive: true);
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
        return const CategoryFilterCriteria(categoryId: -1);
      }
    }
  }
}
