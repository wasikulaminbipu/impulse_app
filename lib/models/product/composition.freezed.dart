// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'composition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Composition {

 int get id; int get productId; String get ingredientEn; String? get ingredientBn; String? get concentration; int get displayOrder;
/// Create a copy of Composition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompositionCopyWith<Composition> get copyWith => _$CompositionCopyWithImpl<Composition>(this as Composition, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Composition&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.ingredientEn, ingredientEn) || other.ingredientEn == ingredientEn)&&(identical(other.ingredientBn, ingredientBn) || other.ingredientBn == ingredientBn)&&(identical(other.concentration, concentration) || other.concentration == concentration)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,ingredientEn,ingredientBn,concentration,displayOrder);

@override
String toString() {
  return 'Composition(id: $id, productId: $productId, ingredientEn: $ingredientEn, ingredientBn: $ingredientBn, concentration: $concentration, displayOrder: $displayOrder)';
}


}

/// @nodoc
abstract mixin class $CompositionCopyWith<$Res>  {
  factory $CompositionCopyWith(Composition value, $Res Function(Composition) _then) = _$CompositionCopyWithImpl;
@useResult
$Res call({
 int id, int productId, String ingredientEn, String? ingredientBn, String? concentration, int displayOrder
});




}
/// @nodoc
class _$CompositionCopyWithImpl<$Res>
    implements $CompositionCopyWith<$Res> {
  _$CompositionCopyWithImpl(this._self, this._then);

  final Composition _self;
  final $Res Function(Composition) _then;

/// Create a copy of Composition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = null,Object? ingredientEn = null,Object? ingredientBn = freezed,Object? concentration = freezed,Object? displayOrder = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,ingredientEn: null == ingredientEn ? _self.ingredientEn : ingredientEn // ignore: cast_nullable_to_non_nullable
as String,ingredientBn: freezed == ingredientBn ? _self.ingredientBn : ingredientBn // ignore: cast_nullable_to_non_nullable
as String?,concentration: freezed == concentration ? _self.concentration : concentration // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Composition].
extension CompositionPatterns on Composition {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Composition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Composition() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Composition value)  $default,){
final _that = this;
switch (_that) {
case _Composition():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Composition value)?  $default,){
final _that = this;
switch (_that) {
case _Composition() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int productId,  String ingredientEn,  String? ingredientBn,  String? concentration,  int displayOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Composition() when $default != null:
return $default(_that.id,_that.productId,_that.ingredientEn,_that.ingredientBn,_that.concentration,_that.displayOrder);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int productId,  String ingredientEn,  String? ingredientBn,  String? concentration,  int displayOrder)  $default,) {final _that = this;
switch (_that) {
case _Composition():
return $default(_that.id,_that.productId,_that.ingredientEn,_that.ingredientBn,_that.concentration,_that.displayOrder);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int productId,  String ingredientEn,  String? ingredientBn,  String? concentration,  int displayOrder)?  $default,) {final _that = this;
switch (_that) {
case _Composition() when $default != null:
return $default(_that.id,_that.productId,_that.ingredientEn,_that.ingredientBn,_that.concentration,_that.displayOrder);case _:
  return null;

}
}

}

/// @nodoc


class _Composition implements Composition {
  const _Composition({required this.id, required this.productId, required this.ingredientEn, this.ingredientBn, this.concentration, this.displayOrder = 0});
  

@override final  int id;
@override final  int productId;
@override final  String ingredientEn;
@override final  String? ingredientBn;
@override final  String? concentration;
@override@JsonKey() final  int displayOrder;

/// Create a copy of Composition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompositionCopyWith<_Composition> get copyWith => __$CompositionCopyWithImpl<_Composition>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Composition&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.ingredientEn, ingredientEn) || other.ingredientEn == ingredientEn)&&(identical(other.ingredientBn, ingredientBn) || other.ingredientBn == ingredientBn)&&(identical(other.concentration, concentration) || other.concentration == concentration)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,productId,ingredientEn,ingredientBn,concentration,displayOrder);

@override
String toString() {
  return 'Composition(id: $id, productId: $productId, ingredientEn: $ingredientEn, ingredientBn: $ingredientBn, concentration: $concentration, displayOrder: $displayOrder)';
}


}

/// @nodoc
abstract mixin class _$CompositionCopyWith<$Res> implements $CompositionCopyWith<$Res> {
  factory _$CompositionCopyWith(_Composition value, $Res Function(_Composition) _then) = __$CompositionCopyWithImpl;
@override @useResult
$Res call({
 int id, int productId, String ingredientEn, String? ingredientBn, String? concentration, int displayOrder
});




}
/// @nodoc
class __$CompositionCopyWithImpl<$Res>
    implements _$CompositionCopyWith<$Res> {
  __$CompositionCopyWithImpl(this._self, this._then);

  final _Composition _self;
  final $Res Function(_Composition) _then;

/// Create a copy of Composition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = null,Object? ingredientEn = null,Object? ingredientBn = freezed,Object? concentration = freezed,Object? displayOrder = null,}) {
  return _then(_Composition(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,ingredientEn: null == ingredientEn ? _self.ingredientEn : ingredientEn // ignore: cast_nullable_to_non_nullable
as String,ingredientBn: freezed == ingredientBn ? _self.ingredientBn : ingredientBn // ignore: cast_nullable_to_non_nullable
as String?,concentration: freezed == concentration ? _self.concentration : concentration // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
