import 'package:flutter/material.dart';

/// Defines the search target scope for product search in Impulse.
enum SearchScope {
  all,
  symptom,
  ingredient,
  name,
}

extension SearchScopeExtension on SearchScope {
  String get labelEn {
    switch (this) {
      case SearchScope.all:
        return 'All';
      case SearchScope.symptom:
        return 'Symptom';
      case SearchScope.ingredient:
        return 'Ingredient';
      case SearchScope.name:
        return 'Name';
    }
  }

  String get labelBn {
    switch (this) {
      case SearchScope.all:
        return 'সব';
      case SearchScope.symptom:
        return 'উপসর্গ/রোগ';
      case SearchScope.ingredient:
        return 'উপাদান';
      case SearchScope.name:
        return 'নাম';
    }
  }

  String label(String lang) => lang == 'bn' ? labelBn : labelEn;

  String get hintEn {
    switch (this) {
      case SearchScope.all:
        return 'Search products, ingredients, symptoms...';
      case SearchScope.symptom:
        return 'Search by symptom or disease (e.g. Mastitis)...';
      case SearchScope.ingredient:
        return 'Search by active ingredient (e.g. Amoxicillin)...';
      case SearchScope.name:
        return 'Search by product brand name...';
    }
  }

  String get hintBn {
    switch (this) {
      case SearchScope.all:
        return 'পণ্য, উপাদান, উপসর্গ খুঁজুন...';
      case SearchScope.symptom:
        return 'উপসর্গ বা রোগ দিয়ে খুঁজুন...';
      case SearchScope.ingredient:
        return 'সক্রিয় উপাদান দিয়ে খুঁজুন...';
      case SearchScope.name:
        return 'পণ্যের নাম দিয়ে খুঁজুন...';
    }
  }

  String hint(String lang) => lang == 'bn' ? hintBn : hintEn;

  IconData get icon {
    switch (this) {
      case SearchScope.all:
        return Icons.search;
      case SearchScope.symptom:
        return Icons.healing;
      case SearchScope.ingredient:
        return Icons.science;
      case SearchScope.name:
        return Icons.medication;
    }
  }
}
