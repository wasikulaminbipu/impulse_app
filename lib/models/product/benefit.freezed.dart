// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'benefit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Benefit {

 int get id; int get productId; String get textEn; String? get textBn; int get displayOrder;
/// Create a copy of Benefit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BenefitCopyWith<Benefit> get copyWith => _$BenefitCopyWithImpl<Benefit>(this as Benefit, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Benefit;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Benefit&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.productId, _this.productId) || other.productId == _this.productId)&&(identical(other.textEn, _this.textEn) || other.textEn == _this.textEn)&&(identical(other.textBn, _this.textBn) || other.textBn == _this.textBn)&&(identical(other.displayOrder, _this.displayOrder) || other.displayOrder == _this.displayOrder));
}


@override
int get hashCode {
  final _this = this as Benefit;
  return Object.hash(runtimeType,_this.id,_this.productId,_this.textEn,_this.textBn,_this.displayOrder);
}

@override
String toString() {
  final _this = this as Benefit;
  return 'Benefit(id: ${_this.id}, productId: ${_this.productId}, textEn: ${_this.textEn}, textBn: ${_this.textBn}, displayOrder: ${_this.displayOrder})';
}


}

/// @nodoc
abstract mixin class $BenefitCopyWith<$Res>  {
  factory $BenefitCopyWith(Benefit value, $Res Function(Benefit) _then) = _$BenefitCopyWithImpl;
@useResult
$Res call({
 int id, int productId, String textEn, String? textBn, int displayOrder
});




}
/// @nodoc
class _$BenefitCopyWithImpl<$Res>
    implements $BenefitCopyWith<$Res> {
  _$BenefitCopyWithImpl(this._self, this._then);

  final Benefit _self;
  final $Res Function(Benefit) _then;

/// Create a copy of Benefit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = null,Object? textEn = null,Object? textBn = freezed,Object? displayOrder = null,}) {
  return _then(Benefit(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,textEn: null == textEn ? _self.textEn : textEn // ignore: cast_nullable_to_non_nullable
as String,textBn: freezed == textBn ? _self.textBn : textBn // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Benefit].
extension BenefitPatterns on Benefit {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Benefit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Benefit() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Benefit value)  $default,){
final _that = this;
switch (_that) {
case _Benefit():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Benefit value)?  $default,){
final _that = this;
switch (_that) {
case _Benefit() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int productId,  String textEn,  String? textBn,  int displayOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Benefit() when $default != null:
return $default(_that.id,_that.productId,_that.textEn,_that.textBn,_that.displayOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int productId,  String textEn,  String? textBn,  int displayOrder)  $default,) {final _that = this;
switch (_that) {
case _Benefit():
return $default(_that.id,_that.productId,_that.textEn,_that.textBn,_that.displayOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int productId,  String textEn,  String? textBn,  int displayOrder)?  $default,) {final _that = this;
switch (_that) {
case _Benefit() when $default != null:
return $default(_that.id,_that.productId,_that.textEn,_that.textBn,_that.displayOrder);case _:
  return null;

}
}

}

/// @nodoc


class _Benefit implements Benefit {
  const _Benefit({required this.id, required this.productId, required this.textEn, this.textBn, this.displayOrder = 0});
  

@override final  int id;
@override final  int productId;
@override final  String textEn;
@override final  String? textBn;
@override@JsonKey() final  int displayOrder;

/// Create a copy of Benefit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BenefitCopyWith<_Benefit> get copyWith => __$BenefitCopyWithImpl<_Benefit>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Benefit&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.textEn, textEn) || other.textEn == textEn)&&(identical(other.textBn, textBn) || other.textBn == textBn)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,productId,textEn,textBn,displayOrder);
}

@override
String toString() {
    return 'Benefit(id: $id, productId: $productId, textEn: $textEn, textBn: $textBn, displayOrder: $displayOrder)';
}


}

/// @nodoc
abstract mixin class _$BenefitCopyWith<$Res> implements $BenefitCopyWith<$Res> {
  factory _$BenefitCopyWith(_Benefit value, $Res Function(_Benefit) _then) = __$BenefitCopyWithImpl;
@override @useResult
$Res call({
 int id, int productId, String textEn, String? textBn, int displayOrder
});




}
/// @nodoc
class __$BenefitCopyWithImpl<$Res>
    implements _$BenefitCopyWith<$Res> {
  __$BenefitCopyWithImpl(this._self, this._then);

  final _Benefit _self;
  final $Res Function(_Benefit) _then;

/// Create a copy of Benefit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = null,Object? textEn = null,Object? textBn = freezed,Object? displayOrder = null,}) {
  return _then(_Benefit(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,textEn: null == textEn ? _self.textEn : textEn // ignore: cast_nullable_to_non_nullable
as String,textBn: freezed == textBn ? _self.textBn : textBn // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: null == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
