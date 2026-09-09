import 'package:flutter/material.dart';

/// Defines the search target scope for product search in Impulse.
enum SearchScope { all, symptom, ingredient, name }

extension SearchScopeExtension on SearchScope {
  String get labelEn => switch (this) {
    SearchScope.all => 'All',
    SearchScope.symptom => 'Symptom',
    SearchScope.ingredient => 'Ingredient',
    SearchScope.name => 'Name',
  };

  String get labelBn => switch (this) {
    SearchScope.all => 'সব',
    SearchScope.symptom => 'উপসর্গ/রোগ',
    SearchScope.ingredient => 'উপাদান',
    SearchScope.name => 'নাম',
  };

  String label(String lang) => lang == 'bn' ? labelBn : labelEn;

  String get hintEn => switch (this) {
    SearchScope.all => 'Search products, ingredients, symptoms...',
    SearchScope.symptom => 'Search by symptom or disease (e.g. Mastitis)...',
    SearchScope.ingredient =>
      'Search by active ingredient (e.g. Amoxicillin)...',
    SearchScope.name => 'Search by product brand name...',
  };

  String get hintBn => switch (this) {
    SearchScope.all => 'পণ্য, উপাদান, উপসর্গ খুঁজুন...',
    SearchScope.symptom => 'উপসর্গ বা রোগ দিয়ে খুঁজুন...',
    SearchScope.ingredient => 'সক্রিয় উপাদান দিয়ে খুঁজুন...',
    SearchScope.name => 'পণ্যের নাম দিয়ে খুঁজুন...',
  };

  String hint(String lang) => lang == 'bn' ? hintBn : hintEn;

  IconData get icon => switch (this) {
    SearchScope.all => Icons.search,
    SearchScope.symptom => Icons.healing,
    SearchScope.ingredient => Icons.science,
    SearchScope.name => Icons.medication,
  };
}
