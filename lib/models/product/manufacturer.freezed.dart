// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manufacturer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Manufacturer {

 int get id; String get nameEn; String? get nameBn; String? get addressEn; String? get addressBn; String? get countryOfOriginEn; String? get countryOfOriginBn; String? get email; String? get website; String? get mobile; String? get logoUrl;
/// Create a copy of Manufacturer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ManufacturerCopyWith<Manufacturer> get copyWith => _$ManufacturerCopyWithImpl<Manufacturer>(this as Manufacturer, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Manufacturer&&(identical(other.id, id) || other.id == id)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn)&&(identical(other.addressEn, addressEn) || other.addressEn == addressEn)&&(identical(other.addressBn, addressBn) || other.addressBn == addressBn)&&(identical(other.countryOfOriginEn, countryOfOriginEn) || other.countryOfOriginEn == countryOfOriginEn)&&(identical(other.countryOfOriginBn, countryOfOriginBn) || other.countryOfOriginBn == countryOfOriginBn)&&(identical(other.email, email) || other.email == email)&&(identical(other.website, website) || other.website == website)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,nameEn,nameBn,addressEn,addressBn,countryOfOriginEn,countryOfOriginBn,email,website,mobile,logoUrl);

@override
String toString() {
  return 'Manufacturer(id: $id, nameEn: $nameEn, nameBn: $nameBn, addressEn: $addressEn, addressBn: $addressBn, countryOfOriginEn: $countryOfOriginEn, countryOfOriginBn: $countryOfOriginBn, email: $email, website: $website, mobile: $mobile, logoUrl: $logoUrl)';
}


}

/// @nodoc
abstract mixin class $ManufacturerCopyWith<$Res>  {
  factory $ManufacturerCopyWith(Manufacturer value, $Res Function(Manufacturer) _then) = _$ManufacturerCopyWithImpl;
@useResult
$Res call({
 int id, String nameEn, String? nameBn, String? addressEn, String? addressBn, String? countryOfOriginEn, String? countryOfOriginBn, String? email, String? website, String? mobile, String? logoUrl
});




}
/// @nodoc
class _$ManufacturerCopyWithImpl<$Res>
    implements $ManufacturerCopyWith<$Res> {
  _$ManufacturerCopyWithImpl(this._self, this._then);

  final Manufacturer _self;
  final $Res Function(Manufacturer) _then;

/// Create a copy of Manufacturer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? nameEn = null,Object? nameBn = freezed,Object? addressEn = freezed,Object? addressBn = freezed,Object? countryOfOriginEn = freezed,Object? countryOfOriginBn = freezed,Object? email = freezed,Object? website = freezed,Object? mobile = freezed,Object? logoUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameBn: freezed == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String?,addressEn: freezed == addressEn ? _self.addressEn : addressEn // ignore: cast_nullable_to_non_nullable
as String?,addressBn: freezed == addressBn ? _self.addressBn : addressBn // ignore: cast_nullable_to_non_nullable
as String?,countryOfOriginEn: freezed == countryOfOriginEn ? _self.countryOfOriginEn : countryOfOriginEn // ignore: cast_nullable_to_non_nullable
as String?,countryOfOriginBn: freezed == countryOfOriginBn ? _self.countryOfOriginBn : countryOfOriginBn // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,mobile: freezed == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Manufacturer].
extension ManufacturerPatterns on Manufacturer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Manufacturer value)?  $default,{TResult Function( _ManufacturerEmpty value)?  empty,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Manufacturer() when $default != null:
return $default(_that);case _ManufacturerEmpty() when empty != null:
return empty(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Manufacturer value)  $default,{required TResult Function( _ManufacturerEmpty value)  empty,}){
final _that = this;
switch (_that) {
case _Manufacturer():
return $default(_that);case _ManufacturerEmpty():
return empty(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Manufacturer value)?  $default,{TResult? Function( _ManufacturerEmpty value)?  empty,}){
final _that = this;
switch (_that) {
case _Manufacturer() when $default != null:
return $default(_that);case _ManufacturerEmpty() when empty != null:
return empty(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String nameEn,  String? nameBn,  String? addressEn,  String? addressBn,  String? countryOfOriginEn,  String? countryOfOriginBn,  String? email,  String? website,  String? mobile,  String? logoUrl)?  $default,{TResult Function( int id,  String nameEn,  String? nameBn,  String? addressEn,  String? addressBn,  String? countryOfOriginEn,  String? countryOfOriginBn,  String? email,  String? website,  String? mobile,  String? logoUrl)?  empty,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Manufacturer() when $default != null:
return $default(_that.id,_that.nameEn,_that.nameBn,_that.addressEn,_that.addressBn,_that.countryOfOriginEn,_that.countryOfOriginBn,_that.email,_that.website,_that.mobile,_that.logoUrl);case _ManufacturerEmpty() when empty != null:
return empty(_that.id,_that.nameEn,_that.nameBn,_that.addressEn,_that.addressBn,_that.countryOfOriginEn,_that.countryOfOriginBn,_that.email,_that.website,_that.mobile,_that.logoUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String nameEn,  String? nameBn,  String? addressEn,  String? addressBn,  String? countryOfOriginEn,  String? countryOfOriginBn,  String? email,  String? website,  String? mobile,  String? logoUrl)  $default,{required TResult Function( int id,  String nameEn,  String? nameBn,  String? addressEn,  String? addressBn,  String? countryOfOriginEn,  String? countryOfOriginBn,  String? email,  String? website,  String? mobile,  String? logoUrl)  empty,}) {final _that = this;
switch (_that) {
case _Manufacturer():
return $default(_that.id,_that.nameEn,_that.nameBn,_that.addressEn,_that.addressBn,_that.countryOfOriginEn,_that.countryOfOriginBn,_that.email,_that.website,_that.mobile,_that.logoUrl);case _ManufacturerEmpty():
return empty(_that.id,_that.nameEn,_that.nameBn,_that.addressEn,_that.addressBn,_that.countryOfOriginEn,_that.countryOfOriginBn,_that.email,_that.website,_that.mobile,_that.logoUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String nameEn,  String? nameBn,  String? addressEn,  String? addressBn,  String? countryOfOriginEn,  String? countryOfOriginBn,  String? email,  String? website,  String? mobile,  String? logoUrl)?  $default,{TResult? Function( int id,  String nameEn,  String? nameBn,  String? addressEn,  String? addressBn,  String? countryOfOriginEn,  String? countryOfOriginBn,  String? email,  String? website,  String? mobile,  String? logoUrl)?  empty,}) {final _that = this;
switch (_that) {
case _Manufacturer() when $default != null:
return $default(_that.id,_that.nameEn,_that.nameBn,_that.addressEn,_that.addressBn,_that.countryOfOriginEn,_that.countryOfOriginBn,_that.email,_that.website,_that.mobile,_that.logoUrl);case _ManufacturerEmpty() when empty != null:
return empty(_that.id,_that.nameEn,_that.nameBn,_that.addressEn,_that.addressBn,_that.countryOfOriginEn,_that.countryOfOriginBn,_that.email,_that.website,_that.mobile,_that.logoUrl);case _:
  return null;

}
}

}

/// @nodoc


class _Manufacturer extends Manufacturer {
  const _Manufacturer({required this.id, required this.nameEn, this.nameBn, this.addressEn, this.addressBn, this.countryOfOriginEn, this.countryOfOriginBn, this.email, this.website, this.mobile, this.logoUrl}): super._();
  

@override final  int id;
@override final  String nameEn;
@override final  String? nameBn;
@override final  String? addressEn;
@override final  String? addressBn;
@override final  String? countryOfOriginEn;
@override final  String? countryOfOriginBn;
@override final  String? email;
@override final  String? website;
@override final  String? mobile;
@override final  String? logoUrl;

/// Create a copy of Manufacturer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ManufacturerCopyWith<_Manufacturer> get copyWith => __$ManufacturerCopyWithImpl<_Manufacturer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Manufacturer&&(identical(other.id, id) || other.id == id)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn)&&(identical(other.addressEn, addressEn) || other.addressEn == addressEn)&&(identical(other.addressBn, addressBn) || other.addressBn == addressBn)&&(identical(other.countryOfOriginEn, countryOfOriginEn) || other.countryOfOriginEn == countryOfOriginEn)&&(identical(other.countryOfOriginBn, countryOfOriginBn) || other.countryOfOriginBn == countryOfOriginBn)&&(identical(other.email, email) || other.email == email)&&(identical(other.website, website) || other.website == website)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,nameEn,nameBn,addressEn,addressBn,countryOfOriginEn,countryOfOriginBn,email,website,mobile,logoUrl);

@override
String toString() {
  return 'Manufacturer(id: $id, nameEn: $nameEn, nameBn: $nameBn, addressEn: $addressEn, addressBn: $addressBn, countryOfOriginEn: $countryOfOriginEn, countryOfOriginBn: $countryOfOriginBn, email: $email, website: $website, mobile: $mobile, logoUrl: $logoUrl)';
}


}

/// @nodoc
abstract mixin class _$ManufacturerCopyWith<$Res> implements $ManufacturerCopyWith<$Res> {
  factory _$ManufacturerCopyWith(_Manufacturer value, $Res Function(_Manufacturer) _then) = __$ManufacturerCopyWithImpl;
@override @useResult
$Res call({
 int id, String nameEn, String? nameBn, String? addressEn, String? addressBn, String? countryOfOriginEn, String? countryOfOriginBn, String? email, String? website, String? mobile, String? logoUrl
});




}
/// @nodoc
class __$ManufacturerCopyWithImpl<$Res>
    implements _$ManufacturerCopyWith<$Res> {
  __$ManufacturerCopyWithImpl(this._self, this._then);

  final _Manufacturer _self;
  final $Res Function(_Manufacturer) _then;

/// Create a copy of Manufacturer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nameEn = null,Object? nameBn = freezed,Object? addressEn = freezed,Object? addressBn = freezed,Object? countryOfOriginEn = freezed,Object? countryOfOriginBn = freezed,Object? email = freezed,Object? website = freezed,Object? mobile = freezed,Object? logoUrl = freezed,}) {
  return _then(_Manufacturer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameBn: freezed == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String?,addressEn: freezed == addressEn ? _self.addressEn : addressEn // ignore: cast_nullable_to_non_nullable
as String?,addressBn: freezed == addressBn ? _self.addressBn : addressBn // ignore: cast_nullable_to_non_nullable
as String?,countryOfOriginEn: freezed == countryOfOriginEn ? _self.countryOfOriginEn : countryOfOriginEn // ignore: cast_nullable_to_non_nullable
as String?,countryOfOriginBn: freezed == countryOfOriginBn ? _self.countryOfOriginBn : countryOfOriginBn // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,mobile: freezed == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _ManufacturerEmpty extends Manufacturer {
  const _ManufacturerEmpty({this.id = 0, this.nameEn = "", this.nameBn, this.addressEn, this.addressBn, this.countryOfOriginEn, this.countryOfOriginBn, this.email, this.website, this.mobile, this.logoUrl}): super._();
  

@override@JsonKey() final  int id;
@override@JsonKey() final  String nameEn;
@override final  String? nameBn;
@override final  String? addressEn;
@override final  String? addressBn;
@override final  String? countryOfOriginEn;
@override final  String? countryOfOriginBn;
@override final  String? email;
@override final  String? website;
@override final  String? mobile;
@override final  String? logoUrl;

/// Create a copy of Manufacturer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ManufacturerEmptyCopyWith<_ManufacturerEmpty> get copyWith => __$ManufacturerEmptyCopyWithImpl<_ManufacturerEmpty>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ManufacturerEmpty&&(identical(other.id, id) || other.id == id)&&(identical(other.nameEn, nameEn) || other.nameEn == nameEn)&&(identical(other.nameBn, nameBn) || other.nameBn == nameBn)&&(identical(other.addressEn, addressEn) || other.addressEn == addressEn)&&(identical(other.addressBn, addressBn) || other.addressBn == addressBn)&&(identical(other.countryOfOriginEn, countryOfOriginEn) || other.countryOfOriginEn == countryOfOriginEn)&&(identical(other.countryOfOriginBn, countryOfOriginBn) || other.countryOfOriginBn == countryOfOriginBn)&&(identical(other.email, email) || other.email == email)&&(identical(other.website, website) || other.website == website)&&(identical(other.mobile, mobile) || other.mobile == mobile)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl));
}


@override
int get hashCode => Object.hash(runtimeType,id,nameEn,nameBn,addressEn,addressBn,countryOfOriginEn,countryOfOriginBn,email,website,mobile,logoUrl);

@override
String toString() {
  return 'Manufacturer.empty(id: $id, nameEn: $nameEn, nameBn: $nameBn, addressEn: $addressEn, addressBn: $addressBn, countryOfOriginEn: $countryOfOriginEn, countryOfOriginBn: $countryOfOriginBn, email: $email, website: $website, mobile: $mobile, logoUrl: $logoUrl)';
}


}

/// @nodoc
abstract mixin class _$ManufacturerEmptyCopyWith<$Res> implements $ManufacturerCopyWith<$Res> {
  factory _$ManufacturerEmptyCopyWith(_ManufacturerEmpty value, $Res Function(_ManufacturerEmpty) _then) = __$ManufacturerEmptyCopyWithImpl;
@override @useResult
$Res call({
 int id, String nameEn, String? nameBn, String? addressEn, String? addressBn, String? countryOfOriginEn, String? countryOfOriginBn, String? email, String? website, String? mobile, String? logoUrl
});




}
/// @nodoc
class __$ManufacturerEmptyCopyWithImpl<$Res>
    implements _$ManufacturerEmptyCopyWith<$Res> {
  __$ManufacturerEmptyCopyWithImpl(this._self, this._then);

  final _ManufacturerEmpty _self;
  final $Res Function(_ManufacturerEmpty) _then;

/// Create a copy of Manufacturer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? nameEn = null,Object? nameBn = freezed,Object? addressEn = freezed,Object? addressBn = freezed,Object? countryOfOriginEn = freezed,Object? countryOfOriginBn = freezed,Object? email = freezed,Object? website = freezed,Object? mobile = freezed,Object? logoUrl = freezed,}) {
  return _then(_ManufacturerEmpty(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nameEn: null == nameEn ? _self.nameEn : nameEn // ignore: cast_nullable_to_non_nullable
as String,nameBn: freezed == nameBn ? _self.nameBn : nameBn // ignore: cast_nullable_to_non_nullable
as String?,addressEn: freezed == addressEn ? _self.addressEn : addressEn // ignore: cast_nullable_to_non_nullable
as String?,addressBn: freezed == addressBn ? _self.addressBn : addressBn // ignore: cast_nullable_to_non_nullable
as String?,countryOfOriginEn: freezed == countryOfOriginEn ? _self.countryOfOriginEn : countryOfOriginEn // ignore: cast_nullable_to_non_nullable
as String?,countryOfOriginBn: freezed == countryOfOriginBn ? _self.countryOfOriginBn : countryOfOriginBn // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,mobile: freezed == mobile ? _self.mobile : mobile // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
