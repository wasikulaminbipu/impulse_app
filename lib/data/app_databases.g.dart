// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_databases.dart';

// ignore_for_file: type=lint
class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, CategoryEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameBnMeta = const VerificationMeta('nameBn');
  @override
  late final GeneratedColumn<String> nameBn = GeneratedColumn<String>(
    'name_bn',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconNameMeta = const VerificationMeta(
    'iconName',
  );
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
    'icon_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nameEn, nameBn, iconName, slug];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_bn')) {
      context.handle(
        _nameBnMeta,
        nameBn.isAcceptableOrUnknown(data['name_bn']!, _nameBnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameBnMeta);
    }
    if (data.containsKey('icon_name')) {
      context.handle(
        _iconNameMeta,
        iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta),
      );
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_bn'],
      )!,
      iconName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_name'],
      ),
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      ),
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class CategoryEntity extends DataClass implements Insertable<CategoryEntity> {
  final int id;
  final String nameEn;
  final String nameBn;
  final String? iconName;
  final String? slug;
  const CategoryEntity({
    required this.id,
    required this.nameEn,
    required this.nameBn,
    this.iconName,
    this.slug,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name_en'] = Variable<String>(nameEn);
    map['name_bn'] = Variable<String>(nameBn);
    if (!nullToAbsent || iconName != null) {
      map['icon_name'] = Variable<String>(iconName);
    }
    if (!nullToAbsent || slug != null) {
      map['slug'] = Variable<String>(slug);
    }
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      nameEn: Value(nameEn),
      nameBn: Value(nameBn),
      iconName: iconName == null && nullToAbsent
          ? const Value.absent()
          : Value(iconName),
      slug: slug == null && nullToAbsent ? const Value.absent() : Value(slug),
    );
  }

  factory CategoryEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryEntity(
      id: serializer.fromJson<int>(json['id']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameBn: serializer.fromJson<String>(json['nameBn']),
      iconName: serializer.fromJson<String?>(json['iconName']),
      slug: serializer.fromJson<String?>(json['slug']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameBn': serializer.toJson<String>(nameBn),
      'iconName': serializer.toJson<String?>(iconName),
      'slug': serializer.toJson<String?>(slug),
    };
  }

  CategoryEntity copyWith({
    int? id,
    String? nameEn,
    String? nameBn,
    Value<String?> iconName = const Value.absent(),
    Value<String?> slug = const Value.absent(),
  }) => CategoryEntity(
    id: id ?? this.id,
    nameEn: nameEn ?? this.nameEn,
    nameBn: nameBn ?? this.nameBn,
    iconName: iconName.present ? iconName.value : this.iconName,
    slug: slug.present ? slug.value : this.slug,
  );
  CategoryEntity copyWithCompanion(CategoriesCompanion data) {
    return CategoryEntity(
      id: data.id.present ? data.id.value : this.id,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameBn: data.nameBn.present ? data.nameBn.value : this.nameBn,
      iconName: data.iconName.present ? data.iconName.value : this.iconName,
      slug: data.slug.present ? data.slug.value : this.slug,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryEntity(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn, ')
          ..write('iconName: $iconName, ')
          ..write('slug: $slug')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameEn, nameBn, iconName, slug);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryEntity &&
          other.id == this.id &&
          other.nameEn == this.nameEn &&
          other.nameBn == this.nameBn &&
          other.iconName == this.iconName &&
          other.slug == this.slug);
}

class CategoriesCompanion extends UpdateCompanion<CategoryEntity> {
  final Value<int> id;
  final Value<String> nameEn;
  final Value<String> nameBn;
  final Value<String?> iconName;
  final Value<String?> slug;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameBn = const Value.absent(),
    this.iconName = const Value.absent(),
    this.slug = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String nameEn,
    required String nameBn,
    this.iconName = const Value.absent(),
    this.slug = const Value.absent(),
  }) : nameEn = Value(nameEn),
       nameBn = Value(nameBn);
  static Insertable<CategoryEntity> custom({
    Expression<int>? id,
    Expression<String>? nameEn,
    Expression<String>? nameBn,
    Expression<String>? iconName,
    Expression<String>? slug,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameEn != null) 'name_en': nameEn,
      if (nameBn != null) 'name_bn': nameBn,
      if (iconName != null) 'icon_name': iconName,
      if (slug != null) 'slug': slug,
    });
  }

  CategoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? nameEn,
    Value<String>? nameBn,
    Value<String?>? iconName,
    Value<String?>? slug,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameBn: nameBn ?? this.nameBn,
      iconName: iconName ?? this.iconName,
      slug: slug ?? this.slug,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameBn.present) {
      map['name_bn'] = Variable<String>(nameBn.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn, ')
          ..write('iconName: $iconName, ')
          ..write('slug: $slug')
          ..write(')'))
        .toString();
  }
}

class $TargetGroupsTable extends TargetGroups
    with TableInfo<$TargetGroupsTable, TargetGroupEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TargetGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameBnMeta = const VerificationMeta('nameBn');
  @override
  late final GeneratedColumn<String> nameBn = GeneratedColumn<String>(
    'name_bn',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconNameMeta = const VerificationMeta(
    'iconName',
  );
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
    'icon_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nameEn, nameBn, iconName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'target_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<TargetGroupEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_bn')) {
      context.handle(
        _nameBnMeta,
        nameBn.isAcceptableOrUnknown(data['name_bn']!, _nameBnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameBnMeta);
    }
    if (data.containsKey('icon_name')) {
      context.handle(
        _iconNameMeta,
        iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TargetGroupEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TargetGroupEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_bn'],
      )!,
      iconName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_name'],
      ),
    );
  }

  @override
  $TargetGroupsTable createAlias(String alias) {
    return $TargetGroupsTable(attachedDatabase, alias);
  }
}

class TargetGroupEntity extends DataClass
    implements Insertable<TargetGroupEntity> {
  final int id;
  final String nameEn;
  final String nameBn;
  final String? iconName;
  const TargetGroupEntity({
    required this.id,
    required this.nameEn,
    required this.nameBn,
    this.iconName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name_en'] = Variable<String>(nameEn);
    map['name_bn'] = Variable<String>(nameBn);
    if (!nullToAbsent || iconName != null) {
      map['icon_name'] = Variable<String>(iconName);
    }
    return map;
  }

  TargetGroupsCompanion toCompanion(bool nullToAbsent) {
    return TargetGroupsCompanion(
      id: Value(id),
      nameEn: Value(nameEn),
      nameBn: Value(nameBn),
      iconName: iconName == null && nullToAbsent
          ? const Value.absent()
          : Value(iconName),
    );
  }

  factory TargetGroupEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TargetGroupEntity(
      id: serializer.fromJson<int>(json['id']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameBn: serializer.fromJson<String>(json['nameBn']),
      iconName: serializer.fromJson<String?>(json['iconName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameBn': serializer.toJson<String>(nameBn),
      'iconName': serializer.toJson<String?>(iconName),
    };
  }

  TargetGroupEntity copyWith({
    int? id,
    String? nameEn,
    String? nameBn,
    Value<String?> iconName = const Value.absent(),
  }) => TargetGroupEntity(
    id: id ?? this.id,
    nameEn: nameEn ?? this.nameEn,
    nameBn: nameBn ?? this.nameBn,
    iconName: iconName.present ? iconName.value : this.iconName,
  );
  TargetGroupEntity copyWithCompanion(TargetGroupsCompanion data) {
    return TargetGroupEntity(
      id: data.id.present ? data.id.value : this.id,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameBn: data.nameBn.present ? data.nameBn.value : this.nameBn,
      iconName: data.iconName.present ? data.iconName.value : this.iconName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TargetGroupEntity(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn, ')
          ..write('iconName: $iconName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameEn, nameBn, iconName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TargetGroupEntity &&
          other.id == this.id &&
          other.nameEn == this.nameEn &&
          other.nameBn == this.nameBn &&
          other.iconName == this.iconName);
}

class TargetGroupsCompanion extends UpdateCompanion<TargetGroupEntity> {
  final Value<int> id;
  final Value<String> nameEn;
  final Value<String> nameBn;
  final Value<String?> iconName;
  const TargetGroupsCompanion({
    this.id = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameBn = const Value.absent(),
    this.iconName = const Value.absent(),
  });
  TargetGroupsCompanion.insert({
    this.id = const Value.absent(),
    required String nameEn,
    required String nameBn,
    this.iconName = const Value.absent(),
  }) : nameEn = Value(nameEn),
       nameBn = Value(nameBn);
  static Insertable<TargetGroupEntity> custom({
    Expression<int>? id,
    Expression<String>? nameEn,
    Expression<String>? nameBn,
    Expression<String>? iconName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameEn != null) 'name_en': nameEn,
      if (nameBn != null) 'name_bn': nameBn,
      if (iconName != null) 'icon_name': iconName,
    });
  }

  TargetGroupsCompanion copyWith({
    Value<int>? id,
    Value<String>? nameEn,
    Value<String>? nameBn,
    Value<String?>? iconName,
  }) {
    return TargetGroupsCompanion(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameBn: nameBn ?? this.nameBn,
      iconName: iconName ?? this.iconName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameBn.present) {
      map['name_bn'] = Variable<String>(nameBn.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TargetGroupsCompanion(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn, ')
          ..write('iconName: $iconName')
          ..write(')'))
        .toString();
  }
}

class $ContentTypesTable extends ContentTypes
    with TableInfo<$ContentTypesTable, ContentTypeEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContentTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameBnMeta = const VerificationMeta('nameBn');
  @override
  late final GeneratedColumn<String> nameBn = GeneratedColumn<String>(
    'name_bn',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nameEn, nameBn];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'content_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContentTypeEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_bn')) {
      context.handle(
        _nameBnMeta,
        nameBn.isAcceptableOrUnknown(data['name_bn']!, _nameBnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameBnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContentTypeEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContentTypeEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_bn'],
      )!,
    );
  }

  @override
  $ContentTypesTable createAlias(String alias) {
    return $ContentTypesTable(attachedDatabase, alias);
  }
}

class ContentTypeEntity extends DataClass
    implements Insertable<ContentTypeEntity> {
  final int id;
  final String nameEn;
  final String nameBn;
  const ContentTypeEntity({
    required this.id,
    required this.nameEn,
    required this.nameBn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name_en'] = Variable<String>(nameEn);
    map['name_bn'] = Variable<String>(nameBn);
    return map;
  }

  ContentTypesCompanion toCompanion(bool nullToAbsent) {
    return ContentTypesCompanion(
      id: Value(id),
      nameEn: Value(nameEn),
      nameBn: Value(nameBn),
    );
  }

  factory ContentTypeEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContentTypeEntity(
      id: serializer.fromJson<int>(json['id']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameBn: serializer.fromJson<String>(json['nameBn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameBn': serializer.toJson<String>(nameBn),
    };
  }

  ContentTypeEntity copyWith({int? id, String? nameEn, String? nameBn}) =>
      ContentTypeEntity(
        id: id ?? this.id,
        nameEn: nameEn ?? this.nameEn,
        nameBn: nameBn ?? this.nameBn,
      );
  ContentTypeEntity copyWithCompanion(ContentTypesCompanion data) {
    return ContentTypeEntity(
      id: data.id.present ? data.id.value : this.id,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameBn: data.nameBn.present ? data.nameBn.value : this.nameBn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContentTypeEntity(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameEn, nameBn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContentTypeEntity &&
          other.id == this.id &&
          other.nameEn == this.nameEn &&
          other.nameBn == this.nameBn);
}

class ContentTypesCompanion extends UpdateCompanion<ContentTypeEntity> {
  final Value<int> id;
  final Value<String> nameEn;
  final Value<String> nameBn;
  const ContentTypesCompanion({
    this.id = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameBn = const Value.absent(),
  });
  ContentTypesCompanion.insert({
    this.id = const Value.absent(),
    required String nameEn,
    required String nameBn,
  }) : nameEn = Value(nameEn),
       nameBn = Value(nameBn);
  static Insertable<ContentTypeEntity> custom({
    Expression<int>? id,
    Expression<String>? nameEn,
    Expression<String>? nameBn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameEn != null) 'name_en': nameEn,
      if (nameBn != null) 'name_bn': nameBn,
    });
  }

  ContentTypesCompanion copyWith({
    Value<int>? id,
    Value<String>? nameEn,
    Value<String>? nameBn,
  }) {
    return ContentTypesCompanion(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameBn: nameBn ?? this.nameBn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameBn.present) {
      map['name_bn'] = Variable<String>(nameBn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContentTypesCompanion(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn')
          ..write(')'))
        .toString();
  }
}

class $ProductTypesTable extends ProductTypes
    with TableInfo<$ProductTypesTable, ProductTypeEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameBnMeta = const VerificationMeta('nameBn');
  @override
  late final GeneratedColumn<String> nameBn = GeneratedColumn<String>(
    'name_bn',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconNameMeta = const VerificationMeta(
    'iconName',
  );
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
    'icon_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nameEn, nameBn, iconName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductTypeEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_bn')) {
      context.handle(
        _nameBnMeta,
        nameBn.isAcceptableOrUnknown(data['name_bn']!, _nameBnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameBnMeta);
    }
    if (data.containsKey('icon_name')) {
      context.handle(
        _iconNameMeta,
        iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductTypeEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductTypeEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_bn'],
      )!,
      iconName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_name'],
      ),
    );
  }

  @override
  $ProductTypesTable createAlias(String alias) {
    return $ProductTypesTable(attachedDatabase, alias);
  }
}

class ProductTypeEntity extends DataClass
    implements Insertable<ProductTypeEntity> {
  final int id;
  final String nameEn;
  final String nameBn;
  final String? iconName;
  const ProductTypeEntity({
    required this.id,
    required this.nameEn,
    required this.nameBn,
    this.iconName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name_en'] = Variable<String>(nameEn);
    map['name_bn'] = Variable<String>(nameBn);
    if (!nullToAbsent || iconName != null) {
      map['icon_name'] = Variable<String>(iconName);
    }
    return map;
  }

  ProductTypesCompanion toCompanion(bool nullToAbsent) {
    return ProductTypesCompanion(
      id: Value(id),
      nameEn: Value(nameEn),
      nameBn: Value(nameBn),
      iconName: iconName == null && nullToAbsent
          ? const Value.absent()
          : Value(iconName),
    );
  }

  factory ProductTypeEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductTypeEntity(
      id: serializer.fromJson<int>(json['id']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameBn: serializer.fromJson<String>(json['nameBn']),
      iconName: serializer.fromJson<String?>(json['iconName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameBn': serializer.toJson<String>(nameBn),
      'iconName': serializer.toJson<String?>(iconName),
    };
  }

  ProductTypeEntity copyWith({
    int? id,
    String? nameEn,
    String? nameBn,
    Value<String?> iconName = const Value.absent(),
  }) => ProductTypeEntity(
    id: id ?? this.id,
    nameEn: nameEn ?? this.nameEn,
    nameBn: nameBn ?? this.nameBn,
    iconName: iconName.present ? iconName.value : this.iconName,
  );
  ProductTypeEntity copyWithCompanion(ProductTypesCompanion data) {
    return ProductTypeEntity(
      id: data.id.present ? data.id.value : this.id,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameBn: data.nameBn.present ? data.nameBn.value : this.nameBn,
      iconName: data.iconName.present ? data.iconName.value : this.iconName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductTypeEntity(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn, ')
          ..write('iconName: $iconName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameEn, nameBn, iconName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductTypeEntity &&
          other.id == this.id &&
          other.nameEn == this.nameEn &&
          other.nameBn == this.nameBn &&
          other.iconName == this.iconName);
}

class ProductTypesCompanion extends UpdateCompanion<ProductTypeEntity> {
  final Value<int> id;
  final Value<String> nameEn;
  final Value<String> nameBn;
  final Value<String?> iconName;
  const ProductTypesCompanion({
    this.id = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameBn = const Value.absent(),
    this.iconName = const Value.absent(),
  });
  ProductTypesCompanion.insert({
    this.id = const Value.absent(),
    required String nameEn,
    required String nameBn,
    this.iconName = const Value.absent(),
  }) : nameEn = Value(nameEn),
       nameBn = Value(nameBn);
  static Insertable<ProductTypeEntity> custom({
    Expression<int>? id,
    Expression<String>? nameEn,
    Expression<String>? nameBn,
    Expression<String>? iconName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameEn != null) 'name_en': nameEn,
      if (nameBn != null) 'name_bn': nameBn,
      if (iconName != null) 'icon_name': iconName,
    });
  }

  ProductTypesCompanion copyWith({
    Value<int>? id,
    Value<String>? nameEn,
    Value<String>? nameBn,
    Value<String?>? iconName,
  }) {
    return ProductTypesCompanion(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameBn: nameBn ?? this.nameBn,
      iconName: iconName ?? this.iconName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameBn.present) {
      map['name_bn'] = Variable<String>(nameBn.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductTypesCompanion(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn, ')
          ..write('iconName: $iconName')
          ..write(')'))
        .toString();
  }
}

class $SpeciesTable extends Species
    with TableInfo<$SpeciesTable, SpeciesEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpeciesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _targetGroupIdMeta = const VerificationMeta(
    'targetGroupId',
  );
  @override
  late final GeneratedColumn<int> targetGroupId = GeneratedColumn<int>(
    'target_group_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES target_groups(id)',
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameBnMeta = const VerificationMeta('nameBn');
  @override
  late final GeneratedColumn<String> nameBn = GeneratedColumn<String>(
    'name_bn',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, targetGroupId, nameEn, nameBn];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'species';
  @override
  VerificationContext validateIntegrity(
    Insertable<SpeciesEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('target_group_id')) {
      context.handle(
        _targetGroupIdMeta,
        targetGroupId.isAcceptableOrUnknown(
          data['target_group_id']!,
          _targetGroupIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetGroupIdMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_bn')) {
      context.handle(
        _nameBnMeta,
        nameBn.isAcceptableOrUnknown(data['name_bn']!, _nameBnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameBnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SpeciesEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SpeciesEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      targetGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_group_id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_bn'],
      )!,
    );
  }

  @override
  $SpeciesTable createAlias(String alias) {
    return $SpeciesTable(attachedDatabase, alias);
  }
}

class SpeciesEntity extends DataClass implements Insertable<SpeciesEntity> {
  final int id;
  final int targetGroupId;
  final String nameEn;
  final String nameBn;
  const SpeciesEntity({
    required this.id,
    required this.targetGroupId,
    required this.nameEn,
    required this.nameBn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['target_group_id'] = Variable<int>(targetGroupId);
    map['name_en'] = Variable<String>(nameEn);
    map['name_bn'] = Variable<String>(nameBn);
    return map;
  }

  SpeciesCompanion toCompanion(bool nullToAbsent) {
    return SpeciesCompanion(
      id: Value(id),
      targetGroupId: Value(targetGroupId),
      nameEn: Value(nameEn),
      nameBn: Value(nameBn),
    );
  }

  factory SpeciesEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpeciesEntity(
      id: serializer.fromJson<int>(json['id']),
      targetGroupId: serializer.fromJson<int>(json['targetGroupId']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameBn: serializer.fromJson<String>(json['nameBn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'targetGroupId': serializer.toJson<int>(targetGroupId),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameBn': serializer.toJson<String>(nameBn),
    };
  }

  SpeciesEntity copyWith({
    int? id,
    int? targetGroupId,
    String? nameEn,
    String? nameBn,
  }) => SpeciesEntity(
    id: id ?? this.id,
    targetGroupId: targetGroupId ?? this.targetGroupId,
    nameEn: nameEn ?? this.nameEn,
    nameBn: nameBn ?? this.nameBn,
  );
  SpeciesEntity copyWithCompanion(SpeciesCompanion data) {
    return SpeciesEntity(
      id: data.id.present ? data.id.value : this.id,
      targetGroupId: data.targetGroupId.present
          ? data.targetGroupId.value
          : this.targetGroupId,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameBn: data.nameBn.present ? data.nameBn.value : this.nameBn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SpeciesEntity(')
          ..write('id: $id, ')
          ..write('targetGroupId: $targetGroupId, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, targetGroupId, nameEn, nameBn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpeciesEntity &&
          other.id == this.id &&
          other.targetGroupId == this.targetGroupId &&
          other.nameEn == this.nameEn &&
          other.nameBn == this.nameBn);
}

class SpeciesCompanion extends UpdateCompanion<SpeciesEntity> {
  final Value<int> id;
  final Value<int> targetGroupId;
  final Value<String> nameEn;
  final Value<String> nameBn;
  const SpeciesCompanion({
    this.id = const Value.absent(),
    this.targetGroupId = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameBn = const Value.absent(),
  });
  SpeciesCompanion.insert({
    this.id = const Value.absent(),
    required int targetGroupId,
    required String nameEn,
    required String nameBn,
  }) : targetGroupId = Value(targetGroupId),
       nameEn = Value(nameEn),
       nameBn = Value(nameBn);
  static Insertable<SpeciesEntity> custom({
    Expression<int>? id,
    Expression<int>? targetGroupId,
    Expression<String>? nameEn,
    Expression<String>? nameBn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (targetGroupId != null) 'target_group_id': targetGroupId,
      if (nameEn != null) 'name_en': nameEn,
      if (nameBn != null) 'name_bn': nameBn,
    });
  }

  SpeciesCompanion copyWith({
    Value<int>? id,
    Value<int>? targetGroupId,
    Value<String>? nameEn,
    Value<String>? nameBn,
  }) {
    return SpeciesCompanion(
      id: id ?? this.id,
      targetGroupId: targetGroupId ?? this.targetGroupId,
      nameEn: nameEn ?? this.nameEn,
      nameBn: nameBn ?? this.nameBn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (targetGroupId.present) {
      map['target_group_id'] = Variable<int>(targetGroupId.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameBn.present) {
      map['name_bn'] = Variable<String>(nameBn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpeciesCompanion(')
          ..write('id: $id, ')
          ..write('targetGroupId: $targetGroupId, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn')
          ..write(')'))
        .toString();
  }
}

class $DosageUnitsTable extends DosageUnits
    with TableInfo<$DosageUnitsTable, DosageUnitEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DosageUnitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameBnMeta = const VerificationMeta('nameBn');
  @override
  late final GeneratedColumn<String> nameBn = GeneratedColumn<String>(
    'name_bn',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nameEn, nameBn];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dosage_units';
  @override
  VerificationContext validateIntegrity(
    Insertable<DosageUnitEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_bn')) {
      context.handle(
        _nameBnMeta,
        nameBn.isAcceptableOrUnknown(data['name_bn']!, _nameBnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameBnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DosageUnitEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DosageUnitEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_bn'],
      )!,
    );
  }

  @override
  $DosageUnitsTable createAlias(String alias) {
    return $DosageUnitsTable(attachedDatabase, alias);
  }
}

class DosageUnitEntity extends DataClass
    implements Insertable<DosageUnitEntity> {
  final int id;
  final String nameEn;
  final String nameBn;
  const DosageUnitEntity({
    required this.id,
    required this.nameEn,
    required this.nameBn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name_en'] = Variable<String>(nameEn);
    map['name_bn'] = Variable<String>(nameBn);
    return map;
  }

  DosageUnitsCompanion toCompanion(bool nullToAbsent) {
    return DosageUnitsCompanion(
      id: Value(id),
      nameEn: Value(nameEn),
      nameBn: Value(nameBn),
    );
  }

  factory DosageUnitEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DosageUnitEntity(
      id: serializer.fromJson<int>(json['id']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameBn: serializer.fromJson<String>(json['nameBn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameBn': serializer.toJson<String>(nameBn),
    };
  }

  DosageUnitEntity copyWith({int? id, String? nameEn, String? nameBn}) =>
      DosageUnitEntity(
        id: id ?? this.id,
        nameEn: nameEn ?? this.nameEn,
        nameBn: nameBn ?? this.nameBn,
      );
  DosageUnitEntity copyWithCompanion(DosageUnitsCompanion data) {
    return DosageUnitEntity(
      id: data.id.present ? data.id.value : this.id,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameBn: data.nameBn.present ? data.nameBn.value : this.nameBn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DosageUnitEntity(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameEn, nameBn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DosageUnitEntity &&
          other.id == this.id &&
          other.nameEn == this.nameEn &&
          other.nameBn == this.nameBn);
}

class DosageUnitsCompanion extends UpdateCompanion<DosageUnitEntity> {
  final Value<int> id;
  final Value<String> nameEn;
  final Value<String> nameBn;
  const DosageUnitsCompanion({
    this.id = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameBn = const Value.absent(),
  });
  DosageUnitsCompanion.insert({
    this.id = const Value.absent(),
    required String nameEn,
    required String nameBn,
  }) : nameEn = Value(nameEn),
       nameBn = Value(nameBn);
  static Insertable<DosageUnitEntity> custom({
    Expression<int>? id,
    Expression<String>? nameEn,
    Expression<String>? nameBn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameEn != null) 'name_en': nameEn,
      if (nameBn != null) 'name_bn': nameBn,
    });
  }

  DosageUnitsCompanion copyWith({
    Value<int>? id,
    Value<String>? nameEn,
    Value<String>? nameBn,
  }) {
    return DosageUnitsCompanion(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameBn: nameBn ?? this.nameBn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameBn.present) {
      map['name_bn'] = Variable<String>(nameBn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DosageUnitsCompanion(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn')
          ..write(')'))
        .toString();
  }
}

class $DosageBasesTable extends DosageBases
    with TableInfo<$DosageBasesTable, DosageBaseEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DosageBasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameBnMeta = const VerificationMeta('nameBn');
  @override
  late final GeneratedColumn<String> nameBn = GeneratedColumn<String>(
    'name_bn',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nameEn, nameBn];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dosage_bases';
  @override
  VerificationContext validateIntegrity(
    Insertable<DosageBaseEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_bn')) {
      context.handle(
        _nameBnMeta,
        nameBn.isAcceptableOrUnknown(data['name_bn']!, _nameBnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameBnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DosageBaseEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DosageBaseEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_bn'],
      )!,
    );
  }

  @override
  $DosageBasesTable createAlias(String alias) {
    return $DosageBasesTable(attachedDatabase, alias);
  }
}

class DosageBaseEntity extends DataClass
    implements Insertable<DosageBaseEntity> {
  final int id;
  final String nameEn;
  final String nameBn;
  const DosageBaseEntity({
    required this.id,
    required this.nameEn,
    required this.nameBn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name_en'] = Variable<String>(nameEn);
    map['name_bn'] = Variable<String>(nameBn);
    return map;
  }

  DosageBasesCompanion toCompanion(bool nullToAbsent) {
    return DosageBasesCompanion(
      id: Value(id),
      nameEn: Value(nameEn),
      nameBn: Value(nameBn),
    );
  }

  factory DosageBaseEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DosageBaseEntity(
      id: serializer.fromJson<int>(json['id']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameBn: serializer.fromJson<String>(json['nameBn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameBn': serializer.toJson<String>(nameBn),
    };
  }

  DosageBaseEntity copyWith({int? id, String? nameEn, String? nameBn}) =>
      DosageBaseEntity(
        id: id ?? this.id,
        nameEn: nameEn ?? this.nameEn,
        nameBn: nameBn ?? this.nameBn,
      );
  DosageBaseEntity copyWithCompanion(DosageBasesCompanion data) {
    return DosageBaseEntity(
      id: data.id.present ? data.id.value : this.id,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameBn: data.nameBn.present ? data.nameBn.value : this.nameBn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DosageBaseEntity(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameEn, nameBn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DosageBaseEntity &&
          other.id == this.id &&
          other.nameEn == this.nameEn &&
          other.nameBn == this.nameBn);
}

class DosageBasesCompanion extends UpdateCompanion<DosageBaseEntity> {
  final Value<int> id;
  final Value<String> nameEn;
  final Value<String> nameBn;
  const DosageBasesCompanion({
    this.id = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameBn = const Value.absent(),
  });
  DosageBasesCompanion.insert({
    this.id = const Value.absent(),
    required String nameEn,
    required String nameBn,
  }) : nameEn = Value(nameEn),
       nameBn = Value(nameBn);
  static Insertable<DosageBaseEntity> custom({
    Expression<int>? id,
    Expression<String>? nameEn,
    Expression<String>? nameBn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameEn != null) 'name_en': nameEn,
      if (nameBn != null) 'name_bn': nameBn,
    });
  }

  DosageBasesCompanion copyWith({
    Value<int>? id,
    Value<String>? nameEn,
    Value<String>? nameBn,
  }) {
    return DosageBasesCompanion(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameBn: nameBn ?? this.nameBn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameBn.present) {
      map['name_bn'] = Variable<String>(nameBn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DosageBasesCompanion(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn')
          ..write(')'))
        .toString();
  }
}

class $ManufacturersTable extends Manufacturers
    with TableInfo<$ManufacturersTable, ManufacturerEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ManufacturersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameBnMeta = const VerificationMeta('nameBn');
  @override
  late final GeneratedColumn<String> nameBn = GeneratedColumn<String>(
    'name_bn',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _logoUrlMeta = const VerificationMeta(
    'logoUrl',
  );
  @override
  late final GeneratedColumn<String> logoUrl = GeneratedColumn<String>(
    'logo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressEnMeta = const VerificationMeta(
    'addressEn',
  );
  @override
  late final GeneratedColumn<String> addressEn = GeneratedColumn<String>(
    'address_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressBnMeta = const VerificationMeta(
    'addressBn',
  );
  @override
  late final GeneratedColumn<String> addressBn = GeneratedColumn<String>(
    'address_bn',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _websiteMeta = const VerificationMeta(
    'website',
  );
  @override
  late final GeneratedColumn<String> website = GeneratedColumn<String>(
    'website',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mobileMeta = const VerificationMeta('mobile');
  @override
  late final GeneratedColumn<String> mobile = GeneratedColumn<String>(
    'mobile',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countryOfOriginEnMeta = const VerificationMeta(
    'countryOfOriginEn',
  );
  @override
  late final GeneratedColumn<String> countryOfOriginEn =
      GeneratedColumn<String>(
        'country_of_origin_en',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _countryOfOriginBnMeta = const VerificationMeta(
    'countryOfOriginBn',
  );
  @override
  late final GeneratedColumn<String> countryOfOriginBn =
      GeneratedColumn<String>(
        'country_of_origin_bn',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nameEn,
    nameBn,
    logoUrl,
    addressEn,
    addressBn,
    email,
    website,
    mobile,
    countryOfOriginEn,
    countryOfOriginBn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'manufacturers';
  @override
  VerificationContext validateIntegrity(
    Insertable<ManufacturerEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_bn')) {
      context.handle(
        _nameBnMeta,
        nameBn.isAcceptableOrUnknown(data['name_bn']!, _nameBnMeta),
      );
    }
    if (data.containsKey('logo_url')) {
      context.handle(
        _logoUrlMeta,
        logoUrl.isAcceptableOrUnknown(data['logo_url']!, _logoUrlMeta),
      );
    }
    if (data.containsKey('address_en')) {
      context.handle(
        _addressEnMeta,
        addressEn.isAcceptableOrUnknown(data['address_en']!, _addressEnMeta),
      );
    }
    if (data.containsKey('address_bn')) {
      context.handle(
        _addressBnMeta,
        addressBn.isAcceptableOrUnknown(data['address_bn']!, _addressBnMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('website')) {
      context.handle(
        _websiteMeta,
        website.isAcceptableOrUnknown(data['website']!, _websiteMeta),
      );
    }
    if (data.containsKey('mobile')) {
      context.handle(
        _mobileMeta,
        mobile.isAcceptableOrUnknown(data['mobile']!, _mobileMeta),
      );
    }
    if (data.containsKey('country_of_origin_en')) {
      context.handle(
        _countryOfOriginEnMeta,
        countryOfOriginEn.isAcceptableOrUnknown(
          data['country_of_origin_en']!,
          _countryOfOriginEnMeta,
        ),
      );
    }
    if (data.containsKey('country_of_origin_bn')) {
      context.handle(
        _countryOfOriginBnMeta,
        countryOfOriginBn.isAcceptableOrUnknown(
          data['country_of_origin_bn']!,
          _countryOfOriginBnMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ManufacturerEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ManufacturerEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_bn'],
      ),
      logoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_url'],
      ),
      addressEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_en'],
      ),
      addressBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_bn'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      website: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}website'],
      ),
      mobile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mobile'],
      ),
      countryOfOriginEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country_of_origin_en'],
      ),
      countryOfOriginBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country_of_origin_bn'],
      ),
    );
  }

  @override
  $ManufacturersTable createAlias(String alias) {
    return $ManufacturersTable(attachedDatabase, alias);
  }
}

class ManufacturerEntity extends DataClass
    implements Insertable<ManufacturerEntity> {
  final int id;
  final String nameEn;
  final String? nameBn;
  final String? logoUrl;
  final String? addressEn;
  final String? addressBn;
  final String? email;
  final String? website;
  final String? mobile;
  final String? countryOfOriginEn;
  final String? countryOfOriginBn;
  const ManufacturerEntity({
    required this.id,
    required this.nameEn,
    this.nameBn,
    this.logoUrl,
    this.addressEn,
    this.addressBn,
    this.email,
    this.website,
    this.mobile,
    this.countryOfOriginEn,
    this.countryOfOriginBn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name_en'] = Variable<String>(nameEn);
    if (!nullToAbsent || nameBn != null) {
      map['name_bn'] = Variable<String>(nameBn);
    }
    if (!nullToAbsent || logoUrl != null) {
      map['logo_url'] = Variable<String>(logoUrl);
    }
    if (!nullToAbsent || addressEn != null) {
      map['address_en'] = Variable<String>(addressEn);
    }
    if (!nullToAbsent || addressBn != null) {
      map['address_bn'] = Variable<String>(addressBn);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || website != null) {
      map['website'] = Variable<String>(website);
    }
    if (!nullToAbsent || mobile != null) {
      map['mobile'] = Variable<String>(mobile);
    }
    if (!nullToAbsent || countryOfOriginEn != null) {
      map['country_of_origin_en'] = Variable<String>(countryOfOriginEn);
    }
    if (!nullToAbsent || countryOfOriginBn != null) {
      map['country_of_origin_bn'] = Variable<String>(countryOfOriginBn);
    }
    return map;
  }

  ManufacturersCompanion toCompanion(bool nullToAbsent) {
    return ManufacturersCompanion(
      id: Value(id),
      nameEn: Value(nameEn),
      nameBn: nameBn == null && nullToAbsent
          ? const Value.absent()
          : Value(nameBn),
      logoUrl: logoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(logoUrl),
      addressEn: addressEn == null && nullToAbsent
          ? const Value.absent()
          : Value(addressEn),
      addressBn: addressBn == null && nullToAbsent
          ? const Value.absent()
          : Value(addressBn),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      website: website == null && nullToAbsent
          ? const Value.absent()
          : Value(website),
      mobile: mobile == null && nullToAbsent
          ? const Value.absent()
          : Value(mobile),
      countryOfOriginEn: countryOfOriginEn == null && nullToAbsent
          ? const Value.absent()
          : Value(countryOfOriginEn),
      countryOfOriginBn: countryOfOriginBn == null && nullToAbsent
          ? const Value.absent()
          : Value(countryOfOriginBn),
    );
  }

  factory ManufacturerEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ManufacturerEntity(
      id: serializer.fromJson<int>(json['id']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameBn: serializer.fromJson<String?>(json['nameBn']),
      logoUrl: serializer.fromJson<String?>(json['logoUrl']),
      addressEn: serializer.fromJson<String?>(json['addressEn']),
      addressBn: serializer.fromJson<String?>(json['addressBn']),
      email: serializer.fromJson<String?>(json['email']),
      website: serializer.fromJson<String?>(json['website']),
      mobile: serializer.fromJson<String?>(json['mobile']),
      countryOfOriginEn: serializer.fromJson<String?>(
        json['countryOfOriginEn'],
      ),
      countryOfOriginBn: serializer.fromJson<String?>(
        json['countryOfOriginBn'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameBn': serializer.toJson<String?>(nameBn),
      'logoUrl': serializer.toJson<String?>(logoUrl),
      'addressEn': serializer.toJson<String?>(addressEn),
      'addressBn': serializer.toJson<String?>(addressBn),
      'email': serializer.toJson<String?>(email),
      'website': serializer.toJson<String?>(website),
      'mobile': serializer.toJson<String?>(mobile),
      'countryOfOriginEn': serializer.toJson<String?>(countryOfOriginEn),
      'countryOfOriginBn': serializer.toJson<String?>(countryOfOriginBn),
    };
  }

  ManufacturerEntity copyWith({
    int? id,
    String? nameEn,
    Value<String?> nameBn = const Value.absent(),
    Value<String?> logoUrl = const Value.absent(),
    Value<String?> addressEn = const Value.absent(),
    Value<String?> addressBn = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> website = const Value.absent(),
    Value<String?> mobile = const Value.absent(),
    Value<String?> countryOfOriginEn = const Value.absent(),
    Value<String?> countryOfOriginBn = const Value.absent(),
  }) => ManufacturerEntity(
    id: id ?? this.id,
    nameEn: nameEn ?? this.nameEn,
    nameBn: nameBn.present ? nameBn.value : this.nameBn,
    logoUrl: logoUrl.present ? logoUrl.value : this.logoUrl,
    addressEn: addressEn.present ? addressEn.value : this.addressEn,
    addressBn: addressBn.present ? addressBn.value : this.addressBn,
    email: email.present ? email.value : this.email,
    website: website.present ? website.value : this.website,
    mobile: mobile.present ? mobile.value : this.mobile,
    countryOfOriginEn: countryOfOriginEn.present
        ? countryOfOriginEn.value
        : this.countryOfOriginEn,
    countryOfOriginBn: countryOfOriginBn.present
        ? countryOfOriginBn.value
        : this.countryOfOriginBn,
  );
  ManufacturerEntity copyWithCompanion(ManufacturersCompanion data) {
    return ManufacturerEntity(
      id: data.id.present ? data.id.value : this.id,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameBn: data.nameBn.present ? data.nameBn.value : this.nameBn,
      logoUrl: data.logoUrl.present ? data.logoUrl.value : this.logoUrl,
      addressEn: data.addressEn.present ? data.addressEn.value : this.addressEn,
      addressBn: data.addressBn.present ? data.addressBn.value : this.addressBn,
      email: data.email.present ? data.email.value : this.email,
      website: data.website.present ? data.website.value : this.website,
      mobile: data.mobile.present ? data.mobile.value : this.mobile,
      countryOfOriginEn: data.countryOfOriginEn.present
          ? data.countryOfOriginEn.value
          : this.countryOfOriginEn,
      countryOfOriginBn: data.countryOfOriginBn.present
          ? data.countryOfOriginBn.value
          : this.countryOfOriginBn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ManufacturerEntity(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('addressEn: $addressEn, ')
          ..write('addressBn: $addressBn, ')
          ..write('email: $email, ')
          ..write('website: $website, ')
          ..write('mobile: $mobile, ')
          ..write('countryOfOriginEn: $countryOfOriginEn, ')
          ..write('countryOfOriginBn: $countryOfOriginBn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nameEn,
    nameBn,
    logoUrl,
    addressEn,
    addressBn,
    email,
    website,
    mobile,
    countryOfOriginEn,
    countryOfOriginBn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ManufacturerEntity &&
          other.id == this.id &&
          other.nameEn == this.nameEn &&
          other.nameBn == this.nameBn &&
          other.logoUrl == this.logoUrl &&
          other.addressEn == this.addressEn &&
          other.addressBn == this.addressBn &&
          other.email == this.email &&
          other.website == this.website &&
          other.mobile == this.mobile &&
          other.countryOfOriginEn == this.countryOfOriginEn &&
          other.countryOfOriginBn == this.countryOfOriginBn);
}

class ManufacturersCompanion extends UpdateCompanion<ManufacturerEntity> {
  final Value<int> id;
  final Value<String> nameEn;
  final Value<String?> nameBn;
  final Value<String?> logoUrl;
  final Value<String?> addressEn;
  final Value<String?> addressBn;
  final Value<String?> email;
  final Value<String?> website;
  final Value<String?> mobile;
  final Value<String?> countryOfOriginEn;
  final Value<String?> countryOfOriginBn;
  const ManufacturersCompanion({
    this.id = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameBn = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.addressEn = const Value.absent(),
    this.addressBn = const Value.absent(),
    this.email = const Value.absent(),
    this.website = const Value.absent(),
    this.mobile = const Value.absent(),
    this.countryOfOriginEn = const Value.absent(),
    this.countryOfOriginBn = const Value.absent(),
  });
  ManufacturersCompanion.insert({
    this.id = const Value.absent(),
    required String nameEn,
    this.nameBn = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.addressEn = const Value.absent(),
    this.addressBn = const Value.absent(),
    this.email = const Value.absent(),
    this.website = const Value.absent(),
    this.mobile = const Value.absent(),
    this.countryOfOriginEn = const Value.absent(),
    this.countryOfOriginBn = const Value.absent(),
  }) : nameEn = Value(nameEn);
  static Insertable<ManufacturerEntity> custom({
    Expression<int>? id,
    Expression<String>? nameEn,
    Expression<String>? nameBn,
    Expression<String>? logoUrl,
    Expression<String>? addressEn,
    Expression<String>? addressBn,
    Expression<String>? email,
    Expression<String>? website,
    Expression<String>? mobile,
    Expression<String>? countryOfOriginEn,
    Expression<String>? countryOfOriginBn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameEn != null) 'name_en': nameEn,
      if (nameBn != null) 'name_bn': nameBn,
      if (logoUrl != null) 'logo_url': logoUrl,
      if (addressEn != null) 'address_en': addressEn,
      if (addressBn != null) 'address_bn': addressBn,
      if (email != null) 'email': email,
      if (website != null) 'website': website,
      if (mobile != null) 'mobile': mobile,
      if (countryOfOriginEn != null) 'country_of_origin_en': countryOfOriginEn,
      if (countryOfOriginBn != null) 'country_of_origin_bn': countryOfOriginBn,
    });
  }

  ManufacturersCompanion copyWith({
    Value<int>? id,
    Value<String>? nameEn,
    Value<String?>? nameBn,
    Value<String?>? logoUrl,
    Value<String?>? addressEn,
    Value<String?>? addressBn,
    Value<String?>? email,
    Value<String?>? website,
    Value<String?>? mobile,
    Value<String?>? countryOfOriginEn,
    Value<String?>? countryOfOriginBn,
  }) {
    return ManufacturersCompanion(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameBn: nameBn ?? this.nameBn,
      logoUrl: logoUrl ?? this.logoUrl,
      addressEn: addressEn ?? this.addressEn,
      addressBn: addressBn ?? this.addressBn,
      email: email ?? this.email,
      website: website ?? this.website,
      mobile: mobile ?? this.mobile,
      countryOfOriginEn: countryOfOriginEn ?? this.countryOfOriginEn,
      countryOfOriginBn: countryOfOriginBn ?? this.countryOfOriginBn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameBn.present) {
      map['name_bn'] = Variable<String>(nameBn.value);
    }
    if (logoUrl.present) {
      map['logo_url'] = Variable<String>(logoUrl.value);
    }
    if (addressEn.present) {
      map['address_en'] = Variable<String>(addressEn.value);
    }
    if (addressBn.present) {
      map['address_bn'] = Variable<String>(addressBn.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (website.present) {
      map['website'] = Variable<String>(website.value);
    }
    if (mobile.present) {
      map['mobile'] = Variable<String>(mobile.value);
    }
    if (countryOfOriginEn.present) {
      map['country_of_origin_en'] = Variable<String>(countryOfOriginEn.value);
    }
    if (countryOfOriginBn.present) {
      map['country_of_origin_bn'] = Variable<String>(countryOfOriginBn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ManufacturersCompanion(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('addressEn: $addressEn, ')
          ..write('addressBn: $addressBn, ')
          ..write('email: $email, ')
          ..write('website: $website, ')
          ..write('mobile: $mobile, ')
          ..write('countryOfOriginEn: $countryOfOriginEn, ')
          ..write('countryOfOriginBn: $countryOfOriginBn')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products
    with TableInfo<$ProductsTable, ProductEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _manufacturerIdMeta = const VerificationMeta(
    'manufacturerId',
  );
  @override
  late final GeneratedColumn<int> manufacturerId = GeneratedColumn<int>(
    'manufacturer_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES manufacturers(id)',
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES categories(id)',
  );
  static const VerificationMeta _titleEnMeta = const VerificationMeta(
    'titleEn',
  );
  @override
  late final GeneratedColumn<String> titleEn = GeneratedColumn<String>(
    'title_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleBnMeta = const VerificationMeta(
    'titleBn',
  );
  @override
  late final GeneratedColumn<String> titleBn = GeneratedColumn<String>(
    'title_bn',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _mottoEnMeta = const VerificationMeta(
    'mottoEn',
  );
  @override
  late final GeneratedColumn<String> mottoEn = GeneratedColumn<String>(
    'motto_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mottoBnMeta = const VerificationMeta(
    'mottoBn',
  );
  @override
  late final GeneratedColumn<String> mottoBn = GeneratedColumn<String>(
    'motto_bn',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _shortDescriptionEnMeta =
      const VerificationMeta('shortDescriptionEn');
  @override
  late final GeneratedColumn<String> shortDescriptionEn =
      GeneratedColumn<String>(
        'short_description_en',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _shortDescriptionBnMeta =
      const VerificationMeta('shortDescriptionBn');
  @override
  late final GeneratedColumn<String> shortDescriptionBn =
      GeneratedColumn<String>(
        'short_description_bn',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<int> isActive = GeneratedColumn<int>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toIso8601String(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toIso8601String(),
  );
  static const VerificationMeta _compositionBasisEnMeta =
      const VerificationMeta('compositionBasisEn');
  @override
  late final GeneratedColumn<String> compositionBasisEn =
      GeneratedColumn<String>(
        'composition_basis_en',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _compositionBasisBnMeta =
      const VerificationMeta('compositionBasisBn');
  @override
  late final GeneratedColumn<String> compositionBasisBn =
      GeneratedColumn<String>(
        'composition_basis_bn',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    manufacturerId,
    categoryId,
    titleEn,
    titleBn,
    slug,
    mottoEn,
    mottoBn,
    shortDescriptionEn,
    shortDescriptionBn,
    imageUrl,
    isActive,
    createdAt,
    updatedAt,
    compositionBasisEn,
    compositionBasisBn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('manufacturer_id')) {
      context.handle(
        _manufacturerIdMeta,
        manufacturerId.isAcceptableOrUnknown(
          data['manufacturer_id']!,
          _manufacturerIdMeta,
        ),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('title_en')) {
      context.handle(
        _titleEnMeta,
        titleEn.isAcceptableOrUnknown(data['title_en']!, _titleEnMeta),
      );
    } else if (isInserting) {
      context.missing(_titleEnMeta);
    }
    if (data.containsKey('title_bn')) {
      context.handle(
        _titleBnMeta,
        titleBn.isAcceptableOrUnknown(data['title_bn']!, _titleBnMeta),
      );
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('motto_en')) {
      context.handle(
        _mottoEnMeta,
        mottoEn.isAcceptableOrUnknown(data['motto_en']!, _mottoEnMeta),
      );
    }
    if (data.containsKey('motto_bn')) {
      context.handle(
        _mottoBnMeta,
        mottoBn.isAcceptableOrUnknown(data['motto_bn']!, _mottoBnMeta),
      );
    }
    if (data.containsKey('short_description_en')) {
      context.handle(
        _shortDescriptionEnMeta,
        shortDescriptionEn.isAcceptableOrUnknown(
          data['short_description_en']!,
          _shortDescriptionEnMeta,
        ),
      );
    }
    if (data.containsKey('short_description_bn')) {
      context.handle(
        _shortDescriptionBnMeta,
        shortDescriptionBn.isAcceptableOrUnknown(
          data['short_description_bn']!,
          _shortDescriptionBnMeta,
        ),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('composition_basis_en')) {
      context.handle(
        _compositionBasisEnMeta,
        compositionBasisEn.isAcceptableOrUnknown(
          data['composition_basis_en']!,
          _compositionBasisEnMeta,
        ),
      );
    }
    if (data.containsKey('composition_basis_bn')) {
      context.handle(
        _compositionBasisBnMeta,
        compositionBasisBn.isAcceptableOrUnknown(
          data['composition_basis_bn']!,
          _compositionBasisBnMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      manufacturerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}manufacturer_id'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      )!,
      titleEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_en'],
      )!,
      titleBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_bn'],
      ),
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      mottoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motto_en'],
      ),
      mottoBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motto_bn'],
      ),
      shortDescriptionEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}short_description_en'],
      ),
      shortDescriptionBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}short_description_bn'],
      ),
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      compositionBasisEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}composition_basis_en'],
      ),
      compositionBasisBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}composition_basis_bn'],
      ),
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class ProductEntity extends DataClass implements Insertable<ProductEntity> {
  final int id;
  final int? manufacturerId;
  final int categoryId;
  final String titleEn;
  final String? titleBn;
  final String slug;
  final String? mottoEn;
  final String? mottoBn;
  final String? shortDescriptionEn;
  final String? shortDescriptionBn;
  final String? imageUrl;
  final int isActive;
  final String createdAt;
  final String updatedAt;
  final String? compositionBasisEn;
  final String? compositionBasisBn;
  const ProductEntity({
    required this.id,
    this.manufacturerId,
    required this.categoryId,
    required this.titleEn,
    this.titleBn,
    required this.slug,
    this.mottoEn,
    this.mottoBn,
    this.shortDescriptionEn,
    this.shortDescriptionBn,
    this.imageUrl,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.compositionBasisEn,
    this.compositionBasisBn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || manufacturerId != null) {
      map['manufacturer_id'] = Variable<int>(manufacturerId);
    }
    map['category_id'] = Variable<int>(categoryId);
    map['title_en'] = Variable<String>(titleEn);
    if (!nullToAbsent || titleBn != null) {
      map['title_bn'] = Variable<String>(titleBn);
    }
    map['slug'] = Variable<String>(slug);
    if (!nullToAbsent || mottoEn != null) {
      map['motto_en'] = Variable<String>(mottoEn);
    }
    if (!nullToAbsent || mottoBn != null) {
      map['motto_bn'] = Variable<String>(mottoBn);
    }
    if (!nullToAbsent || shortDescriptionEn != null) {
      map['short_description_en'] = Variable<String>(shortDescriptionEn);
    }
    if (!nullToAbsent || shortDescriptionBn != null) {
      map['short_description_bn'] = Variable<String>(shortDescriptionBn);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['is_active'] = Variable<int>(isActive);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || compositionBasisEn != null) {
      map['composition_basis_en'] = Variable<String>(compositionBasisEn);
    }
    if (!nullToAbsent || compositionBasisBn != null) {
      map['composition_basis_bn'] = Variable<String>(compositionBasisBn);
    }
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      manufacturerId: manufacturerId == null && nullToAbsent
          ? const Value.absent()
          : Value(manufacturerId),
      categoryId: Value(categoryId),
      titleEn: Value(titleEn),
      titleBn: titleBn == null && nullToAbsent
          ? const Value.absent()
          : Value(titleBn),
      slug: Value(slug),
      mottoEn: mottoEn == null && nullToAbsent
          ? const Value.absent()
          : Value(mottoEn),
      mottoBn: mottoBn == null && nullToAbsent
          ? const Value.absent()
          : Value(mottoBn),
      shortDescriptionEn: shortDescriptionEn == null && nullToAbsent
          ? const Value.absent()
          : Value(shortDescriptionEn),
      shortDescriptionBn: shortDescriptionBn == null && nullToAbsent
          ? const Value.absent()
          : Value(shortDescriptionBn),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      compositionBasisEn: compositionBasisEn == null && nullToAbsent
          ? const Value.absent()
          : Value(compositionBasisEn),
      compositionBasisBn: compositionBasisBn == null && nullToAbsent
          ? const Value.absent()
          : Value(compositionBasisBn),
    );
  }

  factory ProductEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductEntity(
      id: serializer.fromJson<int>(json['id']),
      manufacturerId: serializer.fromJson<int?>(json['manufacturerId']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      titleEn: serializer.fromJson<String>(json['titleEn']),
      titleBn: serializer.fromJson<String?>(json['titleBn']),
      slug: serializer.fromJson<String>(json['slug']),
      mottoEn: serializer.fromJson<String?>(json['mottoEn']),
      mottoBn: serializer.fromJson<String?>(json['mottoBn']),
      shortDescriptionEn: serializer.fromJson<String?>(
        json['shortDescriptionEn'],
      ),
      shortDescriptionBn: serializer.fromJson<String?>(
        json['shortDescriptionBn'],
      ),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      isActive: serializer.fromJson<int>(json['isActive']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      compositionBasisEn: serializer.fromJson<String?>(
        json['compositionBasisEn'],
      ),
      compositionBasisBn: serializer.fromJson<String?>(
        json['compositionBasisBn'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'manufacturerId': serializer.toJson<int?>(manufacturerId),
      'categoryId': serializer.toJson<int>(categoryId),
      'titleEn': serializer.toJson<String>(titleEn),
      'titleBn': serializer.toJson<String?>(titleBn),
      'slug': serializer.toJson<String>(slug),
      'mottoEn': serializer.toJson<String?>(mottoEn),
      'mottoBn': serializer.toJson<String?>(mottoBn),
      'shortDescriptionEn': serializer.toJson<String?>(shortDescriptionEn),
      'shortDescriptionBn': serializer.toJson<String?>(shortDescriptionBn),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'isActive': serializer.toJson<int>(isActive),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'compositionBasisEn': serializer.toJson<String?>(compositionBasisEn),
      'compositionBasisBn': serializer.toJson<String?>(compositionBasisBn),
    };
  }

  ProductEntity copyWith({
    int? id,
    Value<int?> manufacturerId = const Value.absent(),
    int? categoryId,
    String? titleEn,
    Value<String?> titleBn = const Value.absent(),
    String? slug,
    Value<String?> mottoEn = const Value.absent(),
    Value<String?> mottoBn = const Value.absent(),
    Value<String?> shortDescriptionEn = const Value.absent(),
    Value<String?> shortDescriptionBn = const Value.absent(),
    Value<String?> imageUrl = const Value.absent(),
    int? isActive,
    String? createdAt,
    String? updatedAt,
    Value<String?> compositionBasisEn = const Value.absent(),
    Value<String?> compositionBasisBn = const Value.absent(),
  }) => ProductEntity(
    id: id ?? this.id,
    manufacturerId: manufacturerId.present
        ? manufacturerId.value
        : this.manufacturerId,
    categoryId: categoryId ?? this.categoryId,
    titleEn: titleEn ?? this.titleEn,
    titleBn: titleBn.present ? titleBn.value : this.titleBn,
    slug: slug ?? this.slug,
    mottoEn: mottoEn.present ? mottoEn.value : this.mottoEn,
    mottoBn: mottoBn.present ? mottoBn.value : this.mottoBn,
    shortDescriptionEn: shortDescriptionEn.present
        ? shortDescriptionEn.value
        : this.shortDescriptionEn,
    shortDescriptionBn: shortDescriptionBn.present
        ? shortDescriptionBn.value
        : this.shortDescriptionBn,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    compositionBasisEn: compositionBasisEn.present
        ? compositionBasisEn.value
        : this.compositionBasisEn,
    compositionBasisBn: compositionBasisBn.present
        ? compositionBasisBn.value
        : this.compositionBasisBn,
  );
  ProductEntity copyWithCompanion(ProductsCompanion data) {
    return ProductEntity(
      id: data.id.present ? data.id.value : this.id,
      manufacturerId: data.manufacturerId.present
          ? data.manufacturerId.value
          : this.manufacturerId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      titleEn: data.titleEn.present ? data.titleEn.value : this.titleEn,
      titleBn: data.titleBn.present ? data.titleBn.value : this.titleBn,
      slug: data.slug.present ? data.slug.value : this.slug,
      mottoEn: data.mottoEn.present ? data.mottoEn.value : this.mottoEn,
      mottoBn: data.mottoBn.present ? data.mottoBn.value : this.mottoBn,
      shortDescriptionEn: data.shortDescriptionEn.present
          ? data.shortDescriptionEn.value
          : this.shortDescriptionEn,
      shortDescriptionBn: data.shortDescriptionBn.present
          ? data.shortDescriptionBn.value
          : this.shortDescriptionBn,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      compositionBasisEn: data.compositionBasisEn.present
          ? data.compositionBasisEn.value
          : this.compositionBasisEn,
      compositionBasisBn: data.compositionBasisBn.present
          ? data.compositionBasisBn.value
          : this.compositionBasisBn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductEntity(')
          ..write('id: $id, ')
          ..write('manufacturerId: $manufacturerId, ')
          ..write('categoryId: $categoryId, ')
          ..write('titleEn: $titleEn, ')
          ..write('titleBn: $titleBn, ')
          ..write('slug: $slug, ')
          ..write('mottoEn: $mottoEn, ')
          ..write('mottoBn: $mottoBn, ')
          ..write('shortDescriptionEn: $shortDescriptionEn, ')
          ..write('shortDescriptionBn: $shortDescriptionBn, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('compositionBasisEn: $compositionBasisEn, ')
          ..write('compositionBasisBn: $compositionBasisBn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    manufacturerId,
    categoryId,
    titleEn,
    titleBn,
    slug,
    mottoEn,
    mottoBn,
    shortDescriptionEn,
    shortDescriptionBn,
    imageUrl,
    isActive,
    createdAt,
    updatedAt,
    compositionBasisEn,
    compositionBasisBn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductEntity &&
          other.id == this.id &&
          other.manufacturerId == this.manufacturerId &&
          other.categoryId == this.categoryId &&
          other.titleEn == this.titleEn &&
          other.titleBn == this.titleBn &&
          other.slug == this.slug &&
          other.mottoEn == this.mottoEn &&
          other.mottoBn == this.mottoBn &&
          other.shortDescriptionEn == this.shortDescriptionEn &&
          other.shortDescriptionBn == this.shortDescriptionBn &&
          other.imageUrl == this.imageUrl &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.compositionBasisEn == this.compositionBasisEn &&
          other.compositionBasisBn == this.compositionBasisBn);
}

class ProductsCompanion extends UpdateCompanion<ProductEntity> {
  final Value<int> id;
  final Value<int?> manufacturerId;
  final Value<int> categoryId;
  final Value<String> titleEn;
  final Value<String?> titleBn;
  final Value<String> slug;
  final Value<String?> mottoEn;
  final Value<String?> mottoBn;
  final Value<String?> shortDescriptionEn;
  final Value<String?> shortDescriptionBn;
  final Value<String?> imageUrl;
  final Value<int> isActive;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> compositionBasisEn;
  final Value<String?> compositionBasisBn;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.manufacturerId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.titleEn = const Value.absent(),
    this.titleBn = const Value.absent(),
    this.slug = const Value.absent(),
    this.mottoEn = const Value.absent(),
    this.mottoBn = const Value.absent(),
    this.shortDescriptionEn = const Value.absent(),
    this.shortDescriptionBn = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.compositionBasisEn = const Value.absent(),
    this.compositionBasisBn = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    this.manufacturerId = const Value.absent(),
    required int categoryId,
    required String titleEn,
    this.titleBn = const Value.absent(),
    required String slug,
    this.mottoEn = const Value.absent(),
    this.mottoBn = const Value.absent(),
    this.shortDescriptionEn = const Value.absent(),
    this.shortDescriptionBn = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.compositionBasisEn = const Value.absent(),
    this.compositionBasisBn = const Value.absent(),
  }) : categoryId = Value(categoryId),
       titleEn = Value(titleEn),
       slug = Value(slug);
  static Insertable<ProductEntity> custom({
    Expression<int>? id,
    Expression<int>? manufacturerId,
    Expression<int>? categoryId,
    Expression<String>? titleEn,
    Expression<String>? titleBn,
    Expression<String>? slug,
    Expression<String>? mottoEn,
    Expression<String>? mottoBn,
    Expression<String>? shortDescriptionEn,
    Expression<String>? shortDescriptionBn,
    Expression<String>? imageUrl,
    Expression<int>? isActive,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? compositionBasisEn,
    Expression<String>? compositionBasisBn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (manufacturerId != null) 'manufacturer_id': manufacturerId,
      if (categoryId != null) 'category_id': categoryId,
      if (titleEn != null) 'title_en': titleEn,
      if (titleBn != null) 'title_bn': titleBn,
      if (slug != null) 'slug': slug,
      if (mottoEn != null) 'motto_en': mottoEn,
      if (mottoBn != null) 'motto_bn': mottoBn,
      if (shortDescriptionEn != null)
        'short_description_en': shortDescriptionEn,
      if (shortDescriptionBn != null)
        'short_description_bn': shortDescriptionBn,
      if (imageUrl != null) 'image_url': imageUrl,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (compositionBasisEn != null)
        'composition_basis_en': compositionBasisEn,
      if (compositionBasisBn != null)
        'composition_basis_bn': compositionBasisBn,
    });
  }

  ProductsCompanion copyWith({
    Value<int>? id,
    Value<int?>? manufacturerId,
    Value<int>? categoryId,
    Value<String>? titleEn,
    Value<String?>? titleBn,
    Value<String>? slug,
    Value<String?>? mottoEn,
    Value<String?>? mottoBn,
    Value<String?>? shortDescriptionEn,
    Value<String?>? shortDescriptionBn,
    Value<String?>? imageUrl,
    Value<int>? isActive,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String?>? compositionBasisEn,
    Value<String?>? compositionBasisBn,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      manufacturerId: manufacturerId ?? this.manufacturerId,
      categoryId: categoryId ?? this.categoryId,
      titleEn: titleEn ?? this.titleEn,
      titleBn: titleBn ?? this.titleBn,
      slug: slug ?? this.slug,
      mottoEn: mottoEn ?? this.mottoEn,
      mottoBn: mottoBn ?? this.mottoBn,
      shortDescriptionEn: shortDescriptionEn ?? this.shortDescriptionEn,
      shortDescriptionBn: shortDescriptionBn ?? this.shortDescriptionBn,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      compositionBasisEn: compositionBasisEn ?? this.compositionBasisEn,
      compositionBasisBn: compositionBasisBn ?? this.compositionBasisBn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (manufacturerId.present) {
      map['manufacturer_id'] = Variable<int>(manufacturerId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (titleEn.present) {
      map['title_en'] = Variable<String>(titleEn.value);
    }
    if (titleBn.present) {
      map['title_bn'] = Variable<String>(titleBn.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (mottoEn.present) {
      map['motto_en'] = Variable<String>(mottoEn.value);
    }
    if (mottoBn.present) {
      map['motto_bn'] = Variable<String>(mottoBn.value);
    }
    if (shortDescriptionEn.present) {
      map['short_description_en'] = Variable<String>(shortDescriptionEn.value);
    }
    if (shortDescriptionBn.present) {
      map['short_description_bn'] = Variable<String>(shortDescriptionBn.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<int>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (compositionBasisEn.present) {
      map['composition_basis_en'] = Variable<String>(compositionBasisEn.value);
    }
    if (compositionBasisBn.present) {
      map['composition_basis_bn'] = Variable<String>(compositionBasisBn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('manufacturerId: $manufacturerId, ')
          ..write('categoryId: $categoryId, ')
          ..write('titleEn: $titleEn, ')
          ..write('titleBn: $titleBn, ')
          ..write('slug: $slug, ')
          ..write('mottoEn: $mottoEn, ')
          ..write('mottoBn: $mottoBn, ')
          ..write('shortDescriptionEn: $shortDescriptionEn, ')
          ..write('shortDescriptionBn: $shortDescriptionBn, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('compositionBasisEn: $compositionBasisEn, ')
          ..write('compositionBasisBn: $compositionBasisBn')
          ..write(')'))
        .toString();
  }
}

class $ProductTargetGroupsTable extends ProductTargetGroups
    with TableInfo<$ProductTargetGroupsTable, ProductTargetGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductTargetGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES products(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _targetGroupIdMeta = const VerificationMeta(
    'targetGroupId',
  );
  @override
  late final GeneratedColumn<int> targetGroupId = GeneratedColumn<int>(
    'target_group_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES target_groups(id)',
  );
  @override
  List<GeneratedColumn> get $columns => [productId, targetGroupId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_target_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductTargetGroup> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('target_group_id')) {
      context.handle(
        _targetGroupIdMeta,
        targetGroupId.isAcceptableOrUnknown(
          data['target_group_id']!,
          _targetGroupIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetGroupIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {productId, targetGroupId};
  @override
  ProductTargetGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductTargetGroup(
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      targetGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_group_id'],
      )!,
    );
  }

  @override
  $ProductTargetGroupsTable createAlias(String alias) {
    return $ProductTargetGroupsTable(attachedDatabase, alias);
  }
}

class ProductTargetGroup extends DataClass
    implements Insertable<ProductTargetGroup> {
  final int productId;
  final int targetGroupId;
  const ProductTargetGroup({
    required this.productId,
    required this.targetGroupId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_id'] = Variable<int>(productId);
    map['target_group_id'] = Variable<int>(targetGroupId);
    return map;
  }

  ProductTargetGroupsCompanion toCompanion(bool nullToAbsent) {
    return ProductTargetGroupsCompanion(
      productId: Value(productId),
      targetGroupId: Value(targetGroupId),
    );
  }

  factory ProductTargetGroup.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductTargetGroup(
      productId: serializer.fromJson<int>(json['productId']),
      targetGroupId: serializer.fromJson<int>(json['targetGroupId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productId': serializer.toJson<int>(productId),
      'targetGroupId': serializer.toJson<int>(targetGroupId),
    };
  }

  ProductTargetGroup copyWith({int? productId, int? targetGroupId}) =>
      ProductTargetGroup(
        productId: productId ?? this.productId,
        targetGroupId: targetGroupId ?? this.targetGroupId,
      );
  ProductTargetGroup copyWithCompanion(ProductTargetGroupsCompanion data) {
    return ProductTargetGroup(
      productId: data.productId.present ? data.productId.value : this.productId,
      targetGroupId: data.targetGroupId.present
          ? data.targetGroupId.value
          : this.targetGroupId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductTargetGroup(')
          ..write('productId: $productId, ')
          ..write('targetGroupId: $targetGroupId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(productId, targetGroupId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductTargetGroup &&
          other.productId == this.productId &&
          other.targetGroupId == this.targetGroupId);
}

class ProductTargetGroupsCompanion extends UpdateCompanion<ProductTargetGroup> {
  final Value<int> productId;
  final Value<int> targetGroupId;
  final Value<int> rowid;
  const ProductTargetGroupsCompanion({
    this.productId = const Value.absent(),
    this.targetGroupId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductTargetGroupsCompanion.insert({
    required int productId,
    required int targetGroupId,
    this.rowid = const Value.absent(),
  }) : productId = Value(productId),
       targetGroupId = Value(targetGroupId);
  static Insertable<ProductTargetGroup> custom({
    Expression<int>? productId,
    Expression<int>? targetGroupId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (targetGroupId != null) 'target_group_id': targetGroupId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductTargetGroupsCompanion copyWith({
    Value<int>? productId,
    Value<int>? targetGroupId,
    Value<int>? rowid,
  }) {
    return ProductTargetGroupsCompanion(
      productId: productId ?? this.productId,
      targetGroupId: targetGroupId ?? this.targetGroupId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (targetGroupId.present) {
      map['target_group_id'] = Variable<int>(targetGroupId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductTargetGroupsCompanion(')
          ..write('productId: $productId, ')
          ..write('targetGroupId: $targetGroupId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CompositionsTable extends Compositions
    with TableInfo<$CompositionsTable, CompositionEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompositionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES products(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _ingredientEnMeta = const VerificationMeta(
    'ingredientEn',
  );
  @override
  late final GeneratedColumn<String> ingredientEn = GeneratedColumn<String>(
    'ingredient_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ingredientBnMeta = const VerificationMeta(
    'ingredientBn',
  );
  @override
  late final GeneratedColumn<String> ingredientBn = GeneratedColumn<String>(
    'ingredient_bn',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _concentrationMeta = const VerificationMeta(
    'concentration',
  );
  @override
  late final GeneratedColumn<String> concentration = GeneratedColumn<String>(
    'concentration',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _displayOrderMeta = const VerificationMeta(
    'displayOrder',
  );
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
    'display_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    ingredientEn,
    ingredientBn,
    concentration,
    displayOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'compositions';
  @override
  VerificationContext validateIntegrity(
    Insertable<CompositionEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('ingredient_en')) {
      context.handle(
        _ingredientEnMeta,
        ingredientEn.isAcceptableOrUnknown(
          data['ingredient_en']!,
          _ingredientEnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientEnMeta);
    }
    if (data.containsKey('ingredient_bn')) {
      context.handle(
        _ingredientBnMeta,
        ingredientBn.isAcceptableOrUnknown(
          data['ingredient_bn']!,
          _ingredientBnMeta,
        ),
      );
    }
    if (data.containsKey('concentration')) {
      context.handle(
        _concentrationMeta,
        concentration.isAcceptableOrUnknown(
          data['concentration']!,
          _concentrationMeta,
        ),
      );
    }
    if (data.containsKey('display_order')) {
      context.handle(
        _displayOrderMeta,
        displayOrder.isAcceptableOrUnknown(
          data['display_order']!,
          _displayOrderMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CompositionEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompositionEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      ingredientEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ingredient_en'],
      )!,
      ingredientBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ingredient_bn'],
      ),
      concentration: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}concentration'],
      ),
      displayOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}display_order'],
      )!,
    );
  }

  @override
  $CompositionsTable createAlias(String alias) {
    return $CompositionsTable(attachedDatabase, alias);
  }
}

class CompositionEntity extends DataClass
    implements Insertable<CompositionEntity> {
  final int id;
  final int productId;
  final String ingredientEn;
  final String? ingredientBn;
  final String? concentration;
  final int displayOrder;
  const CompositionEntity({
    required this.id,
    required this.productId,
    required this.ingredientEn,
    this.ingredientBn,
    this.concentration,
    required this.displayOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['ingredient_en'] = Variable<String>(ingredientEn);
    if (!nullToAbsent || ingredientBn != null) {
      map['ingredient_bn'] = Variable<String>(ingredientBn);
    }
    if (!nullToAbsent || concentration != null) {
      map['concentration'] = Variable<String>(concentration);
    }
    map['display_order'] = Variable<int>(displayOrder);
    return map;
  }

  CompositionsCompanion toCompanion(bool nullToAbsent) {
    return CompositionsCompanion(
      id: Value(id),
      productId: Value(productId),
      ingredientEn: Value(ingredientEn),
      ingredientBn: ingredientBn == null && nullToAbsent
          ? const Value.absent()
          : Value(ingredientBn),
      concentration: concentration == null && nullToAbsent
          ? const Value.absent()
          : Value(concentration),
      displayOrder: Value(displayOrder),
    );
  }

  factory CompositionEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompositionEntity(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      ingredientEn: serializer.fromJson<String>(json['ingredientEn']),
      ingredientBn: serializer.fromJson<String?>(json['ingredientBn']),
      concentration: serializer.fromJson<String?>(json['concentration']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'ingredientEn': serializer.toJson<String>(ingredientEn),
      'ingredientBn': serializer.toJson<String?>(ingredientBn),
      'concentration': serializer.toJson<String?>(concentration),
      'displayOrder': serializer.toJson<int>(displayOrder),
    };
  }

  CompositionEntity copyWith({
    int? id,
    int? productId,
    String? ingredientEn,
    Value<String?> ingredientBn = const Value.absent(),
    Value<String?> concentration = const Value.absent(),
    int? displayOrder,
  }) => CompositionEntity(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    ingredientEn: ingredientEn ?? this.ingredientEn,
    ingredientBn: ingredientBn.present ? ingredientBn.value : this.ingredientBn,
    concentration: concentration.present
        ? concentration.value
        : this.concentration,
    displayOrder: displayOrder ?? this.displayOrder,
  );
  CompositionEntity copyWithCompanion(CompositionsCompanion data) {
    return CompositionEntity(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      ingredientEn: data.ingredientEn.present
          ? data.ingredientEn.value
          : this.ingredientEn,
      ingredientBn: data.ingredientBn.present
          ? data.ingredientBn.value
          : this.ingredientBn,
      concentration: data.concentration.present
          ? data.concentration.value
          : this.concentration,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompositionEntity(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('ingredientEn: $ingredientEn, ')
          ..write('ingredientBn: $ingredientBn, ')
          ..write('concentration: $concentration, ')
          ..write('displayOrder: $displayOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    ingredientEn,
    ingredientBn,
    concentration,
    displayOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompositionEntity &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.ingredientEn == this.ingredientEn &&
          other.ingredientBn == this.ingredientBn &&
          other.concentration == this.concentration &&
          other.displayOrder == this.displayOrder);
}

class CompositionsCompanion extends UpdateCompanion<CompositionEntity> {
  final Value<int> id;
  final Value<int> productId;
  final Value<String> ingredientEn;
  final Value<String?> ingredientBn;
  final Value<String?> concentration;
  final Value<int> displayOrder;
  const CompositionsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.ingredientEn = const Value.absent(),
    this.ingredientBn = const Value.absent(),
    this.concentration = const Value.absent(),
    this.displayOrder = const Value.absent(),
  });
  CompositionsCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required String ingredientEn,
    this.ingredientBn = const Value.absent(),
    this.concentration = const Value.absent(),
    this.displayOrder = const Value.absent(),
  }) : productId = Value(productId),
       ingredientEn = Value(ingredientEn);
  static Insertable<CompositionEntity> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<String>? ingredientEn,
    Expression<String>? ingredientBn,
    Expression<String>? concentration,
    Expression<int>? displayOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (ingredientEn != null) 'ingredient_en': ingredientEn,
      if (ingredientBn != null) 'ingredient_bn': ingredientBn,
      if (concentration != null) 'concentration': concentration,
      if (displayOrder != null) 'display_order': displayOrder,
    });
  }

  CompositionsCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<String>? ingredientEn,
    Value<String?>? ingredientBn,
    Value<String?>? concentration,
    Value<int>? displayOrder,
  }) {
    return CompositionsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      ingredientEn: ingredientEn ?? this.ingredientEn,
      ingredientBn: ingredientBn ?? this.ingredientBn,
      concentration: concentration ?? this.concentration,
      displayOrder: displayOrder ?? this.displayOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (ingredientEn.present) {
      map['ingredient_en'] = Variable<String>(ingredientEn.value);
    }
    if (ingredientBn.present) {
      map['ingredient_bn'] = Variable<String>(ingredientBn.value);
    }
    if (concentration.present) {
      map['concentration'] = Variable<String>(concentration.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompositionsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('ingredientEn: $ingredientEn, ')
          ..write('ingredientBn: $ingredientBn, ')
          ..write('concentration: $concentration, ')
          ..write('displayOrder: $displayOrder')
          ..write(')'))
        .toString();
  }
}

class $IndicationsTable extends Indications
    with TableInfo<$IndicationsTable, IndicationEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IndicationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES products(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _textEnMeta = const VerificationMeta('textEn');
  @override
  late final GeneratedColumn<String> textEn = GeneratedColumn<String>(
    'text_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textBnMeta = const VerificationMeta('textBn');
  @override
  late final GeneratedColumn<String> textBn = GeneratedColumn<String>(
    'text_bn',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _displayOrderMeta = const VerificationMeta(
    'displayOrder',
  );
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
    'display_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    textEn,
    textBn,
    displayOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'indications';
  @override
  VerificationContext validateIntegrity(
    Insertable<IndicationEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('text_en')) {
      context.handle(
        _textEnMeta,
        textEn.isAcceptableOrUnknown(data['text_en']!, _textEnMeta),
      );
    } else if (isInserting) {
      context.missing(_textEnMeta);
    }
    if (data.containsKey('text_bn')) {
      context.handle(
        _textBnMeta,
        textBn.isAcceptableOrUnknown(data['text_bn']!, _textBnMeta),
      );
    }
    if (data.containsKey('display_order')) {
      context.handle(
        _displayOrderMeta,
        displayOrder.isAcceptableOrUnknown(
          data['display_order']!,
          _displayOrderMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IndicationEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IndicationEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      textEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_en'],
      )!,
      textBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_bn'],
      ),
      displayOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}display_order'],
      )!,
    );
  }

  @override
  $IndicationsTable createAlias(String alias) {
    return $IndicationsTable(attachedDatabase, alias);
  }
}

class IndicationEntity extends DataClass
    implements Insertable<IndicationEntity> {
  final int id;
  final int productId;
  final String textEn;
  final String? textBn;
  final int displayOrder;
  const IndicationEntity({
    required this.id,
    required this.productId,
    required this.textEn,
    this.textBn,
    required this.displayOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['text_en'] = Variable<String>(textEn);
    if (!nullToAbsent || textBn != null) {
      map['text_bn'] = Variable<String>(textBn);
    }
    map['display_order'] = Variable<int>(displayOrder);
    return map;
  }

  IndicationsCompanion toCompanion(bool nullToAbsent) {
    return IndicationsCompanion(
      id: Value(id),
      productId: Value(productId),
      textEn: Value(textEn),
      textBn: textBn == null && nullToAbsent
          ? const Value.absent()
          : Value(textBn),
      displayOrder: Value(displayOrder),
    );
  }

  factory IndicationEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IndicationEntity(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      textEn: serializer.fromJson<String>(json['textEn']),
      textBn: serializer.fromJson<String?>(json['textBn']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'textEn': serializer.toJson<String>(textEn),
      'textBn': serializer.toJson<String?>(textBn),
      'displayOrder': serializer.toJson<int>(displayOrder),
    };
  }

  IndicationEntity copyWith({
    int? id,
    int? productId,
    String? textEn,
    Value<String?> textBn = const Value.absent(),
    int? displayOrder,
  }) => IndicationEntity(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    textEn: textEn ?? this.textEn,
    textBn: textBn.present ? textBn.value : this.textBn,
    displayOrder: displayOrder ?? this.displayOrder,
  );
  IndicationEntity copyWithCompanion(IndicationsCompanion data) {
    return IndicationEntity(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      textEn: data.textEn.present ? data.textEn.value : this.textEn,
      textBn: data.textBn.present ? data.textBn.value : this.textBn,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IndicationEntity(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('textEn: $textEn, ')
          ..write('textBn: $textBn, ')
          ..write('displayOrder: $displayOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productId, textEn, textBn, displayOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IndicationEntity &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.textEn == this.textEn &&
          other.textBn == this.textBn &&
          other.displayOrder == this.displayOrder);
}

class IndicationsCompanion extends UpdateCompanion<IndicationEntity> {
  final Value<int> id;
  final Value<int> productId;
  final Value<String> textEn;
  final Value<String?> textBn;
  final Value<int> displayOrder;
  const IndicationsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.textEn = const Value.absent(),
    this.textBn = const Value.absent(),
    this.displayOrder = const Value.absent(),
  });
  IndicationsCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required String textEn,
    this.textBn = const Value.absent(),
    this.displayOrder = const Value.absent(),
  }) : productId = Value(productId),
       textEn = Value(textEn);
  static Insertable<IndicationEntity> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<String>? textEn,
    Expression<String>? textBn,
    Expression<int>? displayOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (textEn != null) 'text_en': textEn,
      if (textBn != null) 'text_bn': textBn,
      if (displayOrder != null) 'display_order': displayOrder,
    });
  }

  IndicationsCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<String>? textEn,
    Value<String?>? textBn,
    Value<int>? displayOrder,
  }) {
    return IndicationsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      textEn: textEn ?? this.textEn,
      textBn: textBn ?? this.textBn,
      displayOrder: displayOrder ?? this.displayOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (textEn.present) {
      map['text_en'] = Variable<String>(textEn.value);
    }
    if (textBn.present) {
      map['text_bn'] = Variable<String>(textBn.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IndicationsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('textEn: $textEn, ')
          ..write('textBn: $textBn, ')
          ..write('displayOrder: $displayOrder')
          ..write(')'))
        .toString();
  }
}

class $DirectionsTable extends Directions
    with TableInfo<$DirectionsTable, DirectionEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DirectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES products(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _contentTypeIdMeta = const VerificationMeta(
    'contentTypeId',
  );
  @override
  late final GeneratedColumn<int> contentTypeId = GeneratedColumn<int>(
    'content_type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES content_types(id)',
  );
  static const VerificationMeta _speciesIdMeta = const VerificationMeta(
    'speciesId',
  );
  @override
  late final GeneratedColumn<int> speciesId = GeneratedColumn<int>(
    'species_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES species(id)',
  );
  static const VerificationMeta _doseValueMinMeta = const VerificationMeta(
    'doseValueMin',
  );
  @override
  late final GeneratedColumn<double> doseValueMin = GeneratedColumn<double>(
    'dose_value_min',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _doseValueMaxMeta = const VerificationMeta(
    'doseValueMax',
  );
  @override
  late final GeneratedColumn<double> doseValueMax = GeneratedColumn<double>(
    'dose_value_max',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _doseUnitIdMeta = const VerificationMeta(
    'doseUnitId',
  );
  @override
  late final GeneratedColumn<int> doseUnitId = GeneratedColumn<int>(
    'dose_unit_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES dosage_units(id)',
  );
  static const VerificationMeta _doseBasisIdMeta = const VerificationMeta(
    'doseBasisId',
  );
  @override
  late final GeneratedColumn<int> doseBasisId = GeneratedColumn<int>(
    'dose_basis_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES dosage_bases(id)',
  );
  static const VerificationMeta _durationDaysMinMeta = const VerificationMeta(
    'durationDaysMin',
  );
  @override
  late final GeneratedColumn<int> durationDaysMin = GeneratedColumn<int>(
    'duration_days_min',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationDaysMaxMeta = const VerificationMeta(
    'durationDaysMax',
  );
  @override
  late final GeneratedColumn<int> durationDaysMax = GeneratedColumn<int>(
    'duration_days_max',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _administrationEnMeta = const VerificationMeta(
    'administrationEn',
  );
  @override
  late final GeneratedColumn<String> administrationEn = GeneratedColumn<String>(
    'administration_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _administrationBnMeta = const VerificationMeta(
    'administrationBn',
  );
  @override
  late final GeneratedColumn<String> administrationBn = GeneratedColumn<String>(
    'administration_bn',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dosageEnMeta = const VerificationMeta(
    'dosageEn',
  );
  @override
  late final GeneratedColumn<String> dosageEn = GeneratedColumn<String>(
    'dosage_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dosageBnMeta = const VerificationMeta(
    'dosageBn',
  );
  @override
  late final GeneratedColumn<String> dosageBn = GeneratedColumn<String>(
    'dosage_bn',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _displayOrderMeta = const VerificationMeta(
    'displayOrder',
  );
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
    'display_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    contentTypeId,
    speciesId,
    doseValueMin,
    doseValueMax,
    doseUnitId,
    doseBasisId,
    durationDaysMin,
    durationDaysMax,
    administrationEn,
    administrationBn,
    dosageEn,
    dosageBn,
    displayOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'directions';
  @override
  VerificationContext validateIntegrity(
    Insertable<DirectionEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('content_type_id')) {
      context.handle(
        _contentTypeIdMeta,
        contentTypeId.isAcceptableOrUnknown(
          data['content_type_id']!,
          _contentTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentTypeIdMeta);
    }
    if (data.containsKey('species_id')) {
      context.handle(
        _speciesIdMeta,
        speciesId.isAcceptableOrUnknown(data['species_id']!, _speciesIdMeta),
      );
    } else if (isInserting) {
      context.missing(_speciesIdMeta);
    }
    if (data.containsKey('dose_value_min')) {
      context.handle(
        _doseValueMinMeta,
        doseValueMin.isAcceptableOrUnknown(
          data['dose_value_min']!,
          _doseValueMinMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_doseValueMinMeta);
    }
    if (data.containsKey('dose_value_max')) {
      context.handle(
        _doseValueMaxMeta,
        doseValueMax.isAcceptableOrUnknown(
          data['dose_value_max']!,
          _doseValueMaxMeta,
        ),
      );
    }
    if (data.containsKey('dose_unit_id')) {
      context.handle(
        _doseUnitIdMeta,
        doseUnitId.isAcceptableOrUnknown(
          data['dose_unit_id']!,
          _doseUnitIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_doseUnitIdMeta);
    }
    if (data.containsKey('dose_basis_id')) {
      context.handle(
        _doseBasisIdMeta,
        doseBasisId.isAcceptableOrUnknown(
          data['dose_basis_id']!,
          _doseBasisIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_doseBasisIdMeta);
    }
    if (data.containsKey('duration_days_min')) {
      context.handle(
        _durationDaysMinMeta,
        durationDaysMin.isAcceptableOrUnknown(
          data['duration_days_min']!,
          _durationDaysMinMeta,
        ),
      );
    }
    if (data.containsKey('duration_days_max')) {
      context.handle(
        _durationDaysMaxMeta,
        durationDaysMax.isAcceptableOrUnknown(
          data['duration_days_max']!,
          _durationDaysMaxMeta,
        ),
      );
    }
    if (data.containsKey('administration_en')) {
      context.handle(
        _administrationEnMeta,
        administrationEn.isAcceptableOrUnknown(
          data['administration_en']!,
          _administrationEnMeta,
        ),
      );
    }
    if (data.containsKey('administration_bn')) {
      context.handle(
        _administrationBnMeta,
        administrationBn.isAcceptableOrUnknown(
          data['administration_bn']!,
          _administrationBnMeta,
        ),
      );
    }
    if (data.containsKey('dosage_en')) {
      context.handle(
        _dosageEnMeta,
        dosageEn.isAcceptableOrUnknown(data['dosage_en']!, _dosageEnMeta),
      );
    }
    if (data.containsKey('dosage_bn')) {
      context.handle(
        _dosageBnMeta,
        dosageBn.isAcceptableOrUnknown(data['dosage_bn']!, _dosageBnMeta),
      );
    }
    if (data.containsKey('display_order')) {
      context.handle(
        _displayOrderMeta,
        displayOrder.isAcceptableOrUnknown(
          data['display_order']!,
          _displayOrderMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DirectionEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DirectionEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      contentTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}content_type_id'],
      )!,
      speciesId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}species_id'],
      )!,
      doseValueMin: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}dose_value_min'],
      )!,
      doseValueMax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}dose_value_max'],
      ),
      doseUnitId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dose_unit_id'],
      )!,
      doseBasisId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dose_basis_id'],
      )!,
      durationDaysMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_days_min'],
      ),
      durationDaysMax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_days_max'],
      ),
      administrationEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}administration_en'],
      ),
      administrationBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}administration_bn'],
      ),
      dosageEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dosage_en'],
      ),
      dosageBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dosage_bn'],
      ),
      displayOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}display_order'],
      )!,
    );
  }

  @override
  $DirectionsTable createAlias(String alias) {
    return $DirectionsTable(attachedDatabase, alias);
  }
}

class DirectionEntity extends DataClass implements Insertable<DirectionEntity> {
  final int id;
  final int productId;
  final int contentTypeId;
  final int speciesId;
  final double doseValueMin;
  final double? doseValueMax;
  final int doseUnitId;
  final int doseBasisId;
  final int? durationDaysMin;
  final int? durationDaysMax;
  final String? administrationEn;
  final String? administrationBn;
  final String? dosageEn;
  final String? dosageBn;
  final int displayOrder;
  const DirectionEntity({
    required this.id,
    required this.productId,
    required this.contentTypeId,
    required this.speciesId,
    required this.doseValueMin,
    this.doseValueMax,
    required this.doseUnitId,
    required this.doseBasisId,
    this.durationDaysMin,
    this.durationDaysMax,
    this.administrationEn,
    this.administrationBn,
    this.dosageEn,
    this.dosageBn,
    required this.displayOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['content_type_id'] = Variable<int>(contentTypeId);
    map['species_id'] = Variable<int>(speciesId);
    map['dose_value_min'] = Variable<double>(doseValueMin);
    if (!nullToAbsent || doseValueMax != null) {
      map['dose_value_max'] = Variable<double>(doseValueMax);
    }
    map['dose_unit_id'] = Variable<int>(doseUnitId);
    map['dose_basis_id'] = Variable<int>(doseBasisId);
    if (!nullToAbsent || durationDaysMin != null) {
      map['duration_days_min'] = Variable<int>(durationDaysMin);
    }
    if (!nullToAbsent || durationDaysMax != null) {
      map['duration_days_max'] = Variable<int>(durationDaysMax);
    }
    if (!nullToAbsent || administrationEn != null) {
      map['administration_en'] = Variable<String>(administrationEn);
    }
    if (!nullToAbsent || administrationBn != null) {
      map['administration_bn'] = Variable<String>(administrationBn);
    }
    if (!nullToAbsent || dosageEn != null) {
      map['dosage_en'] = Variable<String>(dosageEn);
    }
    if (!nullToAbsent || dosageBn != null) {
      map['dosage_bn'] = Variable<String>(dosageBn);
    }
    map['display_order'] = Variable<int>(displayOrder);
    return map;
  }

  DirectionsCompanion toCompanion(bool nullToAbsent) {
    return DirectionsCompanion(
      id: Value(id),
      productId: Value(productId),
      contentTypeId: Value(contentTypeId),
      speciesId: Value(speciesId),
      doseValueMin: Value(doseValueMin),
      doseValueMax: doseValueMax == null && nullToAbsent
          ? const Value.absent()
          : Value(doseValueMax),
      doseUnitId: Value(doseUnitId),
      doseBasisId: Value(doseBasisId),
      durationDaysMin: durationDaysMin == null && nullToAbsent
          ? const Value.absent()
          : Value(durationDaysMin),
      durationDaysMax: durationDaysMax == null && nullToAbsent
          ? const Value.absent()
          : Value(durationDaysMax),
      administrationEn: administrationEn == null && nullToAbsent
          ? const Value.absent()
          : Value(administrationEn),
      administrationBn: administrationBn == null && nullToAbsent
          ? const Value.absent()
          : Value(administrationBn),
      dosageEn: dosageEn == null && nullToAbsent
          ? const Value.absent()
          : Value(dosageEn),
      dosageBn: dosageBn == null && nullToAbsent
          ? const Value.absent()
          : Value(dosageBn),
      displayOrder: Value(displayOrder),
    );
  }

  factory DirectionEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DirectionEntity(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      contentTypeId: serializer.fromJson<int>(json['contentTypeId']),
      speciesId: serializer.fromJson<int>(json['speciesId']),
      doseValueMin: serializer.fromJson<double>(json['doseValueMin']),
      doseValueMax: serializer.fromJson<double?>(json['doseValueMax']),
      doseUnitId: serializer.fromJson<int>(json['doseUnitId']),
      doseBasisId: serializer.fromJson<int>(json['doseBasisId']),
      durationDaysMin: serializer.fromJson<int?>(json['durationDaysMin']),
      durationDaysMax: serializer.fromJson<int?>(json['durationDaysMax']),
      administrationEn: serializer.fromJson<String?>(json['administrationEn']),
      administrationBn: serializer.fromJson<String?>(json['administrationBn']),
      dosageEn: serializer.fromJson<String?>(json['dosageEn']),
      dosageBn: serializer.fromJson<String?>(json['dosageBn']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'contentTypeId': serializer.toJson<int>(contentTypeId),
      'speciesId': serializer.toJson<int>(speciesId),
      'doseValueMin': serializer.toJson<double>(doseValueMin),
      'doseValueMax': serializer.toJson<double?>(doseValueMax),
      'doseUnitId': serializer.toJson<int>(doseUnitId),
      'doseBasisId': serializer.toJson<int>(doseBasisId),
      'durationDaysMin': serializer.toJson<int?>(durationDaysMin),
      'durationDaysMax': serializer.toJson<int?>(durationDaysMax),
      'administrationEn': serializer.toJson<String?>(administrationEn),
      'administrationBn': serializer.toJson<String?>(administrationBn),
      'dosageEn': serializer.toJson<String?>(dosageEn),
      'dosageBn': serializer.toJson<String?>(dosageBn),
      'displayOrder': serializer.toJson<int>(displayOrder),
    };
  }

  DirectionEntity copyWith({
    int? id,
    int? productId,
    int? contentTypeId,
    int? speciesId,
    double? doseValueMin,
    Value<double?> doseValueMax = const Value.absent(),
    int? doseUnitId,
    int? doseBasisId,
    Value<int?> durationDaysMin = const Value.absent(),
    Value<int?> durationDaysMax = const Value.absent(),
    Value<String?> administrationEn = const Value.absent(),
    Value<String?> administrationBn = const Value.absent(),
    Value<String?> dosageEn = const Value.absent(),
    Value<String?> dosageBn = const Value.absent(),
    int? displayOrder,
  }) => DirectionEntity(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    contentTypeId: contentTypeId ?? this.contentTypeId,
    speciesId: speciesId ?? this.speciesId,
    doseValueMin: doseValueMin ?? this.doseValueMin,
    doseValueMax: doseValueMax.present ? doseValueMax.value : this.doseValueMax,
    doseUnitId: doseUnitId ?? this.doseUnitId,
    doseBasisId: doseBasisId ?? this.doseBasisId,
    durationDaysMin: durationDaysMin.present
        ? durationDaysMin.value
        : this.durationDaysMin,
    durationDaysMax: durationDaysMax.present
        ? durationDaysMax.value
        : this.durationDaysMax,
    administrationEn: administrationEn.present
        ? administrationEn.value
        : this.administrationEn,
    administrationBn: administrationBn.present
        ? administrationBn.value
        : this.administrationBn,
    dosageEn: dosageEn.present ? dosageEn.value : this.dosageEn,
    dosageBn: dosageBn.present ? dosageBn.value : this.dosageBn,
    displayOrder: displayOrder ?? this.displayOrder,
  );
  DirectionEntity copyWithCompanion(DirectionsCompanion data) {
    return DirectionEntity(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      contentTypeId: data.contentTypeId.present
          ? data.contentTypeId.value
          : this.contentTypeId,
      speciesId: data.speciesId.present ? data.speciesId.value : this.speciesId,
      doseValueMin: data.doseValueMin.present
          ? data.doseValueMin.value
          : this.doseValueMin,
      doseValueMax: data.doseValueMax.present
          ? data.doseValueMax.value
          : this.doseValueMax,
      doseUnitId: data.doseUnitId.present
          ? data.doseUnitId.value
          : this.doseUnitId,
      doseBasisId: data.doseBasisId.present
          ? data.doseBasisId.value
          : this.doseBasisId,
      durationDaysMin: data.durationDaysMin.present
          ? data.durationDaysMin.value
          : this.durationDaysMin,
      durationDaysMax: data.durationDaysMax.present
          ? data.durationDaysMax.value
          : this.durationDaysMax,
      administrationEn: data.administrationEn.present
          ? data.administrationEn.value
          : this.administrationEn,
      administrationBn: data.administrationBn.present
          ? data.administrationBn.value
          : this.administrationBn,
      dosageEn: data.dosageEn.present ? data.dosageEn.value : this.dosageEn,
      dosageBn: data.dosageBn.present ? data.dosageBn.value : this.dosageBn,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DirectionEntity(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('contentTypeId: $contentTypeId, ')
          ..write('speciesId: $speciesId, ')
          ..write('doseValueMin: $doseValueMin, ')
          ..write('doseValueMax: $doseValueMax, ')
          ..write('doseUnitId: $doseUnitId, ')
          ..write('doseBasisId: $doseBasisId, ')
          ..write('durationDaysMin: $durationDaysMin, ')
          ..write('durationDaysMax: $durationDaysMax, ')
          ..write('administrationEn: $administrationEn, ')
          ..write('administrationBn: $administrationBn, ')
          ..write('dosageEn: $dosageEn, ')
          ..write('dosageBn: $dosageBn, ')
          ..write('displayOrder: $displayOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    contentTypeId,
    speciesId,
    doseValueMin,
    doseValueMax,
    doseUnitId,
    doseBasisId,
    durationDaysMin,
    durationDaysMax,
    administrationEn,
    administrationBn,
    dosageEn,
    dosageBn,
    displayOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DirectionEntity &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.contentTypeId == this.contentTypeId &&
          other.speciesId == this.speciesId &&
          other.doseValueMin == this.doseValueMin &&
          other.doseValueMax == this.doseValueMax &&
          other.doseUnitId == this.doseUnitId &&
          other.doseBasisId == this.doseBasisId &&
          other.durationDaysMin == this.durationDaysMin &&
          other.durationDaysMax == this.durationDaysMax &&
          other.administrationEn == this.administrationEn &&
          other.administrationBn == this.administrationBn &&
          other.dosageEn == this.dosageEn &&
          other.dosageBn == this.dosageBn &&
          other.displayOrder == this.displayOrder);
}

class DirectionsCompanion extends UpdateCompanion<DirectionEntity> {
  final Value<int> id;
  final Value<int> productId;
  final Value<int> contentTypeId;
  final Value<int> speciesId;
  final Value<double> doseValueMin;
  final Value<double?> doseValueMax;
  final Value<int> doseUnitId;
  final Value<int> doseBasisId;
  final Value<int?> durationDaysMin;
  final Value<int?> durationDaysMax;
  final Value<String?> administrationEn;
  final Value<String?> administrationBn;
  final Value<String?> dosageEn;
  final Value<String?> dosageBn;
  final Value<int> displayOrder;
  const DirectionsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.contentTypeId = const Value.absent(),
    this.speciesId = const Value.absent(),
    this.doseValueMin = const Value.absent(),
    this.doseValueMax = const Value.absent(),
    this.doseUnitId = const Value.absent(),
    this.doseBasisId = const Value.absent(),
    this.durationDaysMin = const Value.absent(),
    this.durationDaysMax = const Value.absent(),
    this.administrationEn = const Value.absent(),
    this.administrationBn = const Value.absent(),
    this.dosageEn = const Value.absent(),
    this.dosageBn = const Value.absent(),
    this.displayOrder = const Value.absent(),
  });
  DirectionsCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required int contentTypeId,
    required int speciesId,
    required double doseValueMin,
    this.doseValueMax = const Value.absent(),
    required int doseUnitId,
    required int doseBasisId,
    this.durationDaysMin = const Value.absent(),
    this.durationDaysMax = const Value.absent(),
    this.administrationEn = const Value.absent(),
    this.administrationBn = const Value.absent(),
    this.dosageEn = const Value.absent(),
    this.dosageBn = const Value.absent(),
    this.displayOrder = const Value.absent(),
  }) : productId = Value(productId),
       contentTypeId = Value(contentTypeId),
       speciesId = Value(speciesId),
       doseValueMin = Value(doseValueMin),
       doseUnitId = Value(doseUnitId),
       doseBasisId = Value(doseBasisId);
  static Insertable<DirectionEntity> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<int>? contentTypeId,
    Expression<int>? speciesId,
    Expression<double>? doseValueMin,
    Expression<double>? doseValueMax,
    Expression<int>? doseUnitId,
    Expression<int>? doseBasisId,
    Expression<int>? durationDaysMin,
    Expression<int>? durationDaysMax,
    Expression<String>? administrationEn,
    Expression<String>? administrationBn,
    Expression<String>? dosageEn,
    Expression<String>? dosageBn,
    Expression<int>? displayOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (contentTypeId != null) 'content_type_id': contentTypeId,
      if (speciesId != null) 'species_id': speciesId,
      if (doseValueMin != null) 'dose_value_min': doseValueMin,
      if (doseValueMax != null) 'dose_value_max': doseValueMax,
      if (doseUnitId != null) 'dose_unit_id': doseUnitId,
      if (doseBasisId != null) 'dose_basis_id': doseBasisId,
      if (durationDaysMin != null) 'duration_days_min': durationDaysMin,
      if (durationDaysMax != null) 'duration_days_max': durationDaysMax,
      if (administrationEn != null) 'administration_en': administrationEn,
      if (administrationBn != null) 'administration_bn': administrationBn,
      if (dosageEn != null) 'dosage_en': dosageEn,
      if (dosageBn != null) 'dosage_bn': dosageBn,
      if (displayOrder != null) 'display_order': displayOrder,
    });
  }

  DirectionsCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<int>? contentTypeId,
    Value<int>? speciesId,
    Value<double>? doseValueMin,
    Value<double?>? doseValueMax,
    Value<int>? doseUnitId,
    Value<int>? doseBasisId,
    Value<int?>? durationDaysMin,
    Value<int?>? durationDaysMax,
    Value<String?>? administrationEn,
    Value<String?>? administrationBn,
    Value<String?>? dosageEn,
    Value<String?>? dosageBn,
    Value<int>? displayOrder,
  }) {
    return DirectionsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      contentTypeId: contentTypeId ?? this.contentTypeId,
      speciesId: speciesId ?? this.speciesId,
      doseValueMin: doseValueMin ?? this.doseValueMin,
      doseValueMax: doseValueMax ?? this.doseValueMax,
      doseUnitId: doseUnitId ?? this.doseUnitId,
      doseBasisId: doseBasisId ?? this.doseBasisId,
      durationDaysMin: durationDaysMin ?? this.durationDaysMin,
      durationDaysMax: durationDaysMax ?? this.durationDaysMax,
      administrationEn: administrationEn ?? this.administrationEn,
      administrationBn: administrationBn ?? this.administrationBn,
      dosageEn: dosageEn ?? this.dosageEn,
      dosageBn: dosageBn ?? this.dosageBn,
      displayOrder: displayOrder ?? this.displayOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (contentTypeId.present) {
      map['content_type_id'] = Variable<int>(contentTypeId.value);
    }
    if (speciesId.present) {
      map['species_id'] = Variable<int>(speciesId.value);
    }
    if (doseValueMin.present) {
      map['dose_value_min'] = Variable<double>(doseValueMin.value);
    }
    if (doseValueMax.present) {
      map['dose_value_max'] = Variable<double>(doseValueMax.value);
    }
    if (doseUnitId.present) {
      map['dose_unit_id'] = Variable<int>(doseUnitId.value);
    }
    if (doseBasisId.present) {
      map['dose_basis_id'] = Variable<int>(doseBasisId.value);
    }
    if (durationDaysMin.present) {
      map['duration_days_min'] = Variable<int>(durationDaysMin.value);
    }
    if (durationDaysMax.present) {
      map['duration_days_max'] = Variable<int>(durationDaysMax.value);
    }
    if (administrationEn.present) {
      map['administration_en'] = Variable<String>(administrationEn.value);
    }
    if (administrationBn.present) {
      map['administration_bn'] = Variable<String>(administrationBn.value);
    }
    if (dosageEn.present) {
      map['dosage_en'] = Variable<String>(dosageEn.value);
    }
    if (dosageBn.present) {
      map['dosage_bn'] = Variable<String>(dosageBn.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DirectionsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('contentTypeId: $contentTypeId, ')
          ..write('speciesId: $speciesId, ')
          ..write('doseValueMin: $doseValueMin, ')
          ..write('doseValueMax: $doseValueMax, ')
          ..write('doseUnitId: $doseUnitId, ')
          ..write('doseBasisId: $doseBasisId, ')
          ..write('durationDaysMin: $durationDaysMin, ')
          ..write('durationDaysMax: $durationDaysMax, ')
          ..write('administrationEn: $administrationEn, ')
          ..write('administrationBn: $administrationBn, ')
          ..write('dosageEn: $dosageEn, ')
          ..write('dosageBn: $dosageBn, ')
          ..write('displayOrder: $displayOrder')
          ..write(')'))
        .toString();
  }
}

class $PrecautionsTable extends Precautions
    with TableInfo<$PrecautionsTable, PrecautionEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrecautionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES products(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _textEnMeta = const VerificationMeta('textEn');
  @override
  late final GeneratedColumn<String> textEn = GeneratedColumn<String>(
    'text_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textBnMeta = const VerificationMeta('textBn');
  @override
  late final GeneratedColumn<String> textBn = GeneratedColumn<String>(
    'text_bn',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _displayOrderMeta = const VerificationMeta(
    'displayOrder',
  );
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
    'display_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    textEn,
    textBn,
    displayOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'precautions';
  @override
  VerificationContext validateIntegrity(
    Insertable<PrecautionEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('text_en')) {
      context.handle(
        _textEnMeta,
        textEn.isAcceptableOrUnknown(data['text_en']!, _textEnMeta),
      );
    } else if (isInserting) {
      context.missing(_textEnMeta);
    }
    if (data.containsKey('text_bn')) {
      context.handle(
        _textBnMeta,
        textBn.isAcceptableOrUnknown(data['text_bn']!, _textBnMeta),
      );
    }
    if (data.containsKey('display_order')) {
      context.handle(
        _displayOrderMeta,
        displayOrder.isAcceptableOrUnknown(
          data['display_order']!,
          _displayOrderMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PrecautionEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrecautionEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      textEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_en'],
      )!,
      textBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_bn'],
      ),
      displayOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}display_order'],
      )!,
    );
  }

  @override
  $PrecautionsTable createAlias(String alias) {
    return $PrecautionsTable(attachedDatabase, alias);
  }
}

class PrecautionEntity extends DataClass
    implements Insertable<PrecautionEntity> {
  final int id;
  final int productId;
  final String textEn;
  final String? textBn;
  final int displayOrder;
  const PrecautionEntity({
    required this.id,
    required this.productId,
    required this.textEn,
    this.textBn,
    required this.displayOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['text_en'] = Variable<String>(textEn);
    if (!nullToAbsent || textBn != null) {
      map['text_bn'] = Variable<String>(textBn);
    }
    map['display_order'] = Variable<int>(displayOrder);
    return map;
  }

  PrecautionsCompanion toCompanion(bool nullToAbsent) {
    return PrecautionsCompanion(
      id: Value(id),
      productId: Value(productId),
      textEn: Value(textEn),
      textBn: textBn == null && nullToAbsent
          ? const Value.absent()
          : Value(textBn),
      displayOrder: Value(displayOrder),
    );
  }

  factory PrecautionEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrecautionEntity(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      textEn: serializer.fromJson<String>(json['textEn']),
      textBn: serializer.fromJson<String?>(json['textBn']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'textEn': serializer.toJson<String>(textEn),
      'textBn': serializer.toJson<String?>(textBn),
      'displayOrder': serializer.toJson<int>(displayOrder),
    };
  }

  PrecautionEntity copyWith({
    int? id,
    int? productId,
    String? textEn,
    Value<String?> textBn = const Value.absent(),
    int? displayOrder,
  }) => PrecautionEntity(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    textEn: textEn ?? this.textEn,
    textBn: textBn.present ? textBn.value : this.textBn,
    displayOrder: displayOrder ?? this.displayOrder,
  );
  PrecautionEntity copyWithCompanion(PrecautionsCompanion data) {
    return PrecautionEntity(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      textEn: data.textEn.present ? data.textEn.value : this.textEn,
      textBn: data.textBn.present ? data.textBn.value : this.textBn,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrecautionEntity(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('textEn: $textEn, ')
          ..write('textBn: $textBn, ')
          ..write('displayOrder: $displayOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productId, textEn, textBn, displayOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrecautionEntity &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.textEn == this.textEn &&
          other.textBn == this.textBn &&
          other.displayOrder == this.displayOrder);
}

class PrecautionsCompanion extends UpdateCompanion<PrecautionEntity> {
  final Value<int> id;
  final Value<int> productId;
  final Value<String> textEn;
  final Value<String?> textBn;
  final Value<int> displayOrder;
  const PrecautionsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.textEn = const Value.absent(),
    this.textBn = const Value.absent(),
    this.displayOrder = const Value.absent(),
  });
  PrecautionsCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required String textEn,
    this.textBn = const Value.absent(),
    this.displayOrder = const Value.absent(),
  }) : productId = Value(productId),
       textEn = Value(textEn);
  static Insertable<PrecautionEntity> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<String>? textEn,
    Expression<String>? textBn,
    Expression<int>? displayOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (textEn != null) 'text_en': textEn,
      if (textBn != null) 'text_bn': textBn,
      if (displayOrder != null) 'display_order': displayOrder,
    });
  }

  PrecautionsCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<String>? textEn,
    Value<String?>? textBn,
    Value<int>? displayOrder,
  }) {
    return PrecautionsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      textEn: textEn ?? this.textEn,
      textBn: textBn ?? this.textBn,
      displayOrder: displayOrder ?? this.displayOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (textEn.present) {
      map['text_en'] = Variable<String>(textEn.value);
    }
    if (textBn.present) {
      map['text_bn'] = Variable<String>(textBn.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrecautionsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('textEn: $textEn, ')
          ..write('textBn: $textBn, ')
          ..write('displayOrder: $displayOrder')
          ..write(')'))
        .toString();
  }
}

class $PresentationsTable extends Presentations
    with TableInfo<$PresentationsTable, PresentationEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PresentationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES products(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _productTypeIdMeta = const VerificationMeta(
    'productTypeId',
  );
  @override
  late final GeneratedColumn<int> productTypeId = GeneratedColumn<int>(
    'product_type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES product_types(id)',
  );
  static const VerificationMeta _contentTypeIdMeta = const VerificationMeta(
    'contentTypeId',
  );
  @override
  late final GeneratedColumn<int> contentTypeId = GeneratedColumn<int>(
    'content_type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES content_types(id)',
  );
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<String> size = GeneratedColumn<String>(
    'size',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mrpMeta = const VerificationMeta('mrp');
  @override
  late final GeneratedColumn<double> mrp = GeneratedColumn<double>(
    'mrp',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _displayOrderMeta = const VerificationMeta(
    'displayOrder',
  );
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
    'display_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _bulkItemMeta = const VerificationMeta(
    'bulkItem',
  );
  @override
  late final GeneratedColumn<int> bulkItem = GeneratedColumn<int>(
    'bulk_item',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    productTypeId,
    contentTypeId,
    size,
    mrp,
    imageUrl,
    displayOrder,
    bulkItem,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'presentations';
  @override
  VerificationContext validateIntegrity(
    Insertable<PresentationEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('product_type_id')) {
      context.handle(
        _productTypeIdMeta,
        productTypeId.isAcceptableOrUnknown(
          data['product_type_id']!,
          _productTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productTypeIdMeta);
    }
    if (data.containsKey('content_type_id')) {
      context.handle(
        _contentTypeIdMeta,
        contentTypeId.isAcceptableOrUnknown(
          data['content_type_id']!,
          _contentTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentTypeIdMeta);
    }
    if (data.containsKey('size')) {
      context.handle(
        _sizeMeta,
        size.isAcceptableOrUnknown(data['size']!, _sizeMeta),
      );
    }
    if (data.containsKey('mrp')) {
      context.handle(
        _mrpMeta,
        mrp.isAcceptableOrUnknown(data['mrp']!, _mrpMeta),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('display_order')) {
      context.handle(
        _displayOrderMeta,
        displayOrder.isAcceptableOrUnknown(
          data['display_order']!,
          _displayOrderMeta,
        ),
      );
    }
    if (data.containsKey('bulk_item')) {
      context.handle(
        _bulkItemMeta,
        bulkItem.isAcceptableOrUnknown(data['bulk_item']!, _bulkItemMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PresentationEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PresentationEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      productTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_type_id'],
      )!,
      contentTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}content_type_id'],
      )!,
      size: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}size'],
      ),
      mrp: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mrp'],
      ),
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      displayOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}display_order'],
      )!,
      bulkItem: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bulk_item'],
      )!,
    );
  }

  @override
  $PresentationsTable createAlias(String alias) {
    return $PresentationsTable(attachedDatabase, alias);
  }
}

class PresentationEntity extends DataClass
    implements Insertable<PresentationEntity> {
  final int id;
  final int productId;
  final int productTypeId;
  final int contentTypeId;
  final String? size;
  final double? mrp;
  final String? imageUrl;
  final int displayOrder;
  final int bulkItem;
  const PresentationEntity({
    required this.id,
    required this.productId,
    required this.productTypeId,
    required this.contentTypeId,
    this.size,
    this.mrp,
    this.imageUrl,
    required this.displayOrder,
    required this.bulkItem,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['product_type_id'] = Variable<int>(productTypeId);
    map['content_type_id'] = Variable<int>(contentTypeId);
    if (!nullToAbsent || size != null) {
      map['size'] = Variable<String>(size);
    }
    if (!nullToAbsent || mrp != null) {
      map['mrp'] = Variable<double>(mrp);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['display_order'] = Variable<int>(displayOrder);
    map['bulk_item'] = Variable<int>(bulkItem);
    return map;
  }

  PresentationsCompanion toCompanion(bool nullToAbsent) {
    return PresentationsCompanion(
      id: Value(id),
      productId: Value(productId),
      productTypeId: Value(productTypeId),
      contentTypeId: Value(contentTypeId),
      size: size == null && nullToAbsent ? const Value.absent() : Value(size),
      mrp: mrp == null && nullToAbsent ? const Value.absent() : Value(mrp),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      displayOrder: Value(displayOrder),
      bulkItem: Value(bulkItem),
    );
  }

  factory PresentationEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PresentationEntity(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      productTypeId: serializer.fromJson<int>(json['productTypeId']),
      contentTypeId: serializer.fromJson<int>(json['contentTypeId']),
      size: serializer.fromJson<String?>(json['size']),
      mrp: serializer.fromJson<double?>(json['mrp']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
      bulkItem: serializer.fromJson<int>(json['bulkItem']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'productTypeId': serializer.toJson<int>(productTypeId),
      'contentTypeId': serializer.toJson<int>(contentTypeId),
      'size': serializer.toJson<String?>(size),
      'mrp': serializer.toJson<double?>(mrp),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'displayOrder': serializer.toJson<int>(displayOrder),
      'bulkItem': serializer.toJson<int>(bulkItem),
    };
  }

  PresentationEntity copyWith({
    int? id,
    int? productId,
    int? productTypeId,
    int? contentTypeId,
    Value<String?> size = const Value.absent(),
    Value<double?> mrp = const Value.absent(),
    Value<String?> imageUrl = const Value.absent(),
    int? displayOrder,
    int? bulkItem,
  }) => PresentationEntity(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    productTypeId: productTypeId ?? this.productTypeId,
    contentTypeId: contentTypeId ?? this.contentTypeId,
    size: size.present ? size.value : this.size,
    mrp: mrp.present ? mrp.value : this.mrp,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    displayOrder: displayOrder ?? this.displayOrder,
    bulkItem: bulkItem ?? this.bulkItem,
  );
  PresentationEntity copyWithCompanion(PresentationsCompanion data) {
    return PresentationEntity(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      productTypeId: data.productTypeId.present
          ? data.productTypeId.value
          : this.productTypeId,
      contentTypeId: data.contentTypeId.present
          ? data.contentTypeId.value
          : this.contentTypeId,
      size: data.size.present ? data.size.value : this.size,
      mrp: data.mrp.present ? data.mrp.value : this.mrp,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
      bulkItem: data.bulkItem.present ? data.bulkItem.value : this.bulkItem,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PresentationEntity(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('productTypeId: $productTypeId, ')
          ..write('contentTypeId: $contentTypeId, ')
          ..write('size: $size, ')
          ..write('mrp: $mrp, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('bulkItem: $bulkItem')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    productTypeId,
    contentTypeId,
    size,
    mrp,
    imageUrl,
    displayOrder,
    bulkItem,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PresentationEntity &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.productTypeId == this.productTypeId &&
          other.contentTypeId == this.contentTypeId &&
          other.size == this.size &&
          other.mrp == this.mrp &&
          other.imageUrl == this.imageUrl &&
          other.displayOrder == this.displayOrder &&
          other.bulkItem == this.bulkItem);
}

class PresentationsCompanion extends UpdateCompanion<PresentationEntity> {
  final Value<int> id;
  final Value<int> productId;
  final Value<int> productTypeId;
  final Value<int> contentTypeId;
  final Value<String?> size;
  final Value<double?> mrp;
  final Value<String?> imageUrl;
  final Value<int> displayOrder;
  final Value<int> bulkItem;
  const PresentationsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.productTypeId = const Value.absent(),
    this.contentTypeId = const Value.absent(),
    this.size = const Value.absent(),
    this.mrp = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.bulkItem = const Value.absent(),
  });
  PresentationsCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required int productTypeId,
    required int contentTypeId,
    this.size = const Value.absent(),
    this.mrp = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.bulkItem = const Value.absent(),
  }) : productId = Value(productId),
       productTypeId = Value(productTypeId),
       contentTypeId = Value(contentTypeId);
  static Insertable<PresentationEntity> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<int>? productTypeId,
    Expression<int>? contentTypeId,
    Expression<String>? size,
    Expression<double>? mrp,
    Expression<String>? imageUrl,
    Expression<int>? displayOrder,
    Expression<int>? bulkItem,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (productTypeId != null) 'product_type_id': productTypeId,
      if (contentTypeId != null) 'content_type_id': contentTypeId,
      if (size != null) 'size': size,
      if (mrp != null) 'mrp': mrp,
      if (imageUrl != null) 'image_url': imageUrl,
      if (displayOrder != null) 'display_order': displayOrder,
      if (bulkItem != null) 'bulk_item': bulkItem,
    });
  }

  PresentationsCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<int>? productTypeId,
    Value<int>? contentTypeId,
    Value<String?>? size,
    Value<double?>? mrp,
    Value<String?>? imageUrl,
    Value<int>? displayOrder,
    Value<int>? bulkItem,
  }) {
    return PresentationsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productTypeId: productTypeId ?? this.productTypeId,
      contentTypeId: contentTypeId ?? this.contentTypeId,
      size: size ?? this.size,
      mrp: mrp ?? this.mrp,
      imageUrl: imageUrl ?? this.imageUrl,
      displayOrder: displayOrder ?? this.displayOrder,
      bulkItem: bulkItem ?? this.bulkItem,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (productTypeId.present) {
      map['product_type_id'] = Variable<int>(productTypeId.value);
    }
    if (contentTypeId.present) {
      map['content_type_id'] = Variable<int>(contentTypeId.value);
    }
    if (size.present) {
      map['size'] = Variable<String>(size.value);
    }
    if (mrp.present) {
      map['mrp'] = Variable<double>(mrp.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    if (bulkItem.present) {
      map['bulk_item'] = Variable<int>(bulkItem.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PresentationsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('productTypeId: $productTypeId, ')
          ..write('contentTypeId: $contentTypeId, ')
          ..write('size: $size, ')
          ..write('mrp: $mrp, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('bulkItem: $bulkItem')
          ..write(')'))
        .toString();
  }
}

abstract class _$ProductsDb extends GeneratedDatabase {
  _$ProductsDb(QueryExecutor e) : super(e);
  $ProductsDbManager get managers => $ProductsDbManager(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $TargetGroupsTable targetGroups = $TargetGroupsTable(this);
  late final $ContentTypesTable contentTypes = $ContentTypesTable(this);
  late final $ProductTypesTable productTypes = $ProductTypesTable(this);
  late final $SpeciesTable species = $SpeciesTable(this);
  late final $DosageUnitsTable dosageUnits = $DosageUnitsTable(this);
  late final $DosageBasesTable dosageBases = $DosageBasesTable(this);
  late final $ManufacturersTable manufacturers = $ManufacturersTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $ProductTargetGroupsTable productTargetGroups =
      $ProductTargetGroupsTable(this);
  late final $CompositionsTable compositions = $CompositionsTable(this);
  late final $IndicationsTable indications = $IndicationsTable(this);
  late final $DirectionsTable directions = $DirectionsTable(this);
  late final $PrecautionsTable precautions = $PrecautionsTable(this);
  late final $PresentationsTable presentations = $PresentationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categories,
    targetGroups,
    contentTypes,
    productTypes,
    species,
    dosageUnits,
    dosageBases,
    manufacturers,
    products,
    productTargetGroups,
    compositions,
    indications,
    directions,
    precautions,
    presentations,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('product_target_groups', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('compositions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('indications', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('directions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('precautions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'products',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('presentations', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      required String nameEn,
      required String nameBn,
      Value<String?> iconName,
      Value<String?> slug,
    });
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({
      Value<int> id,
      Value<String> nameEn,
      Value<String> nameBn,
      Value<String?> iconName,
      Value<String?> slug,
    });

final class $$CategoriesTableReferences
    extends BaseReferences<_$ProductsDb, $CategoriesTable, CategoryEntity> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProductsTable, List<ProductEntity>>
  _productsRefsTable(_$ProductsDb db) => MultiTypedResultKey.fromTable(
    db.products,
    aliasName: 'categories__id__products__category_id',
  );

  $$ProductsTableProcessedTableManager get productsRefs {
    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_productsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$ProductsDb, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> productsRefs(
    Expression<bool> Function($$ProductsTableFilterComposer f) f,
  ) {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$ProductsDb, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$ProductsDb, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameBn =>
      $composableBuilder(column: $table.nameBn, builder: (column) => column);

  GeneratedColumn<String> get iconName =>
      $composableBuilder(column: $table.iconName, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  Expression<T> productsRefs<T extends Object>(
    Expression<T> Function($$ProductsTableAnnotationComposer a) f,
  ) {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$ProductsDb,
          $CategoriesTable,
          CategoryEntity,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (CategoryEntity, $$CategoriesTableReferences),
          CategoryEntity,
          PrefetchHooks Function({bool productsRefs})
        > {
  $$CategoriesTableTableManager(_$ProductsDb db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> nameBn = const Value.absent(),
                Value<String?> iconName = const Value.absent(),
                Value<String?> slug = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                nameEn: nameEn,
                nameBn: nameBn,
                iconName: iconName,
                slug: slug,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nameEn,
                required String nameBn,
                Value<String?> iconName = const Value.absent(),
                Value<String?> slug = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                nameEn: nameEn,
                nameBn: nameBn,
                iconName: iconName,
                slug: slug,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (productsRefs) db.products],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productsRefs)
                    await $_getPrefetchedData<
                      CategoryEntity,
                      $CategoriesTable,
                      ProductEntity
                    >(
                      currentTable: table,
                      referencedTable: $$CategoriesTableReferences
                          ._productsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoriesTableReferences(
                            db,
                            table,
                            p0,
                          ).productsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.categoryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$ProductsDb,
      $CategoriesTable,
      CategoryEntity,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (CategoryEntity, $$CategoriesTableReferences),
      CategoryEntity,
      PrefetchHooks Function({bool productsRefs})
    >;
typedef $$TargetGroupsTableCreateCompanionBuilder =
    TargetGroupsCompanion Function({
      Value<int> id,
      required String nameEn,
      required String nameBn,
      Value<String?> iconName,
    });
typedef $$TargetGroupsTableUpdateCompanionBuilder =
    TargetGroupsCompanion Function({
      Value<int> id,
      Value<String> nameEn,
      Value<String> nameBn,
      Value<String?> iconName,
    });

final class $$TargetGroupsTableReferences
    extends
        BaseReferences<_$ProductsDb, $TargetGroupsTable, TargetGroupEntity> {
  $$TargetGroupsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SpeciesTable, List<SpeciesEntity>>
  _speciesRefsTable(_$ProductsDb db) => MultiTypedResultKey.fromTable(
    db.species,
    aliasName: 'target_groups__id__species__target_group_id',
  );

  $$SpeciesTableProcessedTableManager get speciesRefs {
    final manager = $$SpeciesTableTableManager(
      $_db,
      $_db.species,
    ).filter((f) => f.targetGroupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_speciesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ProductTargetGroupsTable,
    List<ProductTargetGroup>
  >
  _productTargetGroupsRefsTable(_$ProductsDb db) =>
      MultiTypedResultKey.fromTable(
        db.productTargetGroups,
        aliasName: 'target_groups__id__product_target_groups__target_group_id',
      );

  $$ProductTargetGroupsTableProcessedTableManager get productTargetGroupsRefs {
    final manager = $$ProductTargetGroupsTableTableManager(
      $_db,
      $_db.productTargetGroups,
    ).filter((f) => f.targetGroupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _productTargetGroupsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TargetGroupsTableFilterComposer
    extends Composer<_$ProductsDb, $TargetGroupsTable> {
  $$TargetGroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> speciesRefs(
    Expression<bool> Function($$SpeciesTableFilterComposer f) f,
  ) {
    final $$SpeciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.species,
      getReferencedColumn: (t) => t.targetGroupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableFilterComposer(
            $db: $db,
            $table: $db.species,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> productTargetGroupsRefs(
    Expression<bool> Function($$ProductTargetGroupsTableFilterComposer f) f,
  ) {
    final $$ProductTargetGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productTargetGroups,
      getReferencedColumn: (t) => t.targetGroupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductTargetGroupsTableFilterComposer(
            $db: $db,
            $table: $db.productTargetGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TargetGroupsTableOrderingComposer
    extends Composer<_$ProductsDb, $TargetGroupsTable> {
  $$TargetGroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TargetGroupsTableAnnotationComposer
    extends Composer<_$ProductsDb, $TargetGroupsTable> {
  $$TargetGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameBn =>
      $composableBuilder(column: $table.nameBn, builder: (column) => column);

  GeneratedColumn<String> get iconName =>
      $composableBuilder(column: $table.iconName, builder: (column) => column);

  Expression<T> speciesRefs<T extends Object>(
    Expression<T> Function($$SpeciesTableAnnotationComposer a) f,
  ) {
    final $$SpeciesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.species,
      getReferencedColumn: (t) => t.targetGroupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableAnnotationComposer(
            $db: $db,
            $table: $db.species,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> productTargetGroupsRefs<T extends Object>(
    Expression<T> Function($$ProductTargetGroupsTableAnnotationComposer a) f,
  ) {
    final $$ProductTargetGroupsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.productTargetGroups,
          getReferencedColumn: (t) => t.targetGroupId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProductTargetGroupsTableAnnotationComposer(
                $db: $db,
                $table: $db.productTargetGroups,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$TargetGroupsTableTableManager
    extends
        RootTableManager<
          _$ProductsDb,
          $TargetGroupsTable,
          TargetGroupEntity,
          $$TargetGroupsTableFilterComposer,
          $$TargetGroupsTableOrderingComposer,
          $$TargetGroupsTableAnnotationComposer,
          $$TargetGroupsTableCreateCompanionBuilder,
          $$TargetGroupsTableUpdateCompanionBuilder,
          (TargetGroupEntity, $$TargetGroupsTableReferences),
          TargetGroupEntity,
          PrefetchHooks Function({
            bool speciesRefs,
            bool productTargetGroupsRefs,
          })
        > {
  $$TargetGroupsTableTableManager(_$ProductsDb db, $TargetGroupsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TargetGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TargetGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TargetGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> nameBn = const Value.absent(),
                Value<String?> iconName = const Value.absent(),
              }) => TargetGroupsCompanion(
                id: id,
                nameEn: nameEn,
                nameBn: nameBn,
                iconName: iconName,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nameEn,
                required String nameBn,
                Value<String?> iconName = const Value.absent(),
              }) => TargetGroupsCompanion.insert(
                id: id,
                nameEn: nameEn,
                nameBn: nameBn,
                iconName: iconName,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TargetGroupsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({speciesRefs = false, productTargetGroupsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (speciesRefs) db.species,
                    if (productTargetGroupsRefs) db.productTargetGroups,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (speciesRefs)
                        await $_getPrefetchedData<
                          TargetGroupEntity,
                          $TargetGroupsTable,
                          SpeciesEntity
                        >(
                          currentTable: table,
                          referencedTable: $$TargetGroupsTableReferences
                              ._speciesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TargetGroupsTableReferences(
                                db,
                                table,
                                p0,
                              ).speciesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.targetGroupId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (productTargetGroupsRefs)
                        await $_getPrefetchedData<
                          TargetGroupEntity,
                          $TargetGroupsTable,
                          ProductTargetGroup
                        >(
                          currentTable: table,
                          referencedTable: $$TargetGroupsTableReferences
                              ._productTargetGroupsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TargetGroupsTableReferences(
                                db,
                                table,
                                p0,
                              ).productTargetGroupsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.targetGroupId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TargetGroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$ProductsDb,
      $TargetGroupsTable,
      TargetGroupEntity,
      $$TargetGroupsTableFilterComposer,
      $$TargetGroupsTableOrderingComposer,
      $$TargetGroupsTableAnnotationComposer,
      $$TargetGroupsTableCreateCompanionBuilder,
      $$TargetGroupsTableUpdateCompanionBuilder,
      (TargetGroupEntity, $$TargetGroupsTableReferences),
      TargetGroupEntity,
      PrefetchHooks Function({bool speciesRefs, bool productTargetGroupsRefs})
    >;
typedef $$ContentTypesTableCreateCompanionBuilder =
    ContentTypesCompanion Function({
      Value<int> id,
      required String nameEn,
      required String nameBn,
    });
typedef $$ContentTypesTableUpdateCompanionBuilder =
    ContentTypesCompanion Function({
      Value<int> id,
      Value<String> nameEn,
      Value<String> nameBn,
    });

final class $$ContentTypesTableReferences
    extends
        BaseReferences<_$ProductsDb, $ContentTypesTable, ContentTypeEntity> {
  $$ContentTypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DirectionsTable, List<DirectionEntity>>
  _directionsRefsTable(_$ProductsDb db) => MultiTypedResultKey.fromTable(
    db.directions,
    aliasName: 'content_types__id__directions__content_type_id',
  );

  $$DirectionsTableProcessedTableManager get directionsRefs {
    final manager = $$DirectionsTableTableManager(
      $_db,
      $_db.directions,
    ).filter((f) => f.contentTypeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_directionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PresentationsTable, List<PresentationEntity>>
  _presentationsRefsTable(_$ProductsDb db) => MultiTypedResultKey.fromTable(
    db.presentations,
    aliasName: 'content_types__id__presentations__content_type_id',
  );

  $$PresentationsTableProcessedTableManager get presentationsRefs {
    final manager = $$PresentationsTableTableManager(
      $_db,
      $_db.presentations,
    ).filter((f) => f.contentTypeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_presentationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ContentTypesTableFilterComposer
    extends Composer<_$ProductsDb, $ContentTypesTable> {
  $$ContentTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> directionsRefs(
    Expression<bool> Function($$DirectionsTableFilterComposer f) f,
  ) {
    final $$DirectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.directions,
      getReferencedColumn: (t) => t.contentTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DirectionsTableFilterComposer(
            $db: $db,
            $table: $db.directions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> presentationsRefs(
    Expression<bool> Function($$PresentationsTableFilterComposer f) f,
  ) {
    final $$PresentationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.presentations,
      getReferencedColumn: (t) => t.contentTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PresentationsTableFilterComposer(
            $db: $db,
            $table: $db.presentations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ContentTypesTableOrderingComposer
    extends Composer<_$ProductsDb, $ContentTypesTable> {
  $$ContentTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ContentTypesTableAnnotationComposer
    extends Composer<_$ProductsDb, $ContentTypesTable> {
  $$ContentTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameBn =>
      $composableBuilder(column: $table.nameBn, builder: (column) => column);

  Expression<T> directionsRefs<T extends Object>(
    Expression<T> Function($$DirectionsTableAnnotationComposer a) f,
  ) {
    final $$DirectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.directions,
      getReferencedColumn: (t) => t.contentTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DirectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.directions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> presentationsRefs<T extends Object>(
    Expression<T> Function($$PresentationsTableAnnotationComposer a) f,
  ) {
    final $$PresentationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.presentations,
      getReferencedColumn: (t) => t.contentTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PresentationsTableAnnotationComposer(
            $db: $db,
            $table: $db.presentations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ContentTypesTableTableManager
    extends
        RootTableManager<
          _$ProductsDb,
          $ContentTypesTable,
          ContentTypeEntity,
          $$ContentTypesTableFilterComposer,
          $$ContentTypesTableOrderingComposer,
          $$ContentTypesTableAnnotationComposer,
          $$ContentTypesTableCreateCompanionBuilder,
          $$ContentTypesTableUpdateCompanionBuilder,
          (ContentTypeEntity, $$ContentTypesTableReferences),
          ContentTypeEntity,
          PrefetchHooks Function({bool directionsRefs, bool presentationsRefs})
        > {
  $$ContentTypesTableTableManager(_$ProductsDb db, $ContentTypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContentTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContentTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContentTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> nameBn = const Value.absent(),
              }) =>
                  ContentTypesCompanion(id: id, nameEn: nameEn, nameBn: nameBn),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nameEn,
                required String nameBn,
              }) => ContentTypesCompanion.insert(
                id: id,
                nameEn: nameEn,
                nameBn: nameBn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ContentTypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({directionsRefs = false, presentationsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (directionsRefs) db.directions,
                    if (presentationsRefs) db.presentations,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (directionsRefs)
                        await $_getPrefetchedData<
                          ContentTypeEntity,
                          $ContentTypesTable,
                          DirectionEntity
                        >(
                          currentTable: table,
                          referencedTable: $$ContentTypesTableReferences
                              ._directionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ContentTypesTableReferences(
                                db,
                                table,
                                p0,
                              ).directionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.contentTypeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (presentationsRefs)
                        await $_getPrefetchedData<
                          ContentTypeEntity,
                          $ContentTypesTable,
                          PresentationEntity
                        >(
                          currentTable: table,
                          referencedTable: $$ContentTypesTableReferences
                              ._presentationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ContentTypesTableReferences(
                                db,
                                table,
                                p0,
                              ).presentationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.contentTypeId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ContentTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$ProductsDb,
      $ContentTypesTable,
      ContentTypeEntity,
      $$ContentTypesTableFilterComposer,
      $$ContentTypesTableOrderingComposer,
      $$ContentTypesTableAnnotationComposer,
      $$ContentTypesTableCreateCompanionBuilder,
      $$ContentTypesTableUpdateCompanionBuilder,
      (ContentTypeEntity, $$ContentTypesTableReferences),
      ContentTypeEntity,
      PrefetchHooks Function({bool directionsRefs, bool presentationsRefs})
    >;
typedef $$ProductTypesTableCreateCompanionBuilder =
    ProductTypesCompanion Function({
      Value<int> id,
      required String nameEn,
      required String nameBn,
      Value<String?> iconName,
    });
typedef $$ProductTypesTableUpdateCompanionBuilder =
    ProductTypesCompanion Function({
      Value<int> id,
      Value<String> nameEn,
      Value<String> nameBn,
      Value<String?> iconName,
    });

final class $$ProductTypesTableReferences
    extends
        BaseReferences<_$ProductsDb, $ProductTypesTable, ProductTypeEntity> {
  $$ProductTypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PresentationsTable, List<PresentationEntity>>
  _presentationsRefsTable(_$ProductsDb db) => MultiTypedResultKey.fromTable(
    db.presentations,
    aliasName: 'product_types__id__presentations__product_type_id',
  );

  $$PresentationsTableProcessedTableManager get presentationsRefs {
    final manager = $$PresentationsTableTableManager(
      $_db,
      $_db.presentations,
    ).filter((f) => f.productTypeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_presentationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductTypesTableFilterComposer
    extends Composer<_$ProductsDb, $ProductTypesTable> {
  $$ProductTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> presentationsRefs(
    Expression<bool> Function($$PresentationsTableFilterComposer f) f,
  ) {
    final $$PresentationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.presentations,
      getReferencedColumn: (t) => t.productTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PresentationsTableFilterComposer(
            $db: $db,
            $table: $db.presentations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductTypesTableOrderingComposer
    extends Composer<_$ProductsDb, $ProductTypesTable> {
  $$ProductTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductTypesTableAnnotationComposer
    extends Composer<_$ProductsDb, $ProductTypesTable> {
  $$ProductTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameBn =>
      $composableBuilder(column: $table.nameBn, builder: (column) => column);

  GeneratedColumn<String> get iconName =>
      $composableBuilder(column: $table.iconName, builder: (column) => column);

  Expression<T> presentationsRefs<T extends Object>(
    Expression<T> Function($$PresentationsTableAnnotationComposer a) f,
  ) {
    final $$PresentationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.presentations,
      getReferencedColumn: (t) => t.productTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PresentationsTableAnnotationComposer(
            $db: $db,
            $table: $db.presentations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductTypesTableTableManager
    extends
        RootTableManager<
          _$ProductsDb,
          $ProductTypesTable,
          ProductTypeEntity,
          $$ProductTypesTableFilterComposer,
          $$ProductTypesTableOrderingComposer,
          $$ProductTypesTableAnnotationComposer,
          $$ProductTypesTableCreateCompanionBuilder,
          $$ProductTypesTableUpdateCompanionBuilder,
          (ProductTypeEntity, $$ProductTypesTableReferences),
          ProductTypeEntity,
          PrefetchHooks Function({bool presentationsRefs})
        > {
  $$ProductTypesTableTableManager(_$ProductsDb db, $ProductTypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> nameBn = const Value.absent(),
                Value<String?> iconName = const Value.absent(),
              }) => ProductTypesCompanion(
                id: id,
                nameEn: nameEn,
                nameBn: nameBn,
                iconName: iconName,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nameEn,
                required String nameBn,
                Value<String?> iconName = const Value.absent(),
              }) => ProductTypesCompanion.insert(
                id: id,
                nameEn: nameEn,
                nameBn: nameBn,
                iconName: iconName,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductTypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({presentationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (presentationsRefs) db.presentations,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (presentationsRefs)
                    await $_getPrefetchedData<
                      ProductTypeEntity,
                      $ProductTypesTable,
                      PresentationEntity
                    >(
                      currentTable: table,
                      referencedTable: $$ProductTypesTableReferences
                          ._presentationsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ProductTypesTableReferences(
                            db,
                            table,
                            p0,
                          ).presentationsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.productTypeId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ProductTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$ProductsDb,
      $ProductTypesTable,
      ProductTypeEntity,
      $$ProductTypesTableFilterComposer,
      $$ProductTypesTableOrderingComposer,
      $$ProductTypesTableAnnotationComposer,
      $$ProductTypesTableCreateCompanionBuilder,
      $$ProductTypesTableUpdateCompanionBuilder,
      (ProductTypeEntity, $$ProductTypesTableReferences),
      ProductTypeEntity,
      PrefetchHooks Function({bool presentationsRefs})
    >;
typedef $$SpeciesTableCreateCompanionBuilder =
    SpeciesCompanion Function({
      Value<int> id,
      required int targetGroupId,
      required String nameEn,
      required String nameBn,
    });
typedef $$SpeciesTableUpdateCompanionBuilder =
    SpeciesCompanion Function({
      Value<int> id,
      Value<int> targetGroupId,
      Value<String> nameEn,
      Value<String> nameBn,
    });

final class $$SpeciesTableReferences
    extends BaseReferences<_$ProductsDb, $SpeciesTable, SpeciesEntity> {
  $$SpeciesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TargetGroupsTable _targetGroupIdTable(_$ProductsDb db) => db
      .targetGroups
      .createAlias('species__target_group_id__target_groups__id');

  $$TargetGroupsTableProcessedTableManager get targetGroupId {
    final $_column = $_itemColumn<int>('target_group_id')!;

    final manager = $$TargetGroupsTableTableManager(
      $_db,
      $_db.targetGroups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_targetGroupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DirectionsTable, List<DirectionEntity>>
  _directionsRefsTable(_$ProductsDb db) => MultiTypedResultKey.fromTable(
    db.directions,
    aliasName: 'species__id__directions__species_id',
  );

  $$DirectionsTableProcessedTableManager get directionsRefs {
    final manager = $$DirectionsTableTableManager(
      $_db,
      $_db.directions,
    ).filter((f) => f.speciesId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_directionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SpeciesTableFilterComposer
    extends Composer<_$ProductsDb, $SpeciesTable> {
  $$SpeciesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnFilters(column),
  );

  $$TargetGroupsTableFilterComposer get targetGroupId {
    final $$TargetGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetGroupId,
      referencedTable: $db.targetGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TargetGroupsTableFilterComposer(
            $db: $db,
            $table: $db.targetGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> directionsRefs(
    Expression<bool> Function($$DirectionsTableFilterComposer f) f,
  ) {
    final $$DirectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.directions,
      getReferencedColumn: (t) => t.speciesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DirectionsTableFilterComposer(
            $db: $db,
            $table: $db.directions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SpeciesTableOrderingComposer
    extends Composer<_$ProductsDb, $SpeciesTable> {
  $$SpeciesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnOrderings(column),
  );

  $$TargetGroupsTableOrderingComposer get targetGroupId {
    final $$TargetGroupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetGroupId,
      referencedTable: $db.targetGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TargetGroupsTableOrderingComposer(
            $db: $db,
            $table: $db.targetGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SpeciesTableAnnotationComposer
    extends Composer<_$ProductsDb, $SpeciesTable> {
  $$SpeciesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameBn =>
      $composableBuilder(column: $table.nameBn, builder: (column) => column);

  $$TargetGroupsTableAnnotationComposer get targetGroupId {
    final $$TargetGroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetGroupId,
      referencedTable: $db.targetGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TargetGroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.targetGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> directionsRefs<T extends Object>(
    Expression<T> Function($$DirectionsTableAnnotationComposer a) f,
  ) {
    final $$DirectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.directions,
      getReferencedColumn: (t) => t.speciesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DirectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.directions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SpeciesTableTableManager
    extends
        RootTableManager<
          _$ProductsDb,
          $SpeciesTable,
          SpeciesEntity,
          $$SpeciesTableFilterComposer,
          $$SpeciesTableOrderingComposer,
          $$SpeciesTableAnnotationComposer,
          $$SpeciesTableCreateCompanionBuilder,
          $$SpeciesTableUpdateCompanionBuilder,
          (SpeciesEntity, $$SpeciesTableReferences),
          SpeciesEntity,
          PrefetchHooks Function({bool targetGroupId, bool directionsRefs})
        > {
  $$SpeciesTableTableManager(_$ProductsDb db, $SpeciesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpeciesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SpeciesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SpeciesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> targetGroupId = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> nameBn = const Value.absent(),
              }) => SpeciesCompanion(
                id: id,
                targetGroupId: targetGroupId,
                nameEn: nameEn,
                nameBn: nameBn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int targetGroupId,
                required String nameEn,
                required String nameBn,
              }) => SpeciesCompanion.insert(
                id: id,
                targetGroupId: targetGroupId,
                nameEn: nameEn,
                nameBn: nameBn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SpeciesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({targetGroupId = false, directionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (directionsRefs) db.directions],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (targetGroupId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.targetGroupId,
                                    referencedTable: $$SpeciesTableReferences
                                        ._targetGroupIdTable(db),
                                    referencedColumn: $$SpeciesTableReferences
                                        ._targetGroupIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (directionsRefs)
                        await $_getPrefetchedData<
                          SpeciesEntity,
                          $SpeciesTable,
                          DirectionEntity
                        >(
                          currentTable: table,
                          referencedTable: $$SpeciesTableReferences
                              ._directionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SpeciesTableReferences(
                                db,
                                table,
                                p0,
                              ).directionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.speciesId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SpeciesTableProcessedTableManager =
    ProcessedTableManager<
      _$ProductsDb,
      $SpeciesTable,
      SpeciesEntity,
      $$SpeciesTableFilterComposer,
      $$SpeciesTableOrderingComposer,
      $$SpeciesTableAnnotationComposer,
      $$SpeciesTableCreateCompanionBuilder,
      $$SpeciesTableUpdateCompanionBuilder,
      (SpeciesEntity, $$SpeciesTableReferences),
      SpeciesEntity,
      PrefetchHooks Function({bool targetGroupId, bool directionsRefs})
    >;
typedef $$DosageUnitsTableCreateCompanionBuilder =
    DosageUnitsCompanion Function({
      Value<int> id,
      required String nameEn,
      required String nameBn,
    });
typedef $$DosageUnitsTableUpdateCompanionBuilder =
    DosageUnitsCompanion Function({
      Value<int> id,
      Value<String> nameEn,
      Value<String> nameBn,
    });

final class $$DosageUnitsTableReferences
    extends BaseReferences<_$ProductsDb, $DosageUnitsTable, DosageUnitEntity> {
  $$DosageUnitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DirectionsTable, List<DirectionEntity>>
  _directionsRefsTable(_$ProductsDb db) => MultiTypedResultKey.fromTable(
    db.directions,
    aliasName: 'dosage_units__id__directions__dose_unit_id',
  );

  $$DirectionsTableProcessedTableManager get directionsRefs {
    final manager = $$DirectionsTableTableManager(
      $_db,
      $_db.directions,
    ).filter((f) => f.doseUnitId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_directionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DosageUnitsTableFilterComposer
    extends Composer<_$ProductsDb, $DosageUnitsTable> {
  $$DosageUnitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> directionsRefs(
    Expression<bool> Function($$DirectionsTableFilterComposer f) f,
  ) {
    final $$DirectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.directions,
      getReferencedColumn: (t) => t.doseUnitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DirectionsTableFilterComposer(
            $db: $db,
            $table: $db.directions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DosageUnitsTableOrderingComposer
    extends Composer<_$ProductsDb, $DosageUnitsTable> {
  $$DosageUnitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DosageUnitsTableAnnotationComposer
    extends Composer<_$ProductsDb, $DosageUnitsTable> {
  $$DosageUnitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameBn =>
      $composableBuilder(column: $table.nameBn, builder: (column) => column);

  Expression<T> directionsRefs<T extends Object>(
    Expression<T> Function($$DirectionsTableAnnotationComposer a) f,
  ) {
    final $$DirectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.directions,
      getReferencedColumn: (t) => t.doseUnitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DirectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.directions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DosageUnitsTableTableManager
    extends
        RootTableManager<
          _$ProductsDb,
          $DosageUnitsTable,
          DosageUnitEntity,
          $$DosageUnitsTableFilterComposer,
          $$DosageUnitsTableOrderingComposer,
          $$DosageUnitsTableAnnotationComposer,
          $$DosageUnitsTableCreateCompanionBuilder,
          $$DosageUnitsTableUpdateCompanionBuilder,
          (DosageUnitEntity, $$DosageUnitsTableReferences),
          DosageUnitEntity,
          PrefetchHooks Function({bool directionsRefs})
        > {
  $$DosageUnitsTableTableManager(_$ProductsDb db, $DosageUnitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DosageUnitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DosageUnitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DosageUnitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> nameBn = const Value.absent(),
              }) =>
                  DosageUnitsCompanion(id: id, nameEn: nameEn, nameBn: nameBn),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nameEn,
                required String nameBn,
              }) => DosageUnitsCompanion.insert(
                id: id,
                nameEn: nameEn,
                nameBn: nameBn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DosageUnitsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({directionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (directionsRefs) db.directions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (directionsRefs)
                    await $_getPrefetchedData<
                      DosageUnitEntity,
                      $DosageUnitsTable,
                      DirectionEntity
                    >(
                      currentTable: table,
                      referencedTable: $$DosageUnitsTableReferences
                          ._directionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$DosageUnitsTableReferences(
                            db,
                            table,
                            p0,
                          ).directionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.doseUnitId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DosageUnitsTableProcessedTableManager =
    ProcessedTableManager<
      _$ProductsDb,
      $DosageUnitsTable,
      DosageUnitEntity,
      $$DosageUnitsTableFilterComposer,
      $$DosageUnitsTableOrderingComposer,
      $$DosageUnitsTableAnnotationComposer,
      $$DosageUnitsTableCreateCompanionBuilder,
      $$DosageUnitsTableUpdateCompanionBuilder,
      (DosageUnitEntity, $$DosageUnitsTableReferences),
      DosageUnitEntity,
      PrefetchHooks Function({bool directionsRefs})
    >;
typedef $$DosageBasesTableCreateCompanionBuilder =
    DosageBasesCompanion Function({
      Value<int> id,
      required String nameEn,
      required String nameBn,
    });
typedef $$DosageBasesTableUpdateCompanionBuilder =
    DosageBasesCompanion Function({
      Value<int> id,
      Value<String> nameEn,
      Value<String> nameBn,
    });

final class $$DosageBasesTableReferences
    extends BaseReferences<_$ProductsDb, $DosageBasesTable, DosageBaseEntity> {
  $$DosageBasesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DirectionsTable, List<DirectionEntity>>
  _directionsRefsTable(_$ProductsDb db) => MultiTypedResultKey.fromTable(
    db.directions,
    aliasName: 'dosage_bases__id__directions__dose_basis_id',
  );

  $$DirectionsTableProcessedTableManager get directionsRefs {
    final manager = $$DirectionsTableTableManager(
      $_db,
      $_db.directions,
    ).filter((f) => f.doseBasisId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_directionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DosageBasesTableFilterComposer
    extends Composer<_$ProductsDb, $DosageBasesTable> {
  $$DosageBasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> directionsRefs(
    Expression<bool> Function($$DirectionsTableFilterComposer f) f,
  ) {
    final $$DirectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.directions,
      getReferencedColumn: (t) => t.doseBasisId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DirectionsTableFilterComposer(
            $db: $db,
            $table: $db.directions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DosageBasesTableOrderingComposer
    extends Composer<_$ProductsDb, $DosageBasesTable> {
  $$DosageBasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DosageBasesTableAnnotationComposer
    extends Composer<_$ProductsDb, $DosageBasesTable> {
  $$DosageBasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameBn =>
      $composableBuilder(column: $table.nameBn, builder: (column) => column);

  Expression<T> directionsRefs<T extends Object>(
    Expression<T> Function($$DirectionsTableAnnotationComposer a) f,
  ) {
    final $$DirectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.directions,
      getReferencedColumn: (t) => t.doseBasisId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DirectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.directions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DosageBasesTableTableManager
    extends
        RootTableManager<
          _$ProductsDb,
          $DosageBasesTable,
          DosageBaseEntity,
          $$DosageBasesTableFilterComposer,
          $$DosageBasesTableOrderingComposer,
          $$DosageBasesTableAnnotationComposer,
          $$DosageBasesTableCreateCompanionBuilder,
          $$DosageBasesTableUpdateCompanionBuilder,
          (DosageBaseEntity, $$DosageBasesTableReferences),
          DosageBaseEntity,
          PrefetchHooks Function({bool directionsRefs})
        > {
  $$DosageBasesTableTableManager(_$ProductsDb db, $DosageBasesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DosageBasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DosageBasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DosageBasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> nameBn = const Value.absent(),
              }) =>
                  DosageBasesCompanion(id: id, nameEn: nameEn, nameBn: nameBn),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nameEn,
                required String nameBn,
              }) => DosageBasesCompanion.insert(
                id: id,
                nameEn: nameEn,
                nameBn: nameBn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DosageBasesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({directionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (directionsRefs) db.directions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (directionsRefs)
                    await $_getPrefetchedData<
                      DosageBaseEntity,
                      $DosageBasesTable,
                      DirectionEntity
                    >(
                      currentTable: table,
                      referencedTable: $$DosageBasesTableReferences
                          ._directionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$DosageBasesTableReferences(
                            db,
                            table,
                            p0,
                          ).directionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.doseBasisId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DosageBasesTableProcessedTableManager =
    ProcessedTableManager<
      _$ProductsDb,
      $DosageBasesTable,
      DosageBaseEntity,
      $$DosageBasesTableFilterComposer,
      $$DosageBasesTableOrderingComposer,
      $$DosageBasesTableAnnotationComposer,
      $$DosageBasesTableCreateCompanionBuilder,
      $$DosageBasesTableUpdateCompanionBuilder,
      (DosageBaseEntity, $$DosageBasesTableReferences),
      DosageBaseEntity,
      PrefetchHooks Function({bool directionsRefs})
    >;
typedef $$ManufacturersTableCreateCompanionBuilder =
    ManufacturersCompanion Function({
      Value<int> id,
      required String nameEn,
      Value<String?> nameBn,
      Value<String?> logoUrl,
      Value<String?> addressEn,
      Value<String?> addressBn,
      Value<String?> email,
      Value<String?> website,
      Value<String?> mobile,
      Value<String?> countryOfOriginEn,
      Value<String?> countryOfOriginBn,
    });
typedef $$ManufacturersTableUpdateCompanionBuilder =
    ManufacturersCompanion Function({
      Value<int> id,
      Value<String> nameEn,
      Value<String?> nameBn,
      Value<String?> logoUrl,
      Value<String?> addressEn,
      Value<String?> addressBn,
      Value<String?> email,
      Value<String?> website,
      Value<String?> mobile,
      Value<String?> countryOfOriginEn,
      Value<String?> countryOfOriginBn,
    });

final class $$ManufacturersTableReferences
    extends
        BaseReferences<_$ProductsDb, $ManufacturersTable, ManufacturerEntity> {
  $$ManufacturersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ProductsTable, List<ProductEntity>>
  _productsRefsTable(_$ProductsDb db) => MultiTypedResultKey.fromTable(
    db.products,
    aliasName: 'manufacturers__id__products__manufacturer_id',
  );

  $$ProductsTableProcessedTableManager get productsRefs {
    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.manufacturerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_productsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ManufacturersTableFilterComposer
    extends Composer<_$ProductsDb, $ManufacturersTable> {
  $$ManufacturersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addressEn => $composableBuilder(
    column: $table.addressEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addressBn => $composableBuilder(
    column: $table.addressBn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get website => $composableBuilder(
    column: $table.website,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mobile => $composableBuilder(
    column: $table.mobile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get countryOfOriginEn => $composableBuilder(
    column: $table.countryOfOriginEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get countryOfOriginBn => $composableBuilder(
    column: $table.countryOfOriginBn,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> productsRefs(
    Expression<bool> Function($$ProductsTableFilterComposer f) f,
  ) {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.manufacturerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ManufacturersTableOrderingComposer
    extends Composer<_$ProductsDb, $ManufacturersTable> {
  $$ManufacturersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addressEn => $composableBuilder(
    column: $table.addressEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addressBn => $composableBuilder(
    column: $table.addressBn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get website => $composableBuilder(
    column: $table.website,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mobile => $composableBuilder(
    column: $table.mobile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get countryOfOriginEn => $composableBuilder(
    column: $table.countryOfOriginEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get countryOfOriginBn => $composableBuilder(
    column: $table.countryOfOriginBn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ManufacturersTableAnnotationComposer
    extends Composer<_$ProductsDb, $ManufacturersTable> {
  $$ManufacturersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameBn =>
      $composableBuilder(column: $table.nameBn, builder: (column) => column);

  GeneratedColumn<String> get logoUrl =>
      $composableBuilder(column: $table.logoUrl, builder: (column) => column);

  GeneratedColumn<String> get addressEn =>
      $composableBuilder(column: $table.addressEn, builder: (column) => column);

  GeneratedColumn<String> get addressBn =>
      $composableBuilder(column: $table.addressBn, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get website =>
      $composableBuilder(column: $table.website, builder: (column) => column);

  GeneratedColumn<String> get mobile =>
      $composableBuilder(column: $table.mobile, builder: (column) => column);

  GeneratedColumn<String> get countryOfOriginEn => $composableBuilder(
    column: $table.countryOfOriginEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get countryOfOriginBn => $composableBuilder(
    column: $table.countryOfOriginBn,
    builder: (column) => column,
  );

  Expression<T> productsRefs<T extends Object>(
    Expression<T> Function($$ProductsTableAnnotationComposer a) f,
  ) {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.manufacturerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ManufacturersTableTableManager
    extends
        RootTableManager<
          _$ProductsDb,
          $ManufacturersTable,
          ManufacturerEntity,
          $$ManufacturersTableFilterComposer,
          $$ManufacturersTableOrderingComposer,
          $$ManufacturersTableAnnotationComposer,
          $$ManufacturersTableCreateCompanionBuilder,
          $$ManufacturersTableUpdateCompanionBuilder,
          (ManufacturerEntity, $$ManufacturersTableReferences),
          ManufacturerEntity,
          PrefetchHooks Function({bool productsRefs})
        > {
  $$ManufacturersTableTableManager(_$ProductsDb db, $ManufacturersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ManufacturersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ManufacturersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ManufacturersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String?> nameBn = const Value.absent(),
                Value<String?> logoUrl = const Value.absent(),
                Value<String?> addressEn = const Value.absent(),
                Value<String?> addressBn = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> website = const Value.absent(),
                Value<String?> mobile = const Value.absent(),
                Value<String?> countryOfOriginEn = const Value.absent(),
                Value<String?> countryOfOriginBn = const Value.absent(),
              }) => ManufacturersCompanion(
                id: id,
                nameEn: nameEn,
                nameBn: nameBn,
                logoUrl: logoUrl,
                addressEn: addressEn,
                addressBn: addressBn,
                email: email,
                website: website,
                mobile: mobile,
                countryOfOriginEn: countryOfOriginEn,
                countryOfOriginBn: countryOfOriginBn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nameEn,
                Value<String?> nameBn = const Value.absent(),
                Value<String?> logoUrl = const Value.absent(),
                Value<String?> addressEn = const Value.absent(),
                Value<String?> addressBn = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> website = const Value.absent(),
                Value<String?> mobile = const Value.absent(),
                Value<String?> countryOfOriginEn = const Value.absent(),
                Value<String?> countryOfOriginBn = const Value.absent(),
              }) => ManufacturersCompanion.insert(
                id: id,
                nameEn: nameEn,
                nameBn: nameBn,
                logoUrl: logoUrl,
                addressEn: addressEn,
                addressBn: addressBn,
                email: email,
                website: website,
                mobile: mobile,
                countryOfOriginEn: countryOfOriginEn,
                countryOfOriginBn: countryOfOriginBn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ManufacturersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (productsRefs) db.products],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productsRefs)
                    await $_getPrefetchedData<
                      ManufacturerEntity,
                      $ManufacturersTable,
                      ProductEntity
                    >(
                      currentTable: table,
                      referencedTable: $$ManufacturersTableReferences
                          ._productsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ManufacturersTableReferences(
                            db,
                            table,
                            p0,
                          ).productsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.manufacturerId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ManufacturersTableProcessedTableManager =
    ProcessedTableManager<
      _$ProductsDb,
      $ManufacturersTable,
      ManufacturerEntity,
      $$ManufacturersTableFilterComposer,
      $$ManufacturersTableOrderingComposer,
      $$ManufacturersTableAnnotationComposer,
      $$ManufacturersTableCreateCompanionBuilder,
      $$ManufacturersTableUpdateCompanionBuilder,
      (ManufacturerEntity, $$ManufacturersTableReferences),
      ManufacturerEntity,
      PrefetchHooks Function({bool productsRefs})
    >;
typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      Value<int?> manufacturerId,
      required int categoryId,
      required String titleEn,
      Value<String?> titleBn,
      required String slug,
      Value<String?> mottoEn,
      Value<String?> mottoBn,
      Value<String?> shortDescriptionEn,
      Value<String?> shortDescriptionBn,
      Value<String?> imageUrl,
      Value<int> isActive,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> compositionBasisEn,
      Value<String?> compositionBasisBn,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<int> id,
      Value<int?> manufacturerId,
      Value<int> categoryId,
      Value<String> titleEn,
      Value<String?> titleBn,
      Value<String> slug,
      Value<String?> mottoEn,
      Value<String?> mottoBn,
      Value<String?> shortDescriptionEn,
      Value<String?> shortDescriptionBn,
      Value<String?> imageUrl,
      Value<int> isActive,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> compositionBasisEn,
      Value<String?> compositionBasisBn,
    });

final class $$ProductsTableReferences
    extends BaseReferences<_$ProductsDb, $ProductsTable, ProductEntity> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ManufacturersTable _manufacturerIdTable(_$ProductsDb db) => db
      .manufacturers
      .createAlias('products__manufacturer_id__manufacturers__id');

  $$ManufacturersTableProcessedTableManager? get manufacturerId {
    final $_column = $_itemColumn<int>('manufacturer_id');
    if ($_column == null) return null;
    final manager = $$ManufacturersTableTableManager(
      $_db,
      $_db.manufacturers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_manufacturerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CategoriesTable _categoryIdTable(_$ProductsDb db) =>
      db.categories.createAlias('products__category_id__categories__id');

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $ProductTargetGroupsTable,
    List<ProductTargetGroup>
  >
  _productTargetGroupsRefsTable(_$ProductsDb db) =>
      MultiTypedResultKey.fromTable(
        db.productTargetGroups,
        aliasName: 'products__id__product_target_groups__product_id',
      );

  $$ProductTargetGroupsTableProcessedTableManager get productTargetGroupsRefs {
    final manager = $$ProductTargetGroupsTableTableManager(
      $_db,
      $_db.productTargetGroups,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _productTargetGroupsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CompositionsTable, List<CompositionEntity>>
  _compositionsRefsTable(_$ProductsDb db) => MultiTypedResultKey.fromTable(
    db.compositions,
    aliasName: 'products__id__compositions__product_id',
  );

  $$CompositionsTableProcessedTableManager get compositionsRefs {
    final manager = $$CompositionsTableTableManager(
      $_db,
      $_db.compositions,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_compositionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$IndicationsTable, List<IndicationEntity>>
  _indicationsRefsTable(_$ProductsDb db) => MultiTypedResultKey.fromTable(
    db.indications,
    aliasName: 'products__id__indications__product_id',
  );

  $$IndicationsTableProcessedTableManager get indicationsRefs {
    final manager = $$IndicationsTableTableManager(
      $_db,
      $_db.indications,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_indicationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DirectionsTable, List<DirectionEntity>>
  _directionsRefsTable(_$ProductsDb db) => MultiTypedResultKey.fromTable(
    db.directions,
    aliasName: 'products__id__directions__product_id',
  );

  $$DirectionsTableProcessedTableManager get directionsRefs {
    final manager = $$DirectionsTableTableManager(
      $_db,
      $_db.directions,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_directionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PrecautionsTable, List<PrecautionEntity>>
  _precautionsRefsTable(_$ProductsDb db) => MultiTypedResultKey.fromTable(
    db.precautions,
    aliasName: 'products__id__precautions__product_id',
  );

  $$PrecautionsTableProcessedTableManager get precautionsRefs {
    final manager = $$PrecautionsTableTableManager(
      $_db,
      $_db.precautions,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_precautionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PresentationsTable, List<PresentationEntity>>
  _presentationsRefsTable(_$ProductsDb db) => MultiTypedResultKey.fromTable(
    db.presentations,
    aliasName: 'products__id__presentations__product_id',
  );

  $$PresentationsTableProcessedTableManager get presentationsRefs {
    final manager = $$PresentationsTableTableManager(
      $_db,
      $_db.presentations,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_presentationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductsTableFilterComposer
    extends Composer<_$ProductsDb, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleEn => $composableBuilder(
    column: $table.titleEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleBn => $composableBuilder(
    column: $table.titleBn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mottoEn => $composableBuilder(
    column: $table.mottoEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mottoBn => $composableBuilder(
    column: $table.mottoBn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shortDescriptionEn => $composableBuilder(
    column: $table.shortDescriptionEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shortDescriptionBn => $composableBuilder(
    column: $table.shortDescriptionBn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get compositionBasisEn => $composableBuilder(
    column: $table.compositionBasisEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get compositionBasisBn => $composableBuilder(
    column: $table.compositionBasisBn,
    builder: (column) => ColumnFilters(column),
  );

  $$ManufacturersTableFilterComposer get manufacturerId {
    final $$ManufacturersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.manufacturerId,
      referencedTable: $db.manufacturers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ManufacturersTableFilterComposer(
            $db: $db,
            $table: $db.manufacturers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> productTargetGroupsRefs(
    Expression<bool> Function($$ProductTargetGroupsTableFilterComposer f) f,
  ) {
    final $$ProductTargetGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productTargetGroups,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductTargetGroupsTableFilterComposer(
            $db: $db,
            $table: $db.productTargetGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> compositionsRefs(
    Expression<bool> Function($$CompositionsTableFilterComposer f) f,
  ) {
    final $$CompositionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.compositions,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompositionsTableFilterComposer(
            $db: $db,
            $table: $db.compositions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> indicationsRefs(
    Expression<bool> Function($$IndicationsTableFilterComposer f) f,
  ) {
    final $$IndicationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.indications,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IndicationsTableFilterComposer(
            $db: $db,
            $table: $db.indications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> directionsRefs(
    Expression<bool> Function($$DirectionsTableFilterComposer f) f,
  ) {
    final $$DirectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.directions,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DirectionsTableFilterComposer(
            $db: $db,
            $table: $db.directions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> precautionsRefs(
    Expression<bool> Function($$PrecautionsTableFilterComposer f) f,
  ) {
    final $$PrecautionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.precautions,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrecautionsTableFilterComposer(
            $db: $db,
            $table: $db.precautions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> presentationsRefs(
    Expression<bool> Function($$PresentationsTableFilterComposer f) f,
  ) {
    final $$PresentationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.presentations,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PresentationsTableFilterComposer(
            $db: $db,
            $table: $db.presentations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer
    extends Composer<_$ProductsDb, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleEn => $composableBuilder(
    column: $table.titleEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleBn => $composableBuilder(
    column: $table.titleBn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mottoEn => $composableBuilder(
    column: $table.mottoEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mottoBn => $composableBuilder(
    column: $table.mottoBn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shortDescriptionEn => $composableBuilder(
    column: $table.shortDescriptionEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shortDescriptionBn => $composableBuilder(
    column: $table.shortDescriptionBn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get compositionBasisEn => $composableBuilder(
    column: $table.compositionBasisEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get compositionBasisBn => $composableBuilder(
    column: $table.compositionBasisBn,
    builder: (column) => ColumnOrderings(column),
  );

  $$ManufacturersTableOrderingComposer get manufacturerId {
    final $$ManufacturersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.manufacturerId,
      referencedTable: $db.manufacturers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ManufacturersTableOrderingComposer(
            $db: $db,
            $table: $db.manufacturers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$ProductsDb, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get titleEn =>
      $composableBuilder(column: $table.titleEn, builder: (column) => column);

  GeneratedColumn<String> get titleBn =>
      $composableBuilder(column: $table.titleBn, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get mottoEn =>
      $composableBuilder(column: $table.mottoEn, builder: (column) => column);

  GeneratedColumn<String> get mottoBn =>
      $composableBuilder(column: $table.mottoBn, builder: (column) => column);

  GeneratedColumn<String> get shortDescriptionEn => $composableBuilder(
    column: $table.shortDescriptionEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get shortDescriptionBn => $composableBuilder(
    column: $table.shortDescriptionBn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<int> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get compositionBasisEn => $composableBuilder(
    column: $table.compositionBasisEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get compositionBasisBn => $composableBuilder(
    column: $table.compositionBasisBn,
    builder: (column) => column,
  );

  $$ManufacturersTableAnnotationComposer get manufacturerId {
    final $$ManufacturersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.manufacturerId,
      referencedTable: $db.manufacturers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ManufacturersTableAnnotationComposer(
            $db: $db,
            $table: $db.manufacturers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> productTargetGroupsRefs<T extends Object>(
    Expression<T> Function($$ProductTargetGroupsTableAnnotationComposer a) f,
  ) {
    final $$ProductTargetGroupsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.productTargetGroups,
          getReferencedColumn: (t) => t.productId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProductTargetGroupsTableAnnotationComposer(
                $db: $db,
                $table: $db.productTargetGroups,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> compositionsRefs<T extends Object>(
    Expression<T> Function($$CompositionsTableAnnotationComposer a) f,
  ) {
    final $$CompositionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.compositions,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompositionsTableAnnotationComposer(
            $db: $db,
            $table: $db.compositions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> indicationsRefs<T extends Object>(
    Expression<T> Function($$IndicationsTableAnnotationComposer a) f,
  ) {
    final $$IndicationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.indications,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IndicationsTableAnnotationComposer(
            $db: $db,
            $table: $db.indications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> directionsRefs<T extends Object>(
    Expression<T> Function($$DirectionsTableAnnotationComposer a) f,
  ) {
    final $$DirectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.directions,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DirectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.directions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> precautionsRefs<T extends Object>(
    Expression<T> Function($$PrecautionsTableAnnotationComposer a) f,
  ) {
    final $$PrecautionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.precautions,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PrecautionsTableAnnotationComposer(
            $db: $db,
            $table: $db.precautions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> presentationsRefs<T extends Object>(
    Expression<T> Function($$PresentationsTableAnnotationComposer a) f,
  ) {
    final $$PresentationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.presentations,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PresentationsTableAnnotationComposer(
            $db: $db,
            $table: $db.presentations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$ProductsDb,
          $ProductsTable,
          ProductEntity,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (ProductEntity, $$ProductsTableReferences),
          ProductEntity,
          PrefetchHooks Function({
            bool manufacturerId,
            bool categoryId,
            bool productTargetGroupsRefs,
            bool compositionsRefs,
            bool indicationsRefs,
            bool directionsRefs,
            bool precautionsRefs,
            bool presentationsRefs,
          })
        > {
  $$ProductsTableTableManager(_$ProductsDb db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> manufacturerId = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<String> titleEn = const Value.absent(),
                Value<String?> titleBn = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String?> mottoEn = const Value.absent(),
                Value<String?> mottoBn = const Value.absent(),
                Value<String?> shortDescriptionEn = const Value.absent(),
                Value<String?> shortDescriptionBn = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<int> isActive = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> compositionBasisEn = const Value.absent(),
                Value<String?> compositionBasisBn = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                manufacturerId: manufacturerId,
                categoryId: categoryId,
                titleEn: titleEn,
                titleBn: titleBn,
                slug: slug,
                mottoEn: mottoEn,
                mottoBn: mottoBn,
                shortDescriptionEn: shortDescriptionEn,
                shortDescriptionBn: shortDescriptionBn,
                imageUrl: imageUrl,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                compositionBasisEn: compositionBasisEn,
                compositionBasisBn: compositionBasisBn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> manufacturerId = const Value.absent(),
                required int categoryId,
                required String titleEn,
                Value<String?> titleBn = const Value.absent(),
                required String slug,
                Value<String?> mottoEn = const Value.absent(),
                Value<String?> mottoBn = const Value.absent(),
                Value<String?> shortDescriptionEn = const Value.absent(),
                Value<String?> shortDescriptionBn = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<int> isActive = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> compositionBasisEn = const Value.absent(),
                Value<String?> compositionBasisBn = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                manufacturerId: manufacturerId,
                categoryId: categoryId,
                titleEn: titleEn,
                titleBn: titleBn,
                slug: slug,
                mottoEn: mottoEn,
                mottoBn: mottoBn,
                shortDescriptionEn: shortDescriptionEn,
                shortDescriptionBn: shortDescriptionBn,
                imageUrl: imageUrl,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                compositionBasisEn: compositionBasisEn,
                compositionBasisBn: compositionBasisBn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                manufacturerId = false,
                categoryId = false,
                productTargetGroupsRefs = false,
                compositionsRefs = false,
                indicationsRefs = false,
                directionsRefs = false,
                precautionsRefs = false,
                presentationsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (productTargetGroupsRefs) db.productTargetGroups,
                    if (compositionsRefs) db.compositions,
                    if (indicationsRefs) db.indications,
                    if (directionsRefs) db.directions,
                    if (precautionsRefs) db.precautions,
                    if (presentationsRefs) db.presentations,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (manufacturerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.manufacturerId,
                                    referencedTable: $$ProductsTableReferences
                                        ._manufacturerIdTable(db),
                                    referencedColumn: $$ProductsTableReferences
                                        ._manufacturerIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable: $$ProductsTableReferences
                                        ._categoryIdTable(db),
                                    referencedColumn: $$ProductsTableReferences
                                        ._categoryIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (productTargetGroupsRefs)
                        await $_getPrefetchedData<
                          ProductEntity,
                          $ProductsTable,
                          ProductTargetGroup
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._productTargetGroupsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).productTargetGroupsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (compositionsRefs)
                        await $_getPrefetchedData<
                          ProductEntity,
                          $ProductsTable,
                          CompositionEntity
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._compositionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).compositionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (indicationsRefs)
                        await $_getPrefetchedData<
                          ProductEntity,
                          $ProductsTable,
                          IndicationEntity
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._indicationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).indicationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (directionsRefs)
                        await $_getPrefetchedData<
                          ProductEntity,
                          $ProductsTable,
                          DirectionEntity
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._directionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).directionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (precautionsRefs)
                        await $_getPrefetchedData<
                          ProductEntity,
                          $ProductsTable,
                          PrecautionEntity
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._precautionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).precautionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (presentationsRefs)
                        await $_getPrefetchedData<
                          ProductEntity,
                          $ProductsTable,
                          PresentationEntity
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._presentationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).presentationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$ProductsDb,
      $ProductsTable,
      ProductEntity,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (ProductEntity, $$ProductsTableReferences),
      ProductEntity,
      PrefetchHooks Function({
        bool manufacturerId,
        bool categoryId,
        bool productTargetGroupsRefs,
        bool compositionsRefs,
        bool indicationsRefs,
        bool directionsRefs,
        bool precautionsRefs,
        bool presentationsRefs,
      })
    >;
typedef $$ProductTargetGroupsTableCreateCompanionBuilder =
    ProductTargetGroupsCompanion Function({
      required int productId,
      required int targetGroupId,
      Value<int> rowid,
    });
typedef $$ProductTargetGroupsTableUpdateCompanionBuilder =
    ProductTargetGroupsCompanion Function({
      Value<int> productId,
      Value<int> targetGroupId,
      Value<int> rowid,
    });

final class $$ProductTargetGroupsTableReferences
    extends
        BaseReferences<
          _$ProductsDb,
          $ProductTargetGroupsTable,
          ProductTargetGroup
        > {
  $$ProductTargetGroupsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProductsTable _productIdTable(_$ProductsDb db) => db.products
      .createAlias('product_target_groups__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TargetGroupsTable _targetGroupIdTable(_$ProductsDb db) => db
      .targetGroups
      .createAlias('product_target_groups__target_group_id__target_groups__id');

  $$TargetGroupsTableProcessedTableManager get targetGroupId {
    final $_column = $_itemColumn<int>('target_group_id')!;

    final manager = $$TargetGroupsTableTableManager(
      $_db,
      $_db.targetGroups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_targetGroupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProductTargetGroupsTableFilterComposer
    extends Composer<_$ProductsDb, $ProductTargetGroupsTable> {
  $$ProductTargetGroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TargetGroupsTableFilterComposer get targetGroupId {
    final $$TargetGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetGroupId,
      referencedTable: $db.targetGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TargetGroupsTableFilterComposer(
            $db: $db,
            $table: $db.targetGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductTargetGroupsTableOrderingComposer
    extends Composer<_$ProductsDb, $ProductTargetGroupsTable> {
  $$ProductTargetGroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TargetGroupsTableOrderingComposer get targetGroupId {
    final $$TargetGroupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetGroupId,
      referencedTable: $db.targetGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TargetGroupsTableOrderingComposer(
            $db: $db,
            $table: $db.targetGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductTargetGroupsTableAnnotationComposer
    extends Composer<_$ProductsDb, $ProductTargetGroupsTable> {
  $$ProductTargetGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TargetGroupsTableAnnotationComposer get targetGroupId {
    final $$TargetGroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetGroupId,
      referencedTable: $db.targetGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TargetGroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.targetGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductTargetGroupsTableTableManager
    extends
        RootTableManager<
          _$ProductsDb,
          $ProductTargetGroupsTable,
          ProductTargetGroup,
          $$ProductTargetGroupsTableFilterComposer,
          $$ProductTargetGroupsTableOrderingComposer,
          $$ProductTargetGroupsTableAnnotationComposer,
          $$ProductTargetGroupsTableCreateCompanionBuilder,
          $$ProductTargetGroupsTableUpdateCompanionBuilder,
          (ProductTargetGroup, $$ProductTargetGroupsTableReferences),
          ProductTargetGroup,
          PrefetchHooks Function({bool productId, bool targetGroupId})
        > {
  $$ProductTargetGroupsTableTableManager(
    _$ProductsDb db,
    $ProductTargetGroupsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductTargetGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductTargetGroupsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ProductTargetGroupsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> productId = const Value.absent(),
                Value<int> targetGroupId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductTargetGroupsCompanion(
                productId: productId,
                targetGroupId: targetGroupId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int productId,
                required int targetGroupId,
                Value<int> rowid = const Value.absent(),
              }) => ProductTargetGroupsCompanion.insert(
                productId: productId,
                targetGroupId: targetGroupId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductTargetGroupsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productId = false, targetGroupId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable:
                                    $$ProductTargetGroupsTableReferences
                                        ._productIdTable(db),
                                referencedColumn:
                                    $$ProductTargetGroupsTableReferences
                                        ._productIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (targetGroupId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.targetGroupId,
                                referencedTable:
                                    $$ProductTargetGroupsTableReferences
                                        ._targetGroupIdTable(db),
                                referencedColumn:
                                    $$ProductTargetGroupsTableReferences
                                        ._targetGroupIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ProductTargetGroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$ProductsDb,
      $ProductTargetGroupsTable,
      ProductTargetGroup,
      $$ProductTargetGroupsTableFilterComposer,
      $$ProductTargetGroupsTableOrderingComposer,
      $$ProductTargetGroupsTableAnnotationComposer,
      $$ProductTargetGroupsTableCreateCompanionBuilder,
      $$ProductTargetGroupsTableUpdateCompanionBuilder,
      (ProductTargetGroup, $$ProductTargetGroupsTableReferences),
      ProductTargetGroup,
      PrefetchHooks Function({bool productId, bool targetGroupId})
    >;
typedef $$CompositionsTableCreateCompanionBuilder =
    CompositionsCompanion Function({
      Value<int> id,
      required int productId,
      required String ingredientEn,
      Value<String?> ingredientBn,
      Value<String?> concentration,
      Value<int> displayOrder,
    });
typedef $$CompositionsTableUpdateCompanionBuilder =
    CompositionsCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<String> ingredientEn,
      Value<String?> ingredientBn,
      Value<String?> concentration,
      Value<int> displayOrder,
    });

final class $$CompositionsTableReferences
    extends
        BaseReferences<_$ProductsDb, $CompositionsTable, CompositionEntity> {
  $$CompositionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductsTable _productIdTable(_$ProductsDb db) =>
      db.products.createAlias('compositions__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CompositionsTableFilterComposer
    extends Composer<_$ProductsDb, $CompositionsTable> {
  $$CompositionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ingredientEn => $composableBuilder(
    column: $table.ingredientEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ingredientBn => $composableBuilder(
    column: $table.ingredientBn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get concentration => $composableBuilder(
    column: $table.concentration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CompositionsTableOrderingComposer
    extends Composer<_$ProductsDb, $CompositionsTable> {
  $$CompositionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ingredientEn => $composableBuilder(
    column: $table.ingredientEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ingredientBn => $composableBuilder(
    column: $table.ingredientBn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get concentration => $composableBuilder(
    column: $table.concentration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CompositionsTableAnnotationComposer
    extends Composer<_$ProductsDb, $CompositionsTable> {
  $$CompositionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ingredientEn => $composableBuilder(
    column: $table.ingredientEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ingredientBn => $composableBuilder(
    column: $table.ingredientBn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get concentration => $composableBuilder(
    column: $table.concentration,
    builder: (column) => column,
  );

  GeneratedColumn<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => column,
  );

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CompositionsTableTableManager
    extends
        RootTableManager<
          _$ProductsDb,
          $CompositionsTable,
          CompositionEntity,
          $$CompositionsTableFilterComposer,
          $$CompositionsTableOrderingComposer,
          $$CompositionsTableAnnotationComposer,
          $$CompositionsTableCreateCompanionBuilder,
          $$CompositionsTableUpdateCompanionBuilder,
          (CompositionEntity, $$CompositionsTableReferences),
          CompositionEntity,
          PrefetchHooks Function({bool productId})
        > {
  $$CompositionsTableTableManager(_$ProductsDb db, $CompositionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompositionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompositionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompositionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<String> ingredientEn = const Value.absent(),
                Value<String?> ingredientBn = const Value.absent(),
                Value<String?> concentration = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
              }) => CompositionsCompanion(
                id: id,
                productId: productId,
                ingredientEn: ingredientEn,
                ingredientBn: ingredientBn,
                concentration: concentration,
                displayOrder: displayOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                required String ingredientEn,
                Value<String?> ingredientBn = const Value.absent(),
                Value<String?> concentration = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
              }) => CompositionsCompanion.insert(
                id: id,
                productId: productId,
                ingredientEn: ingredientEn,
                ingredientBn: ingredientBn,
                concentration: concentration,
                displayOrder: displayOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CompositionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable: $$CompositionsTableReferences
                                    ._productIdTable(db),
                                referencedColumn: $$CompositionsTableReferences
                                    ._productIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CompositionsTableProcessedTableManager =
    ProcessedTableManager<
      _$ProductsDb,
      $CompositionsTable,
      CompositionEntity,
      $$CompositionsTableFilterComposer,
      $$CompositionsTableOrderingComposer,
      $$CompositionsTableAnnotationComposer,
      $$CompositionsTableCreateCompanionBuilder,
      $$CompositionsTableUpdateCompanionBuilder,
      (CompositionEntity, $$CompositionsTableReferences),
      CompositionEntity,
      PrefetchHooks Function({bool productId})
    >;
typedef $$IndicationsTableCreateCompanionBuilder =
    IndicationsCompanion Function({
      Value<int> id,
      required int productId,
      required String textEn,
      Value<String?> textBn,
      Value<int> displayOrder,
    });
typedef $$IndicationsTableUpdateCompanionBuilder =
    IndicationsCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<String> textEn,
      Value<String?> textBn,
      Value<int> displayOrder,
    });

final class $$IndicationsTableReferences
    extends BaseReferences<_$ProductsDb, $IndicationsTable, IndicationEntity> {
  $$IndicationsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductsTable _productIdTable(_$ProductsDb db) =>
      db.products.createAlias('indications__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$IndicationsTableFilterComposer
    extends Composer<_$ProductsDb, $IndicationsTable> {
  $$IndicationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textEn => $composableBuilder(
    column: $table.textEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textBn => $composableBuilder(
    column: $table.textBn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IndicationsTableOrderingComposer
    extends Composer<_$ProductsDb, $IndicationsTable> {
  $$IndicationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textEn => $composableBuilder(
    column: $table.textEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textBn => $composableBuilder(
    column: $table.textBn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IndicationsTableAnnotationComposer
    extends Composer<_$ProductsDb, $IndicationsTable> {
  $$IndicationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get textEn =>
      $composableBuilder(column: $table.textEn, builder: (column) => column);

  GeneratedColumn<String> get textBn =>
      $composableBuilder(column: $table.textBn, builder: (column) => column);

  GeneratedColumn<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => column,
  );

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IndicationsTableTableManager
    extends
        RootTableManager<
          _$ProductsDb,
          $IndicationsTable,
          IndicationEntity,
          $$IndicationsTableFilterComposer,
          $$IndicationsTableOrderingComposer,
          $$IndicationsTableAnnotationComposer,
          $$IndicationsTableCreateCompanionBuilder,
          $$IndicationsTableUpdateCompanionBuilder,
          (IndicationEntity, $$IndicationsTableReferences),
          IndicationEntity,
          PrefetchHooks Function({bool productId})
        > {
  $$IndicationsTableTableManager(_$ProductsDb db, $IndicationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IndicationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IndicationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IndicationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<String> textEn = const Value.absent(),
                Value<String?> textBn = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
              }) => IndicationsCompanion(
                id: id,
                productId: productId,
                textEn: textEn,
                textBn: textBn,
                displayOrder: displayOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                required String textEn,
                Value<String?> textBn = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
              }) => IndicationsCompanion.insert(
                id: id,
                productId: productId,
                textEn: textEn,
                textBn: textBn,
                displayOrder: displayOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$IndicationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable: $$IndicationsTableReferences
                                    ._productIdTable(db),
                                referencedColumn: $$IndicationsTableReferences
                                    ._productIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$IndicationsTableProcessedTableManager =
    ProcessedTableManager<
      _$ProductsDb,
      $IndicationsTable,
      IndicationEntity,
      $$IndicationsTableFilterComposer,
      $$IndicationsTableOrderingComposer,
      $$IndicationsTableAnnotationComposer,
      $$IndicationsTableCreateCompanionBuilder,
      $$IndicationsTableUpdateCompanionBuilder,
      (IndicationEntity, $$IndicationsTableReferences),
      IndicationEntity,
      PrefetchHooks Function({bool productId})
    >;
typedef $$DirectionsTableCreateCompanionBuilder =
    DirectionsCompanion Function({
      Value<int> id,
      required int productId,
      required int contentTypeId,
      required int speciesId,
      required double doseValueMin,
      Value<double?> doseValueMax,
      required int doseUnitId,
      required int doseBasisId,
      Value<int?> durationDaysMin,
      Value<int?> durationDaysMax,
      Value<String?> administrationEn,
      Value<String?> administrationBn,
      Value<String?> dosageEn,
      Value<String?> dosageBn,
      Value<int> displayOrder,
    });
typedef $$DirectionsTableUpdateCompanionBuilder =
    DirectionsCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<int> contentTypeId,
      Value<int> speciesId,
      Value<double> doseValueMin,
      Value<double?> doseValueMax,
      Value<int> doseUnitId,
      Value<int> doseBasisId,
      Value<int?> durationDaysMin,
      Value<int?> durationDaysMax,
      Value<String?> administrationEn,
      Value<String?> administrationBn,
      Value<String?> dosageEn,
      Value<String?> dosageBn,
      Value<int> displayOrder,
    });

final class $$DirectionsTableReferences
    extends BaseReferences<_$ProductsDb, $DirectionsTable, DirectionEntity> {
  $$DirectionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductsTable _productIdTable(_$ProductsDb db) =>
      db.products.createAlias('directions__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ContentTypesTable _contentTypeIdTable(_$ProductsDb db) => db
      .contentTypes
      .createAlias('directions__content_type_id__content_types__id');

  $$ContentTypesTableProcessedTableManager get contentTypeId {
    final $_column = $_itemColumn<int>('content_type_id')!;

    final manager = $$ContentTypesTableTableManager(
      $_db,
      $_db.contentTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_contentTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SpeciesTable _speciesIdTable(_$ProductsDb db) =>
      db.species.createAlias('directions__species_id__species__id');

  $$SpeciesTableProcessedTableManager get speciesId {
    final $_column = $_itemColumn<int>('species_id')!;

    final manager = $$SpeciesTableTableManager(
      $_db,
      $_db.species,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_speciesIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DosageUnitsTable _doseUnitIdTable(_$ProductsDb db) =>
      db.dosageUnits.createAlias('directions__dose_unit_id__dosage_units__id');

  $$DosageUnitsTableProcessedTableManager get doseUnitId {
    final $_column = $_itemColumn<int>('dose_unit_id')!;

    final manager = $$DosageUnitsTableTableManager(
      $_db,
      $_db.dosageUnits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_doseUnitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DosageBasesTable _doseBasisIdTable(_$ProductsDb db) =>
      db.dosageBases.createAlias('directions__dose_basis_id__dosage_bases__id');

  $$DosageBasesTableProcessedTableManager get doseBasisId {
    final $_column = $_itemColumn<int>('dose_basis_id')!;

    final manager = $$DosageBasesTableTableManager(
      $_db,
      $_db.dosageBases,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_doseBasisIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DirectionsTableFilterComposer
    extends Composer<_$ProductsDb, $DirectionsTable> {
  $$DirectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get doseValueMin => $composableBuilder(
    column: $table.doseValueMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get doseValueMax => $composableBuilder(
    column: $table.doseValueMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationDaysMin => $composableBuilder(
    column: $table.durationDaysMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationDaysMax => $composableBuilder(
    column: $table.durationDaysMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get administrationEn => $composableBuilder(
    column: $table.administrationEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get administrationBn => $composableBuilder(
    column: $table.administrationBn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dosageEn => $composableBuilder(
    column: $table.dosageEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dosageBn => $composableBuilder(
    column: $table.dosageBn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContentTypesTableFilterComposer get contentTypeId {
    final $$ContentTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentTypeId,
      referencedTable: $db.contentTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentTypesTableFilterComposer(
            $db: $db,
            $table: $db.contentTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SpeciesTableFilterComposer get speciesId {
    final $$SpeciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.species,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableFilterComposer(
            $db: $db,
            $table: $db.species,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DosageUnitsTableFilterComposer get doseUnitId {
    final $$DosageUnitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.doseUnitId,
      referencedTable: $db.dosageUnits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DosageUnitsTableFilterComposer(
            $db: $db,
            $table: $db.dosageUnits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DosageBasesTableFilterComposer get doseBasisId {
    final $$DosageBasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.doseBasisId,
      referencedTable: $db.dosageBases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DosageBasesTableFilterComposer(
            $db: $db,
            $table: $db.dosageBases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DirectionsTableOrderingComposer
    extends Composer<_$ProductsDb, $DirectionsTable> {
  $$DirectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get doseValueMin => $composableBuilder(
    column: $table.doseValueMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get doseValueMax => $composableBuilder(
    column: $table.doseValueMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationDaysMin => $composableBuilder(
    column: $table.durationDaysMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationDaysMax => $composableBuilder(
    column: $table.durationDaysMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get administrationEn => $composableBuilder(
    column: $table.administrationEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get administrationBn => $composableBuilder(
    column: $table.administrationBn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dosageEn => $composableBuilder(
    column: $table.dosageEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dosageBn => $composableBuilder(
    column: $table.dosageBn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContentTypesTableOrderingComposer get contentTypeId {
    final $$ContentTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentTypeId,
      referencedTable: $db.contentTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentTypesTableOrderingComposer(
            $db: $db,
            $table: $db.contentTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SpeciesTableOrderingComposer get speciesId {
    final $$SpeciesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.species,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableOrderingComposer(
            $db: $db,
            $table: $db.species,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DosageUnitsTableOrderingComposer get doseUnitId {
    final $$DosageUnitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.doseUnitId,
      referencedTable: $db.dosageUnits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DosageUnitsTableOrderingComposer(
            $db: $db,
            $table: $db.dosageUnits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DosageBasesTableOrderingComposer get doseBasisId {
    final $$DosageBasesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.doseBasisId,
      referencedTable: $db.dosageBases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DosageBasesTableOrderingComposer(
            $db: $db,
            $table: $db.dosageBases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DirectionsTableAnnotationComposer
    extends Composer<_$ProductsDb, $DirectionsTable> {
  $$DirectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get doseValueMin => $composableBuilder(
    column: $table.doseValueMin,
    builder: (column) => column,
  );

  GeneratedColumn<double> get doseValueMax => $composableBuilder(
    column: $table.doseValueMax,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationDaysMin => $composableBuilder(
    column: $table.durationDaysMin,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationDaysMax => $composableBuilder(
    column: $table.durationDaysMax,
    builder: (column) => column,
  );

  GeneratedColumn<String> get administrationEn => $composableBuilder(
    column: $table.administrationEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get administrationBn => $composableBuilder(
    column: $table.administrationBn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dosageEn =>
      $composableBuilder(column: $table.dosageEn, builder: (column) => column);

  GeneratedColumn<String> get dosageBn =>
      $composableBuilder(column: $table.dosageBn, builder: (column) => column);

  GeneratedColumn<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => column,
  );

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContentTypesTableAnnotationComposer get contentTypeId {
    final $$ContentTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentTypeId,
      referencedTable: $db.contentTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.contentTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SpeciesTableAnnotationComposer get speciesId {
    final $$SpeciesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.species,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpeciesTableAnnotationComposer(
            $db: $db,
            $table: $db.species,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DosageUnitsTableAnnotationComposer get doseUnitId {
    final $$DosageUnitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.doseUnitId,
      referencedTable: $db.dosageUnits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DosageUnitsTableAnnotationComposer(
            $db: $db,
            $table: $db.dosageUnits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DosageBasesTableAnnotationComposer get doseBasisId {
    final $$DosageBasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.doseBasisId,
      referencedTable: $db.dosageBases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DosageBasesTableAnnotationComposer(
            $db: $db,
            $table: $db.dosageBases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DirectionsTableTableManager
    extends
        RootTableManager<
          _$ProductsDb,
          $DirectionsTable,
          DirectionEntity,
          $$DirectionsTableFilterComposer,
          $$DirectionsTableOrderingComposer,
          $$DirectionsTableAnnotationComposer,
          $$DirectionsTableCreateCompanionBuilder,
          $$DirectionsTableUpdateCompanionBuilder,
          (DirectionEntity, $$DirectionsTableReferences),
          DirectionEntity,
          PrefetchHooks Function({
            bool productId,
            bool contentTypeId,
            bool speciesId,
            bool doseUnitId,
            bool doseBasisId,
          })
        > {
  $$DirectionsTableTableManager(_$ProductsDb db, $DirectionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DirectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DirectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DirectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> contentTypeId = const Value.absent(),
                Value<int> speciesId = const Value.absent(),
                Value<double> doseValueMin = const Value.absent(),
                Value<double?> doseValueMax = const Value.absent(),
                Value<int> doseUnitId = const Value.absent(),
                Value<int> doseBasisId = const Value.absent(),
                Value<int?> durationDaysMin = const Value.absent(),
                Value<int?> durationDaysMax = const Value.absent(),
                Value<String?> administrationEn = const Value.absent(),
                Value<String?> administrationBn = const Value.absent(),
                Value<String?> dosageEn = const Value.absent(),
                Value<String?> dosageBn = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
              }) => DirectionsCompanion(
                id: id,
                productId: productId,
                contentTypeId: contentTypeId,
                speciesId: speciesId,
                doseValueMin: doseValueMin,
                doseValueMax: doseValueMax,
                doseUnitId: doseUnitId,
                doseBasisId: doseBasisId,
                durationDaysMin: durationDaysMin,
                durationDaysMax: durationDaysMax,
                administrationEn: administrationEn,
                administrationBn: administrationBn,
                dosageEn: dosageEn,
                dosageBn: dosageBn,
                displayOrder: displayOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                required int contentTypeId,
                required int speciesId,
                required double doseValueMin,
                Value<double?> doseValueMax = const Value.absent(),
                required int doseUnitId,
                required int doseBasisId,
                Value<int?> durationDaysMin = const Value.absent(),
                Value<int?> durationDaysMax = const Value.absent(),
                Value<String?> administrationEn = const Value.absent(),
                Value<String?> administrationBn = const Value.absent(),
                Value<String?> dosageEn = const Value.absent(),
                Value<String?> dosageBn = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
              }) => DirectionsCompanion.insert(
                id: id,
                productId: productId,
                contentTypeId: contentTypeId,
                speciesId: speciesId,
                doseValueMin: doseValueMin,
                doseValueMax: doseValueMax,
                doseUnitId: doseUnitId,
                doseBasisId: doseBasisId,
                durationDaysMin: durationDaysMin,
                durationDaysMax: durationDaysMax,
                administrationEn: administrationEn,
                administrationBn: administrationBn,
                dosageEn: dosageEn,
                dosageBn: dosageBn,
                displayOrder: displayOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DirectionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                productId = false,
                contentTypeId = false,
                speciesId = false,
                doseUnitId = false,
                doseBasisId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (productId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.productId,
                                    referencedTable: $$DirectionsTableReferences
                                        ._productIdTable(db),
                                    referencedColumn:
                                        $$DirectionsTableReferences
                                            ._productIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (contentTypeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.contentTypeId,
                                    referencedTable: $$DirectionsTableReferences
                                        ._contentTypeIdTable(db),
                                    referencedColumn:
                                        $$DirectionsTableReferences
                                            ._contentTypeIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (speciesId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.speciesId,
                                    referencedTable: $$DirectionsTableReferences
                                        ._speciesIdTable(db),
                                    referencedColumn:
                                        $$DirectionsTableReferences
                                            ._speciesIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (doseUnitId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.doseUnitId,
                                    referencedTable: $$DirectionsTableReferences
                                        ._doseUnitIdTable(db),
                                    referencedColumn:
                                        $$DirectionsTableReferences
                                            ._doseUnitIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (doseBasisId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.doseBasisId,
                                    referencedTable: $$DirectionsTableReferences
                                        ._doseBasisIdTable(db),
                                    referencedColumn:
                                        $$DirectionsTableReferences
                                            ._doseBasisIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$DirectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$ProductsDb,
      $DirectionsTable,
      DirectionEntity,
      $$DirectionsTableFilterComposer,
      $$DirectionsTableOrderingComposer,
      $$DirectionsTableAnnotationComposer,
      $$DirectionsTableCreateCompanionBuilder,
      $$DirectionsTableUpdateCompanionBuilder,
      (DirectionEntity, $$DirectionsTableReferences),
      DirectionEntity,
      PrefetchHooks Function({
        bool productId,
        bool contentTypeId,
        bool speciesId,
        bool doseUnitId,
        bool doseBasisId,
      })
    >;
typedef $$PrecautionsTableCreateCompanionBuilder =
    PrecautionsCompanion Function({
      Value<int> id,
      required int productId,
      required String textEn,
      Value<String?> textBn,
      Value<int> displayOrder,
    });
typedef $$PrecautionsTableUpdateCompanionBuilder =
    PrecautionsCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<String> textEn,
      Value<String?> textBn,
      Value<int> displayOrder,
    });

final class $$PrecautionsTableReferences
    extends BaseReferences<_$ProductsDb, $PrecautionsTable, PrecautionEntity> {
  $$PrecautionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductsTable _productIdTable(_$ProductsDb db) =>
      db.products.createAlias('precautions__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PrecautionsTableFilterComposer
    extends Composer<_$ProductsDb, $PrecautionsTable> {
  $$PrecautionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textEn => $composableBuilder(
    column: $table.textEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textBn => $composableBuilder(
    column: $table.textBn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PrecautionsTableOrderingComposer
    extends Composer<_$ProductsDb, $PrecautionsTable> {
  $$PrecautionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textEn => $composableBuilder(
    column: $table.textEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textBn => $composableBuilder(
    column: $table.textBn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PrecautionsTableAnnotationComposer
    extends Composer<_$ProductsDb, $PrecautionsTable> {
  $$PrecautionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get textEn =>
      $composableBuilder(column: $table.textEn, builder: (column) => column);

  GeneratedColumn<String> get textBn =>
      $composableBuilder(column: $table.textBn, builder: (column) => column);

  GeneratedColumn<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => column,
  );

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PrecautionsTableTableManager
    extends
        RootTableManager<
          _$ProductsDb,
          $PrecautionsTable,
          PrecautionEntity,
          $$PrecautionsTableFilterComposer,
          $$PrecautionsTableOrderingComposer,
          $$PrecautionsTableAnnotationComposer,
          $$PrecautionsTableCreateCompanionBuilder,
          $$PrecautionsTableUpdateCompanionBuilder,
          (PrecautionEntity, $$PrecautionsTableReferences),
          PrecautionEntity,
          PrefetchHooks Function({bool productId})
        > {
  $$PrecautionsTableTableManager(_$ProductsDb db, $PrecautionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrecautionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrecautionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrecautionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<String> textEn = const Value.absent(),
                Value<String?> textBn = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
              }) => PrecautionsCompanion(
                id: id,
                productId: productId,
                textEn: textEn,
                textBn: textBn,
                displayOrder: displayOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                required String textEn,
                Value<String?> textBn = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
              }) => PrecautionsCompanion.insert(
                id: id,
                productId: productId,
                textEn: textEn,
                textBn: textBn,
                displayOrder: displayOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PrecautionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable: $$PrecautionsTableReferences
                                    ._productIdTable(db),
                                referencedColumn: $$PrecautionsTableReferences
                                    ._productIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PrecautionsTableProcessedTableManager =
    ProcessedTableManager<
      _$ProductsDb,
      $PrecautionsTable,
      PrecautionEntity,
      $$PrecautionsTableFilterComposer,
      $$PrecautionsTableOrderingComposer,
      $$PrecautionsTableAnnotationComposer,
      $$PrecautionsTableCreateCompanionBuilder,
      $$PrecautionsTableUpdateCompanionBuilder,
      (PrecautionEntity, $$PrecautionsTableReferences),
      PrecautionEntity,
      PrefetchHooks Function({bool productId})
    >;
typedef $$PresentationsTableCreateCompanionBuilder =
    PresentationsCompanion Function({
      Value<int> id,
      required int productId,
      required int productTypeId,
      required int contentTypeId,
      Value<String?> size,
      Value<double?> mrp,
      Value<String?> imageUrl,
      Value<int> displayOrder,
      Value<int> bulkItem,
    });
typedef $$PresentationsTableUpdateCompanionBuilder =
    PresentationsCompanion Function({
      Value<int> id,
      Value<int> productId,
      Value<int> productTypeId,
      Value<int> contentTypeId,
      Value<String?> size,
      Value<double?> mrp,
      Value<String?> imageUrl,
      Value<int> displayOrder,
      Value<int> bulkItem,
    });

final class $$PresentationsTableReferences
    extends
        BaseReferences<_$ProductsDb, $PresentationsTable, PresentationEntity> {
  $$PresentationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProductsTable _productIdTable(_$ProductsDb db) =>
      db.products.createAlias('presentations__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductTypesTable _productTypeIdTable(_$ProductsDb db) => db
      .productTypes
      .createAlias('presentations__product_type_id__product_types__id');

  $$ProductTypesTableProcessedTableManager get productTypeId {
    final $_column = $_itemColumn<int>('product_type_id')!;

    final manager = $$ProductTypesTableTableManager(
      $_db,
      $_db.productTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ContentTypesTable _contentTypeIdTable(_$ProductsDb db) => db
      .contentTypes
      .createAlias('presentations__content_type_id__content_types__id');

  $$ContentTypesTableProcessedTableManager get contentTypeId {
    final $_column = $_itemColumn<int>('content_type_id')!;

    final manager = $$ContentTypesTableTableManager(
      $_db,
      $_db.contentTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_contentTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PresentationsTableFilterComposer
    extends Composer<_$ProductsDb, $PresentationsTable> {
  $$PresentationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get mrp => $composableBuilder(
    column: $table.mrp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bulkItem => $composableBuilder(
    column: $table.bulkItem,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductTypesTableFilterComposer get productTypeId {
    final $$ProductTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productTypeId,
      referencedTable: $db.productTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductTypesTableFilterComposer(
            $db: $db,
            $table: $db.productTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContentTypesTableFilterComposer get contentTypeId {
    final $$ContentTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentTypeId,
      referencedTable: $db.contentTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentTypesTableFilterComposer(
            $db: $db,
            $table: $db.contentTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PresentationsTableOrderingComposer
    extends Composer<_$ProductsDb, $PresentationsTable> {
  $$PresentationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get mrp => $composableBuilder(
    column: $table.mrp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bulkItem => $composableBuilder(
    column: $table.bulkItem,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductTypesTableOrderingComposer get productTypeId {
    final $$ProductTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productTypeId,
      referencedTable: $db.productTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductTypesTableOrderingComposer(
            $db: $db,
            $table: $db.productTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContentTypesTableOrderingComposer get contentTypeId {
    final $$ContentTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentTypeId,
      referencedTable: $db.contentTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentTypesTableOrderingComposer(
            $db: $db,
            $table: $db.contentTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PresentationsTableAnnotationComposer
    extends Composer<_$ProductsDb, $PresentationsTable> {
  $$PresentationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  GeneratedColumn<double> get mrp =>
      $composableBuilder(column: $table.mrp, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bulkItem =>
      $composableBuilder(column: $table.bulkItem, builder: (column) => column);

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductTypesTableAnnotationComposer get productTypeId {
    final $$ProductTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productTypeId,
      referencedTable: $db.productTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.productTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ContentTypesTableAnnotationComposer get contentTypeId {
    final $$ContentTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.contentTypeId,
      referencedTable: $db.contentTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContentTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.contentTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PresentationsTableTableManager
    extends
        RootTableManager<
          _$ProductsDb,
          $PresentationsTable,
          PresentationEntity,
          $$PresentationsTableFilterComposer,
          $$PresentationsTableOrderingComposer,
          $$PresentationsTableAnnotationComposer,
          $$PresentationsTableCreateCompanionBuilder,
          $$PresentationsTableUpdateCompanionBuilder,
          (PresentationEntity, $$PresentationsTableReferences),
          PresentationEntity,
          PrefetchHooks Function({
            bool productId,
            bool productTypeId,
            bool contentTypeId,
          })
        > {
  $$PresentationsTableTableManager(_$ProductsDb db, $PresentationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PresentationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PresentationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PresentationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> productTypeId = const Value.absent(),
                Value<int> contentTypeId = const Value.absent(),
                Value<String?> size = const Value.absent(),
                Value<double?> mrp = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
                Value<int> bulkItem = const Value.absent(),
              }) => PresentationsCompanion(
                id: id,
                productId: productId,
                productTypeId: productTypeId,
                contentTypeId: contentTypeId,
                size: size,
                mrp: mrp,
                imageUrl: imageUrl,
                displayOrder: displayOrder,
                bulkItem: bulkItem,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                required int productTypeId,
                required int contentTypeId,
                Value<String?> size = const Value.absent(),
                Value<double?> mrp = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
                Value<int> bulkItem = const Value.absent(),
              }) => PresentationsCompanion.insert(
                id: id,
                productId: productId,
                productTypeId: productTypeId,
                contentTypeId: contentTypeId,
                size: size,
                mrp: mrp,
                imageUrl: imageUrl,
                displayOrder: displayOrder,
                bulkItem: bulkItem,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PresentationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                productId = false,
                productTypeId = false,
                contentTypeId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (productId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.productId,
                                    referencedTable:
                                        $$PresentationsTableReferences
                                            ._productIdTable(db),
                                    referencedColumn:
                                        $$PresentationsTableReferences
                                            ._productIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (productTypeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.productTypeId,
                                    referencedTable:
                                        $$PresentationsTableReferences
                                            ._productTypeIdTable(db),
                                    referencedColumn:
                                        $$PresentationsTableReferences
                                            ._productTypeIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (contentTypeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.contentTypeId,
                                    referencedTable:
                                        $$PresentationsTableReferences
                                            ._contentTypeIdTable(db),
                                    referencedColumn:
                                        $$PresentationsTableReferences
                                            ._contentTypeIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$PresentationsTableProcessedTableManager =
    ProcessedTableManager<
      _$ProductsDb,
      $PresentationsTable,
      PresentationEntity,
      $$PresentationsTableFilterComposer,
      $$PresentationsTableOrderingComposer,
      $$PresentationsTableAnnotationComposer,
      $$PresentationsTableCreateCompanionBuilder,
      $$PresentationsTableUpdateCompanionBuilder,
      (PresentationEntity, $$PresentationsTableReferences),
      PresentationEntity,
      PrefetchHooks Function({
        bool productId,
        bool productTypeId,
        bool contentTypeId,
      })
    >;

class $ProductsDbManager {
  final _$ProductsDb _db;
  $ProductsDbManager(this._db);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$TargetGroupsTableTableManager get targetGroups =>
      $$TargetGroupsTableTableManager(_db, _db.targetGroups);
  $$ContentTypesTableTableManager get contentTypes =>
      $$ContentTypesTableTableManager(_db, _db.contentTypes);
  $$ProductTypesTableTableManager get productTypes =>
      $$ProductTypesTableTableManager(_db, _db.productTypes);
  $$SpeciesTableTableManager get species =>
      $$SpeciesTableTableManager(_db, _db.species);
  $$DosageUnitsTableTableManager get dosageUnits =>
      $$DosageUnitsTableTableManager(_db, _db.dosageUnits);
  $$DosageBasesTableTableManager get dosageBases =>
      $$DosageBasesTableTableManager(_db, _db.dosageBases);
  $$ManufacturersTableTableManager get manufacturers =>
      $$ManufacturersTableTableManager(_db, _db.manufacturers);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$ProductTargetGroupsTableTableManager get productTargetGroups =>
      $$ProductTargetGroupsTableTableManager(_db, _db.productTargetGroups);
  $$CompositionsTableTableManager get compositions =>
      $$CompositionsTableTableManager(_db, _db.compositions);
  $$IndicationsTableTableManager get indications =>
      $$IndicationsTableTableManager(_db, _db.indications);
  $$DirectionsTableTableManager get directions =>
      $$DirectionsTableTableManager(_db, _db.directions);
  $$PrecautionsTableTableManager get precautions =>
      $$PrecautionsTableTableManager(_db, _db.precautions);
  $$PresentationsTableTableManager get presentations =>
      $$PresentationsTableTableManager(_db, _db.presentations);
}

class $RegionsTable extends Regions
    with TableInfo<$RegionsTable, RegionEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RegionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameBnMeta = const VerificationMeta('nameBn');
  @override
  late final GeneratedColumn<String> nameBn = GeneratedColumn<String>(
    'name_bn',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nameEn, nameBn];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'regions';
  @override
  VerificationContext validateIntegrity(
    Insertable<RegionEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_bn')) {
      context.handle(
        _nameBnMeta,
        nameBn.isAcceptableOrUnknown(data['name_bn']!, _nameBnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameBnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RegionEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RegionEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_bn'],
      )!,
    );
  }

  @override
  $RegionsTable createAlias(String alias) {
    return $RegionsTable(attachedDatabase, alias);
  }
}

class RegionEntity extends DataClass implements Insertable<RegionEntity> {
  final int id;
  final String nameEn;
  final String nameBn;
  const RegionEntity({
    required this.id,
    required this.nameEn,
    required this.nameBn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name_en'] = Variable<String>(nameEn);
    map['name_bn'] = Variable<String>(nameBn);
    return map;
  }

  RegionsCompanion toCompanion(bool nullToAbsent) {
    return RegionsCompanion(
      id: Value(id),
      nameEn: Value(nameEn),
      nameBn: Value(nameBn),
    );
  }

  factory RegionEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RegionEntity(
      id: serializer.fromJson<int>(json['id']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameBn: serializer.fromJson<String>(json['nameBn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameBn': serializer.toJson<String>(nameBn),
    };
  }

  RegionEntity copyWith({int? id, String? nameEn, String? nameBn}) =>
      RegionEntity(
        id: id ?? this.id,
        nameEn: nameEn ?? this.nameEn,
        nameBn: nameBn ?? this.nameBn,
      );
  RegionEntity copyWithCompanion(RegionsCompanion data) {
    return RegionEntity(
      id: data.id.present ? data.id.value : this.id,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameBn: data.nameBn.present ? data.nameBn.value : this.nameBn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RegionEntity(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameEn, nameBn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RegionEntity &&
          other.id == this.id &&
          other.nameEn == this.nameEn &&
          other.nameBn == this.nameBn);
}

class RegionsCompanion extends UpdateCompanion<RegionEntity> {
  final Value<int> id;
  final Value<String> nameEn;
  final Value<String> nameBn;
  const RegionsCompanion({
    this.id = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameBn = const Value.absent(),
  });
  RegionsCompanion.insert({
    this.id = const Value.absent(),
    required String nameEn,
    required String nameBn,
  }) : nameEn = Value(nameEn),
       nameBn = Value(nameBn);
  static Insertable<RegionEntity> custom({
    Expression<int>? id,
    Expression<String>? nameEn,
    Expression<String>? nameBn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameEn != null) 'name_en': nameEn,
      if (nameBn != null) 'name_bn': nameBn,
    });
  }

  RegionsCompanion copyWith({
    Value<int>? id,
    Value<String>? nameEn,
    Value<String>? nameBn,
  }) {
    return RegionsCompanion(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameBn: nameBn ?? this.nameBn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameBn.present) {
      map['name_bn'] = Variable<String>(nameBn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RegionsCompanion(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn')
          ..write(')'))
        .toString();
  }
}

class $AreasTable extends Areas with TableInfo<$AreasTable, AreaEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AreasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _regionIdMeta = const VerificationMeta(
    'regionId',
  );
  @override
  late final GeneratedColumn<int> regionId = GeneratedColumn<int>(
    'region_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES regions(id)',
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameBnMeta = const VerificationMeta('nameBn');
  @override
  late final GeneratedColumn<String> nameBn = GeneratedColumn<String>(
    'name_bn',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, regionId, nameEn, nameBn];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'areas';
  @override
  VerificationContext validateIntegrity(
    Insertable<AreaEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('region_id')) {
      context.handle(
        _regionIdMeta,
        regionId.isAcceptableOrUnknown(data['region_id']!, _regionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_regionIdMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_bn')) {
      context.handle(
        _nameBnMeta,
        nameBn.isAcceptableOrUnknown(data['name_bn']!, _nameBnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameBnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AreaEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AreaEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      regionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}region_id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_bn'],
      )!,
    );
  }

  @override
  $AreasTable createAlias(String alias) {
    return $AreasTable(attachedDatabase, alias);
  }
}

class AreaEntity extends DataClass implements Insertable<AreaEntity> {
  final int id;
  final int regionId;
  final String nameEn;
  final String nameBn;
  const AreaEntity({
    required this.id,
    required this.regionId,
    required this.nameEn,
    required this.nameBn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['region_id'] = Variable<int>(regionId);
    map['name_en'] = Variable<String>(nameEn);
    map['name_bn'] = Variable<String>(nameBn);
    return map;
  }

  AreasCompanion toCompanion(bool nullToAbsent) {
    return AreasCompanion(
      id: Value(id),
      regionId: Value(regionId),
      nameEn: Value(nameEn),
      nameBn: Value(nameBn),
    );
  }

  factory AreaEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AreaEntity(
      id: serializer.fromJson<int>(json['id']),
      regionId: serializer.fromJson<int>(json['regionId']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameBn: serializer.fromJson<String>(json['nameBn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'regionId': serializer.toJson<int>(regionId),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameBn': serializer.toJson<String>(nameBn),
    };
  }

  AreaEntity copyWith({
    int? id,
    int? regionId,
    String? nameEn,
    String? nameBn,
  }) => AreaEntity(
    id: id ?? this.id,
    regionId: regionId ?? this.regionId,
    nameEn: nameEn ?? this.nameEn,
    nameBn: nameBn ?? this.nameBn,
  );
  AreaEntity copyWithCompanion(AreasCompanion data) {
    return AreaEntity(
      id: data.id.present ? data.id.value : this.id,
      regionId: data.regionId.present ? data.regionId.value : this.regionId,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameBn: data.nameBn.present ? data.nameBn.value : this.nameBn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AreaEntity(')
          ..write('id: $id, ')
          ..write('regionId: $regionId, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, regionId, nameEn, nameBn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AreaEntity &&
          other.id == this.id &&
          other.regionId == this.regionId &&
          other.nameEn == this.nameEn &&
          other.nameBn == this.nameBn);
}

class AreasCompanion extends UpdateCompanion<AreaEntity> {
  final Value<int> id;
  final Value<int> regionId;
  final Value<String> nameEn;
  final Value<String> nameBn;
  const AreasCompanion({
    this.id = const Value.absent(),
    this.regionId = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameBn = const Value.absent(),
  });
  AreasCompanion.insert({
    this.id = const Value.absent(),
    required int regionId,
    required String nameEn,
    required String nameBn,
  }) : regionId = Value(regionId),
       nameEn = Value(nameEn),
       nameBn = Value(nameBn);
  static Insertable<AreaEntity> custom({
    Expression<int>? id,
    Expression<int>? regionId,
    Expression<String>? nameEn,
    Expression<String>? nameBn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (regionId != null) 'region_id': regionId,
      if (nameEn != null) 'name_en': nameEn,
      if (nameBn != null) 'name_bn': nameBn,
    });
  }

  AreasCompanion copyWith({
    Value<int>? id,
    Value<int>? regionId,
    Value<String>? nameEn,
    Value<String>? nameBn,
  }) {
    return AreasCompanion(
      id: id ?? this.id,
      regionId: regionId ?? this.regionId,
      nameEn: nameEn ?? this.nameEn,
      nameBn: nameBn ?? this.nameBn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (regionId.present) {
      map['region_id'] = Variable<int>(regionId.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameBn.present) {
      map['name_bn'] = Variable<String>(nameBn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AreasCompanion(')
          ..write('id: $id, ')
          ..write('regionId: $regionId, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn')
          ..write(')'))
        .toString();
  }
}

class $DistributorsTable extends Distributors
    with TableInfo<$DistributorsTable, DistributorEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DistributorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameBnMeta = const VerificationMeta('nameBn');
  @override
  late final GeneratedColumn<String> nameBn = GeneratedColumn<String>(
    'name_bn',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _designationMeta = const VerificationMeta(
    'designation',
  );
  @override
  late final GeneratedColumn<String> designation = GeneratedColumn<String>(
    'designation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressEnMeta = const VerificationMeta(
    'addressEn',
  );
  @override
  late final GeneratedColumn<String> addressEn = GeneratedColumn<String>(
    'address_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressBnMeta = const VerificationMeta(
    'addressBn',
  );
  @override
  late final GeneratedColumn<String> addressBn = GeneratedColumn<String>(
    'address_bn',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _areaIdMeta = const VerificationMeta('areaId');
  @override
  late final GeneratedColumn<int> areaId = GeneratedColumn<int>(
    'area_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES areas(id)',
  );
  static const VerificationMeta _mobileMeta = const VerificationMeta('mobile');
  @override
  late final GeneratedColumn<String> mobile = GeneratedColumn<String>(
    'mobile',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<int> isActive = GeneratedColumn<int>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toIso8601String(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toIso8601String(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nameEn,
    nameBn,
    designation,
    addressEn,
    addressBn,
    areaId,
    mobile,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'distributors';
  @override
  VerificationContext validateIntegrity(
    Insertable<DistributorEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_bn')) {
      context.handle(
        _nameBnMeta,
        nameBn.isAcceptableOrUnknown(data['name_bn']!, _nameBnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameBnMeta);
    }
    if (data.containsKey('designation')) {
      context.handle(
        _designationMeta,
        designation.isAcceptableOrUnknown(
          data['designation']!,
          _designationMeta,
        ),
      );
    }
    if (data.containsKey('address_en')) {
      context.handle(
        _addressEnMeta,
        addressEn.isAcceptableOrUnknown(data['address_en']!, _addressEnMeta),
      );
    }
    if (data.containsKey('address_bn')) {
      context.handle(
        _addressBnMeta,
        addressBn.isAcceptableOrUnknown(data['address_bn']!, _addressBnMeta),
      );
    }
    if (data.containsKey('area_id')) {
      context.handle(
        _areaIdMeta,
        areaId.isAcceptableOrUnknown(data['area_id']!, _areaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_areaIdMeta);
    }
    if (data.containsKey('mobile')) {
      context.handle(
        _mobileMeta,
        mobile.isAcceptableOrUnknown(data['mobile']!, _mobileMeta),
      );
    } else if (isInserting) {
      context.missing(_mobileMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DistributorEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DistributorEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_bn'],
      )!,
      designation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}designation'],
      ),
      addressEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_en'],
      ),
      addressBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_bn'],
      ),
      areaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}area_id'],
      )!,
      mobile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mobile'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DistributorsTable createAlias(String alias) {
    return $DistributorsTable(attachedDatabase, alias);
  }
}

class DistributorEntity extends DataClass
    implements Insertable<DistributorEntity> {
  final int id;
  final String nameEn;
  final String nameBn;
  final String? designation;
  final String? addressEn;
  final String? addressBn;
  final int areaId;
  final String mobile;
  final int isActive;
  final String createdAt;
  final String updatedAt;
  const DistributorEntity({
    required this.id,
    required this.nameEn,
    required this.nameBn,
    this.designation,
    this.addressEn,
    this.addressBn,
    required this.areaId,
    required this.mobile,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name_en'] = Variable<String>(nameEn);
    map['name_bn'] = Variable<String>(nameBn);
    if (!nullToAbsent || designation != null) {
      map['designation'] = Variable<String>(designation);
    }
    if (!nullToAbsent || addressEn != null) {
      map['address_en'] = Variable<String>(addressEn);
    }
    if (!nullToAbsent || addressBn != null) {
      map['address_bn'] = Variable<String>(addressBn);
    }
    map['area_id'] = Variable<int>(areaId);
    map['mobile'] = Variable<String>(mobile);
    map['is_active'] = Variable<int>(isActive);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  DistributorsCompanion toCompanion(bool nullToAbsent) {
    return DistributorsCompanion(
      id: Value(id),
      nameEn: Value(nameEn),
      nameBn: Value(nameBn),
      designation: designation == null && nullToAbsent
          ? const Value.absent()
          : Value(designation),
      addressEn: addressEn == null && nullToAbsent
          ? const Value.absent()
          : Value(addressEn),
      addressBn: addressBn == null && nullToAbsent
          ? const Value.absent()
          : Value(addressBn),
      areaId: Value(areaId),
      mobile: Value(mobile),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DistributorEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DistributorEntity(
      id: serializer.fromJson<int>(json['id']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameBn: serializer.fromJson<String>(json['nameBn']),
      designation: serializer.fromJson<String?>(json['designation']),
      addressEn: serializer.fromJson<String?>(json['addressEn']),
      addressBn: serializer.fromJson<String?>(json['addressBn']),
      areaId: serializer.fromJson<int>(json['areaId']),
      mobile: serializer.fromJson<String>(json['mobile']),
      isActive: serializer.fromJson<int>(json['isActive']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameBn': serializer.toJson<String>(nameBn),
      'designation': serializer.toJson<String?>(designation),
      'addressEn': serializer.toJson<String?>(addressEn),
      'addressBn': serializer.toJson<String?>(addressBn),
      'areaId': serializer.toJson<int>(areaId),
      'mobile': serializer.toJson<String>(mobile),
      'isActive': serializer.toJson<int>(isActive),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  DistributorEntity copyWith({
    int? id,
    String? nameEn,
    String? nameBn,
    Value<String?> designation = const Value.absent(),
    Value<String?> addressEn = const Value.absent(),
    Value<String?> addressBn = const Value.absent(),
    int? areaId,
    String? mobile,
    int? isActive,
    String? createdAt,
    String? updatedAt,
  }) => DistributorEntity(
    id: id ?? this.id,
    nameEn: nameEn ?? this.nameEn,
    nameBn: nameBn ?? this.nameBn,
    designation: designation.present ? designation.value : this.designation,
    addressEn: addressEn.present ? addressEn.value : this.addressEn,
    addressBn: addressBn.present ? addressBn.value : this.addressBn,
    areaId: areaId ?? this.areaId,
    mobile: mobile ?? this.mobile,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DistributorEntity copyWithCompanion(DistributorsCompanion data) {
    return DistributorEntity(
      id: data.id.present ? data.id.value : this.id,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameBn: data.nameBn.present ? data.nameBn.value : this.nameBn,
      designation: data.designation.present
          ? data.designation.value
          : this.designation,
      addressEn: data.addressEn.present ? data.addressEn.value : this.addressEn,
      addressBn: data.addressBn.present ? data.addressBn.value : this.addressBn,
      areaId: data.areaId.present ? data.areaId.value : this.areaId,
      mobile: data.mobile.present ? data.mobile.value : this.mobile,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DistributorEntity(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn, ')
          ..write('designation: $designation, ')
          ..write('addressEn: $addressEn, ')
          ..write('addressBn: $addressBn, ')
          ..write('areaId: $areaId, ')
          ..write('mobile: $mobile, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nameEn,
    nameBn,
    designation,
    addressEn,
    addressBn,
    areaId,
    mobile,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DistributorEntity &&
          other.id == this.id &&
          other.nameEn == this.nameEn &&
          other.nameBn == this.nameBn &&
          other.designation == this.designation &&
          other.addressEn == this.addressEn &&
          other.addressBn == this.addressBn &&
          other.areaId == this.areaId &&
          other.mobile == this.mobile &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DistributorsCompanion extends UpdateCompanion<DistributorEntity> {
  final Value<int> id;
  final Value<String> nameEn;
  final Value<String> nameBn;
  final Value<String?> designation;
  final Value<String?> addressEn;
  final Value<String?> addressBn;
  final Value<int> areaId;
  final Value<String> mobile;
  final Value<int> isActive;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const DistributorsCompanion({
    this.id = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameBn = const Value.absent(),
    this.designation = const Value.absent(),
    this.addressEn = const Value.absent(),
    this.addressBn = const Value.absent(),
    this.areaId = const Value.absent(),
    this.mobile = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DistributorsCompanion.insert({
    this.id = const Value.absent(),
    required String nameEn,
    required String nameBn,
    this.designation = const Value.absent(),
    this.addressEn = const Value.absent(),
    this.addressBn = const Value.absent(),
    required int areaId,
    required String mobile,
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : nameEn = Value(nameEn),
       nameBn = Value(nameBn),
       areaId = Value(areaId),
       mobile = Value(mobile);
  static Insertable<DistributorEntity> custom({
    Expression<int>? id,
    Expression<String>? nameEn,
    Expression<String>? nameBn,
    Expression<String>? designation,
    Expression<String>? addressEn,
    Expression<String>? addressBn,
    Expression<int>? areaId,
    Expression<String>? mobile,
    Expression<int>? isActive,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameEn != null) 'name_en': nameEn,
      if (nameBn != null) 'name_bn': nameBn,
      if (designation != null) 'designation': designation,
      if (addressEn != null) 'address_en': addressEn,
      if (addressBn != null) 'address_bn': addressBn,
      if (areaId != null) 'area_id': areaId,
      if (mobile != null) 'mobile': mobile,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  DistributorsCompanion copyWith({
    Value<int>? id,
    Value<String>? nameEn,
    Value<String>? nameBn,
    Value<String?>? designation,
    Value<String?>? addressEn,
    Value<String?>? addressBn,
    Value<int>? areaId,
    Value<String>? mobile,
    Value<int>? isActive,
    Value<String>? createdAt,
    Value<String>? updatedAt,
  }) {
    return DistributorsCompanion(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameBn: nameBn ?? this.nameBn,
      designation: designation ?? this.designation,
      addressEn: addressEn ?? this.addressEn,
      addressBn: addressBn ?? this.addressBn,
      areaId: areaId ?? this.areaId,
      mobile: mobile ?? this.mobile,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameBn.present) {
      map['name_bn'] = Variable<String>(nameBn.value);
    }
    if (designation.present) {
      map['designation'] = Variable<String>(designation.value);
    }
    if (addressEn.present) {
      map['address_en'] = Variable<String>(addressEn.value);
    }
    if (addressBn.present) {
      map['address_bn'] = Variable<String>(addressBn.value);
    }
    if (areaId.present) {
      map['area_id'] = Variable<int>(areaId.value);
    }
    if (mobile.present) {
      map['mobile'] = Variable<String>(mobile.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<int>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DistributorsCompanion(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn, ')
          ..write('designation: $designation, ')
          ..write('addressEn: $addressEn, ')
          ..write('addressBn: $addressBn, ')
          ..write('areaId: $areaId, ')
          ..write('mobile: $mobile, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SalesPersonnelTable extends SalesPersonnel
    with TableInfo<$SalesPersonnelTable, SalesPersonnelEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesPersonnelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameBnMeta = const VerificationMeta('nameBn');
  @override
  late final GeneratedColumn<String> nameBn = GeneratedColumn<String>(
    'name_bn',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _designationMeta = const VerificationMeta(
    'designation',
  );
  @override
  late final GeneratedColumn<String> designation = GeneratedColumn<String>(
    'designation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mobileMeta = const VerificationMeta('mobile');
  @override
  late final GeneratedColumn<String> mobile = GeneratedColumn<String>(
    'mobile',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _employeeIdMeta = const VerificationMeta(
    'employeeId',
  );
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
    'employee_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<int> isActive = GeneratedColumn<int>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toIso8601String(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toIso8601String(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nameEn,
    nameBn,
    designation,
    photoUrl,
    mobile,
    email,
    employeeId,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales_personnel';
  @override
  VerificationContext validateIntegrity(
    Insertable<SalesPersonnelEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_bn')) {
      context.handle(
        _nameBnMeta,
        nameBn.isAcceptableOrUnknown(data['name_bn']!, _nameBnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameBnMeta);
    }
    if (data.containsKey('designation')) {
      context.handle(
        _designationMeta,
        designation.isAcceptableOrUnknown(
          data['designation']!,
          _designationMeta,
        ),
      );
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    }
    if (data.containsKey('mobile')) {
      context.handle(
        _mobileMeta,
        mobile.isAcceptableOrUnknown(data['mobile']!, _mobileMeta),
      );
    } else if (isInserting) {
      context.missing(_mobileMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('employee_id')) {
      context.handle(
        _employeeIdMeta,
        employeeId.isAcceptableOrUnknown(data['employee_id']!, _employeeIdMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SalesPersonnelEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SalesPersonnelEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_bn'],
      )!,
      designation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}designation'],
      ),
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      ),
      mobile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mobile'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      employeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}employee_id'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SalesPersonnelTable createAlias(String alias) {
    return $SalesPersonnelTable(attachedDatabase, alias);
  }
}

class SalesPersonnelEntity extends DataClass
    implements Insertable<SalesPersonnelEntity> {
  final int id;
  final String nameEn;
  final String nameBn;
  final String? designation;
  final String? photoUrl;
  final String mobile;
  final String? email;
  final String? employeeId;
  final int isActive;
  final String createdAt;
  final String updatedAt;
  const SalesPersonnelEntity({
    required this.id,
    required this.nameEn,
    required this.nameBn,
    this.designation,
    this.photoUrl,
    required this.mobile,
    this.email,
    this.employeeId,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name_en'] = Variable<String>(nameEn);
    map['name_bn'] = Variable<String>(nameBn);
    if (!nullToAbsent || designation != null) {
      map['designation'] = Variable<String>(designation);
    }
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    map['mobile'] = Variable<String>(mobile);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || employeeId != null) {
      map['employee_id'] = Variable<String>(employeeId);
    }
    map['is_active'] = Variable<int>(isActive);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  SalesPersonnelCompanion toCompanion(bool nullToAbsent) {
    return SalesPersonnelCompanion(
      id: Value(id),
      nameEn: Value(nameEn),
      nameBn: Value(nameBn),
      designation: designation == null && nullToAbsent
          ? const Value.absent()
          : Value(designation),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      mobile: Value(mobile),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      employeeId: employeeId == null && nullToAbsent
          ? const Value.absent()
          : Value(employeeId),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SalesPersonnelEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SalesPersonnelEntity(
      id: serializer.fromJson<int>(json['id']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameBn: serializer.fromJson<String>(json['nameBn']),
      designation: serializer.fromJson<String?>(json['designation']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      mobile: serializer.fromJson<String>(json['mobile']),
      email: serializer.fromJson<String?>(json['email']),
      employeeId: serializer.fromJson<String?>(json['employeeId']),
      isActive: serializer.fromJson<int>(json['isActive']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameBn': serializer.toJson<String>(nameBn),
      'designation': serializer.toJson<String?>(designation),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'mobile': serializer.toJson<String>(mobile),
      'email': serializer.toJson<String?>(email),
      'employeeId': serializer.toJson<String?>(employeeId),
      'isActive': serializer.toJson<int>(isActive),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  SalesPersonnelEntity copyWith({
    int? id,
    String? nameEn,
    String? nameBn,
    Value<String?> designation = const Value.absent(),
    Value<String?> photoUrl = const Value.absent(),
    String? mobile,
    Value<String?> email = const Value.absent(),
    Value<String?> employeeId = const Value.absent(),
    int? isActive,
    String? createdAt,
    String? updatedAt,
  }) => SalesPersonnelEntity(
    id: id ?? this.id,
    nameEn: nameEn ?? this.nameEn,
    nameBn: nameBn ?? this.nameBn,
    designation: designation.present ? designation.value : this.designation,
    photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
    mobile: mobile ?? this.mobile,
    email: email.present ? email.value : this.email,
    employeeId: employeeId.present ? employeeId.value : this.employeeId,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SalesPersonnelEntity copyWithCompanion(SalesPersonnelCompanion data) {
    return SalesPersonnelEntity(
      id: data.id.present ? data.id.value : this.id,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameBn: data.nameBn.present ? data.nameBn.value : this.nameBn,
      designation: data.designation.present
          ? data.designation.value
          : this.designation,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      mobile: data.mobile.present ? data.mobile.value : this.mobile,
      email: data.email.present ? data.email.value : this.email,
      employeeId: data.employeeId.present
          ? data.employeeId.value
          : this.employeeId,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SalesPersonnelEntity(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn, ')
          ..write('designation: $designation, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('mobile: $mobile, ')
          ..write('email: $email, ')
          ..write('employeeId: $employeeId, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nameEn,
    nameBn,
    designation,
    photoUrl,
    mobile,
    email,
    employeeId,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalesPersonnelEntity &&
          other.id == this.id &&
          other.nameEn == this.nameEn &&
          other.nameBn == this.nameBn &&
          other.designation == this.designation &&
          other.photoUrl == this.photoUrl &&
          other.mobile == this.mobile &&
          other.email == this.email &&
          other.employeeId == this.employeeId &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SalesPersonnelCompanion extends UpdateCompanion<SalesPersonnelEntity> {
  final Value<int> id;
  final Value<String> nameEn;
  final Value<String> nameBn;
  final Value<String?> designation;
  final Value<String?> photoUrl;
  final Value<String> mobile;
  final Value<String?> email;
  final Value<String?> employeeId;
  final Value<int> isActive;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const SalesPersonnelCompanion({
    this.id = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameBn = const Value.absent(),
    this.designation = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.mobile = const Value.absent(),
    this.email = const Value.absent(),
    this.employeeId = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SalesPersonnelCompanion.insert({
    this.id = const Value.absent(),
    required String nameEn,
    required String nameBn,
    this.designation = const Value.absent(),
    this.photoUrl = const Value.absent(),
    required String mobile,
    this.email = const Value.absent(),
    this.employeeId = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : nameEn = Value(nameEn),
       nameBn = Value(nameBn),
       mobile = Value(mobile);
  static Insertable<SalesPersonnelEntity> custom({
    Expression<int>? id,
    Expression<String>? nameEn,
    Expression<String>? nameBn,
    Expression<String>? designation,
    Expression<String>? photoUrl,
    Expression<String>? mobile,
    Expression<String>? email,
    Expression<String>? employeeId,
    Expression<int>? isActive,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameEn != null) 'name_en': nameEn,
      if (nameBn != null) 'name_bn': nameBn,
      if (designation != null) 'designation': designation,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (mobile != null) 'mobile': mobile,
      if (email != null) 'email': email,
      if (employeeId != null) 'employee_id': employeeId,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SalesPersonnelCompanion copyWith({
    Value<int>? id,
    Value<String>? nameEn,
    Value<String>? nameBn,
    Value<String?>? designation,
    Value<String?>? photoUrl,
    Value<String>? mobile,
    Value<String?>? email,
    Value<String?>? employeeId,
    Value<int>? isActive,
    Value<String>? createdAt,
    Value<String>? updatedAt,
  }) {
    return SalesPersonnelCompanion(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameBn: nameBn ?? this.nameBn,
      designation: designation ?? this.designation,
      photoUrl: photoUrl ?? this.photoUrl,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      employeeId: employeeId ?? this.employeeId,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameBn.present) {
      map['name_bn'] = Variable<String>(nameBn.value);
    }
    if (designation.present) {
      map['designation'] = Variable<String>(designation.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (mobile.present) {
      map['mobile'] = Variable<String>(mobile.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (employeeId.present) {
      map['employee_id'] = Variable<String>(employeeId.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<int>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesPersonnelCompanion(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn, ')
          ..write('designation: $designation, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('mobile: $mobile, ')
          ..write('email: $email, ')
          ..write('employeeId: $employeeId, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SalesPersonnelAreasTable extends SalesPersonnelAreas
    with TableInfo<$SalesPersonnelAreasTable, SalesPersonnelArea> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesPersonnelAreasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _salesPersonnelIdMeta = const VerificationMeta(
    'salesPersonnelId',
  );
  @override
  late final GeneratedColumn<int> salesPersonnelId = GeneratedColumn<int>(
    'sales_personnel_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints:
        'NOT NULL REFERENCES sales_personnel(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _areaIdMeta = const VerificationMeta('areaId');
  @override
  late final GeneratedColumn<int> areaId = GeneratedColumn<int>(
    'area_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES areas(id)',
  );
  @override
  List<GeneratedColumn> get $columns => [salesPersonnelId, areaId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales_personnel_areas';
  @override
  VerificationContext validateIntegrity(
    Insertable<SalesPersonnelArea> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('sales_personnel_id')) {
      context.handle(
        _salesPersonnelIdMeta,
        salesPersonnelId.isAcceptableOrUnknown(
          data['sales_personnel_id']!,
          _salesPersonnelIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_salesPersonnelIdMeta);
    }
    if (data.containsKey('area_id')) {
      context.handle(
        _areaIdMeta,
        areaId.isAcceptableOrUnknown(data['area_id']!, _areaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_areaIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {salesPersonnelId, areaId};
  @override
  SalesPersonnelArea map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SalesPersonnelArea(
      salesPersonnelId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sales_personnel_id'],
      )!,
      areaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}area_id'],
      )!,
    );
  }

  @override
  $SalesPersonnelAreasTable createAlias(String alias) {
    return $SalesPersonnelAreasTable(attachedDatabase, alias);
  }
}

class SalesPersonnelArea extends DataClass
    implements Insertable<SalesPersonnelArea> {
  final int salesPersonnelId;
  final int areaId;
  const SalesPersonnelArea({
    required this.salesPersonnelId,
    required this.areaId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['sales_personnel_id'] = Variable<int>(salesPersonnelId);
    map['area_id'] = Variable<int>(areaId);
    return map;
  }

  SalesPersonnelAreasCompanion toCompanion(bool nullToAbsent) {
    return SalesPersonnelAreasCompanion(
      salesPersonnelId: Value(salesPersonnelId),
      areaId: Value(areaId),
    );
  }

  factory SalesPersonnelArea.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SalesPersonnelArea(
      salesPersonnelId: serializer.fromJson<int>(json['salesPersonnelId']),
      areaId: serializer.fromJson<int>(json['areaId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'salesPersonnelId': serializer.toJson<int>(salesPersonnelId),
      'areaId': serializer.toJson<int>(areaId),
    };
  }

  SalesPersonnelArea copyWith({int? salesPersonnelId, int? areaId}) =>
      SalesPersonnelArea(
        salesPersonnelId: salesPersonnelId ?? this.salesPersonnelId,
        areaId: areaId ?? this.areaId,
      );
  SalesPersonnelArea copyWithCompanion(SalesPersonnelAreasCompanion data) {
    return SalesPersonnelArea(
      salesPersonnelId: data.salesPersonnelId.present
          ? data.salesPersonnelId.value
          : this.salesPersonnelId,
      areaId: data.areaId.present ? data.areaId.value : this.areaId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SalesPersonnelArea(')
          ..write('salesPersonnelId: $salesPersonnelId, ')
          ..write('areaId: $areaId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(salesPersonnelId, areaId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SalesPersonnelArea &&
          other.salesPersonnelId == this.salesPersonnelId &&
          other.areaId == this.areaId);
}

class SalesPersonnelAreasCompanion extends UpdateCompanion<SalesPersonnelArea> {
  final Value<int> salesPersonnelId;
  final Value<int> areaId;
  final Value<int> rowid;
  const SalesPersonnelAreasCompanion({
    this.salesPersonnelId = const Value.absent(),
    this.areaId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SalesPersonnelAreasCompanion.insert({
    required int salesPersonnelId,
    required int areaId,
    this.rowid = const Value.absent(),
  }) : salesPersonnelId = Value(salesPersonnelId),
       areaId = Value(areaId);
  static Insertable<SalesPersonnelArea> custom({
    Expression<int>? salesPersonnelId,
    Expression<int>? areaId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (salesPersonnelId != null) 'sales_personnel_id': salesPersonnelId,
      if (areaId != null) 'area_id': areaId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SalesPersonnelAreasCompanion copyWith({
    Value<int>? salesPersonnelId,
    Value<int>? areaId,
    Value<int>? rowid,
  }) {
    return SalesPersonnelAreasCompanion(
      salesPersonnelId: salesPersonnelId ?? this.salesPersonnelId,
      areaId: areaId ?? this.areaId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (salesPersonnelId.present) {
      map['sales_personnel_id'] = Variable<int>(salesPersonnelId.value);
    }
    if (areaId.present) {
      map['area_id'] = Variable<int>(areaId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesPersonnelAreasCompanion(')
          ..write('salesPersonnelId: $salesPersonnelId, ')
          ..write('areaId: $areaId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VetDoctorsTable extends VetDoctors
    with TableInfo<$VetDoctorsTable, VetDoctorEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VetDoctorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameBnMeta = const VerificationMeta('nameBn');
  @override
  late final GeneratedColumn<String> nameBn = GeneratedColumn<String>(
    'name_bn',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _qualificationMeta = const VerificationMeta(
    'qualification',
  );
  @override
  late final GeneratedColumn<String> qualification = GeneratedColumn<String>(
    'qualification',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _specializationMeta = const VerificationMeta(
    'specialization',
  );
  @override
  late final GeneratedColumn<String> specialization = GeneratedColumn<String>(
    'specialization',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bvcRegistrationNoMeta = const VerificationMeta(
    'bvcRegistrationNo',
  );
  @override
  late final GeneratedColumn<String> bvcRegistrationNo =
      GeneratedColumn<String>(
        'bvc_registration_no',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _clinicOrHospitalNameEnMeta =
      const VerificationMeta('clinicOrHospitalNameEn');
  @override
  late final GeneratedColumn<String> clinicOrHospitalNameEn =
      GeneratedColumn<String>(
        'clinic_or_hospital_name_en',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _clinicOrHospitalNameBnMeta =
      const VerificationMeta('clinicOrHospitalNameBn');
  @override
  late final GeneratedColumn<String> clinicOrHospitalNameBn =
      GeneratedColumn<String>(
        'clinic_or_hospital_name_bn',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _addressEnMeta = const VerificationMeta(
    'addressEn',
  );
  @override
  late final GeneratedColumn<String> addressEn = GeneratedColumn<String>(
    'address_en',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressBnMeta = const VerificationMeta(
    'addressBn',
  );
  @override
  late final GeneratedColumn<String> addressBn = GeneratedColumn<String>(
    'address_bn',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mobileMeta = const VerificationMeta('mobile');
  @override
  late final GeneratedColumn<String> mobile = GeneratedColumn<String>(
    'mobile',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<int> isActive = GeneratedColumn<int>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toIso8601String(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toIso8601String(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nameEn,
    nameBn,
    photoUrl,
    qualification,
    specialization,
    bvcRegistrationNo,
    clinicOrHospitalNameEn,
    clinicOrHospitalNameBn,
    addressEn,
    addressBn,
    mobile,
    email,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vet_doctors';
  @override
  VerificationContext validateIntegrity(
    Insertable<VetDoctorEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_bn')) {
      context.handle(
        _nameBnMeta,
        nameBn.isAcceptableOrUnknown(data['name_bn']!, _nameBnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameBnMeta);
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    }
    if (data.containsKey('qualification')) {
      context.handle(
        _qualificationMeta,
        qualification.isAcceptableOrUnknown(
          data['qualification']!,
          _qualificationMeta,
        ),
      );
    }
    if (data.containsKey('specialization')) {
      context.handle(
        _specializationMeta,
        specialization.isAcceptableOrUnknown(
          data['specialization']!,
          _specializationMeta,
        ),
      );
    }
    if (data.containsKey('bvc_registration_no')) {
      context.handle(
        _bvcRegistrationNoMeta,
        bvcRegistrationNo.isAcceptableOrUnknown(
          data['bvc_registration_no']!,
          _bvcRegistrationNoMeta,
        ),
      );
    }
    if (data.containsKey('clinic_or_hospital_name_en')) {
      context.handle(
        _clinicOrHospitalNameEnMeta,
        clinicOrHospitalNameEn.isAcceptableOrUnknown(
          data['clinic_or_hospital_name_en']!,
          _clinicOrHospitalNameEnMeta,
        ),
      );
    }
    if (data.containsKey('clinic_or_hospital_name_bn')) {
      context.handle(
        _clinicOrHospitalNameBnMeta,
        clinicOrHospitalNameBn.isAcceptableOrUnknown(
          data['clinic_or_hospital_name_bn']!,
          _clinicOrHospitalNameBnMeta,
        ),
      );
    }
    if (data.containsKey('address_en')) {
      context.handle(
        _addressEnMeta,
        addressEn.isAcceptableOrUnknown(data['address_en']!, _addressEnMeta),
      );
    }
    if (data.containsKey('address_bn')) {
      context.handle(
        _addressBnMeta,
        addressBn.isAcceptableOrUnknown(data['address_bn']!, _addressBnMeta),
      );
    }
    if (data.containsKey('mobile')) {
      context.handle(
        _mobileMeta,
        mobile.isAcceptableOrUnknown(data['mobile']!, _mobileMeta),
      );
    } else if (isInserting) {
      context.missing(_mobileMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VetDoctorEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VetDoctorEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_bn'],
      )!,
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      ),
      qualification: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}qualification'],
      ),
      specialization: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}specialization'],
      ),
      bvcRegistrationNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bvc_registration_no'],
      ),
      clinicOrHospitalNameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clinic_or_hospital_name_en'],
      ),
      clinicOrHospitalNameBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clinic_or_hospital_name_bn'],
      ),
      addressEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_en'],
      ),
      addressBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_bn'],
      ),
      mobile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mobile'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $VetDoctorsTable createAlias(String alias) {
    return $VetDoctorsTable(attachedDatabase, alias);
  }
}

class VetDoctorEntity extends DataClass implements Insertable<VetDoctorEntity> {
  final int id;
  final String nameEn;
  final String nameBn;
  final String? photoUrl;
  final String? qualification;
  final String? specialization;
  final String? bvcRegistrationNo;
  final String? clinicOrHospitalNameEn;
  final String? clinicOrHospitalNameBn;
  final String? addressEn;
  final String? addressBn;
  final String mobile;
  final String? email;
  final int isActive;
  final String createdAt;
  final String updatedAt;
  const VetDoctorEntity({
    required this.id,
    required this.nameEn,
    required this.nameBn,
    this.photoUrl,
    this.qualification,
    this.specialization,
    this.bvcRegistrationNo,
    this.clinicOrHospitalNameEn,
    this.clinicOrHospitalNameBn,
    this.addressEn,
    this.addressBn,
    required this.mobile,
    this.email,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name_en'] = Variable<String>(nameEn);
    map['name_bn'] = Variable<String>(nameBn);
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    if (!nullToAbsent || qualification != null) {
      map['qualification'] = Variable<String>(qualification);
    }
    if (!nullToAbsent || specialization != null) {
      map['specialization'] = Variable<String>(specialization);
    }
    if (!nullToAbsent || bvcRegistrationNo != null) {
      map['bvc_registration_no'] = Variable<String>(bvcRegistrationNo);
    }
    if (!nullToAbsent || clinicOrHospitalNameEn != null) {
      map['clinic_or_hospital_name_en'] = Variable<String>(
        clinicOrHospitalNameEn,
      );
    }
    if (!nullToAbsent || clinicOrHospitalNameBn != null) {
      map['clinic_or_hospital_name_bn'] = Variable<String>(
        clinicOrHospitalNameBn,
      );
    }
    if (!nullToAbsent || addressEn != null) {
      map['address_en'] = Variable<String>(addressEn);
    }
    if (!nullToAbsent || addressBn != null) {
      map['address_bn'] = Variable<String>(addressBn);
    }
    map['mobile'] = Variable<String>(mobile);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    map['is_active'] = Variable<int>(isActive);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  VetDoctorsCompanion toCompanion(bool nullToAbsent) {
    return VetDoctorsCompanion(
      id: Value(id),
      nameEn: Value(nameEn),
      nameBn: Value(nameBn),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      qualification: qualification == null && nullToAbsent
          ? const Value.absent()
          : Value(qualification),
      specialization: specialization == null && nullToAbsent
          ? const Value.absent()
          : Value(specialization),
      bvcRegistrationNo: bvcRegistrationNo == null && nullToAbsent
          ? const Value.absent()
          : Value(bvcRegistrationNo),
      clinicOrHospitalNameEn: clinicOrHospitalNameEn == null && nullToAbsent
          ? const Value.absent()
          : Value(clinicOrHospitalNameEn),
      clinicOrHospitalNameBn: clinicOrHospitalNameBn == null && nullToAbsent
          ? const Value.absent()
          : Value(clinicOrHospitalNameBn),
      addressEn: addressEn == null && nullToAbsent
          ? const Value.absent()
          : Value(addressEn),
      addressBn: addressBn == null && nullToAbsent
          ? const Value.absent()
          : Value(addressBn),
      mobile: Value(mobile),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory VetDoctorEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VetDoctorEntity(
      id: serializer.fromJson<int>(json['id']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameBn: serializer.fromJson<String>(json['nameBn']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      qualification: serializer.fromJson<String?>(json['qualification']),
      specialization: serializer.fromJson<String?>(json['specialization']),
      bvcRegistrationNo: serializer.fromJson<String?>(
        json['bvcRegistrationNo'],
      ),
      clinicOrHospitalNameEn: serializer.fromJson<String?>(
        json['clinicOrHospitalNameEn'],
      ),
      clinicOrHospitalNameBn: serializer.fromJson<String?>(
        json['clinicOrHospitalNameBn'],
      ),
      addressEn: serializer.fromJson<String?>(json['addressEn']),
      addressBn: serializer.fromJson<String?>(json['addressBn']),
      mobile: serializer.fromJson<String>(json['mobile']),
      email: serializer.fromJson<String?>(json['email']),
      isActive: serializer.fromJson<int>(json['isActive']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameBn': serializer.toJson<String>(nameBn),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'qualification': serializer.toJson<String?>(qualification),
      'specialization': serializer.toJson<String?>(specialization),
      'bvcRegistrationNo': serializer.toJson<String?>(bvcRegistrationNo),
      'clinicOrHospitalNameEn': serializer.toJson<String?>(
        clinicOrHospitalNameEn,
      ),
      'clinicOrHospitalNameBn': serializer.toJson<String?>(
        clinicOrHospitalNameBn,
      ),
      'addressEn': serializer.toJson<String?>(addressEn),
      'addressBn': serializer.toJson<String?>(addressBn),
      'mobile': serializer.toJson<String>(mobile),
      'email': serializer.toJson<String?>(email),
      'isActive': serializer.toJson<int>(isActive),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  VetDoctorEntity copyWith({
    int? id,
    String? nameEn,
    String? nameBn,
    Value<String?> photoUrl = const Value.absent(),
    Value<String?> qualification = const Value.absent(),
    Value<String?> specialization = const Value.absent(),
    Value<String?> bvcRegistrationNo = const Value.absent(),
    Value<String?> clinicOrHospitalNameEn = const Value.absent(),
    Value<String?> clinicOrHospitalNameBn = const Value.absent(),
    Value<String?> addressEn = const Value.absent(),
    Value<String?> addressBn = const Value.absent(),
    String? mobile,
    Value<String?> email = const Value.absent(),
    int? isActive,
    String? createdAt,
    String? updatedAt,
  }) => VetDoctorEntity(
    id: id ?? this.id,
    nameEn: nameEn ?? this.nameEn,
    nameBn: nameBn ?? this.nameBn,
    photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
    qualification: qualification.present
        ? qualification.value
        : this.qualification,
    specialization: specialization.present
        ? specialization.value
        : this.specialization,
    bvcRegistrationNo: bvcRegistrationNo.present
        ? bvcRegistrationNo.value
        : this.bvcRegistrationNo,
    clinicOrHospitalNameEn: clinicOrHospitalNameEn.present
        ? clinicOrHospitalNameEn.value
        : this.clinicOrHospitalNameEn,
    clinicOrHospitalNameBn: clinicOrHospitalNameBn.present
        ? clinicOrHospitalNameBn.value
        : this.clinicOrHospitalNameBn,
    addressEn: addressEn.present ? addressEn.value : this.addressEn,
    addressBn: addressBn.present ? addressBn.value : this.addressBn,
    mobile: mobile ?? this.mobile,
    email: email.present ? email.value : this.email,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  VetDoctorEntity copyWithCompanion(VetDoctorsCompanion data) {
    return VetDoctorEntity(
      id: data.id.present ? data.id.value : this.id,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameBn: data.nameBn.present ? data.nameBn.value : this.nameBn,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      qualification: data.qualification.present
          ? data.qualification.value
          : this.qualification,
      specialization: data.specialization.present
          ? data.specialization.value
          : this.specialization,
      bvcRegistrationNo: data.bvcRegistrationNo.present
          ? data.bvcRegistrationNo.value
          : this.bvcRegistrationNo,
      clinicOrHospitalNameEn: data.clinicOrHospitalNameEn.present
          ? data.clinicOrHospitalNameEn.value
          : this.clinicOrHospitalNameEn,
      clinicOrHospitalNameBn: data.clinicOrHospitalNameBn.present
          ? data.clinicOrHospitalNameBn.value
          : this.clinicOrHospitalNameBn,
      addressEn: data.addressEn.present ? data.addressEn.value : this.addressEn,
      addressBn: data.addressBn.present ? data.addressBn.value : this.addressBn,
      mobile: data.mobile.present ? data.mobile.value : this.mobile,
      email: data.email.present ? data.email.value : this.email,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VetDoctorEntity(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('qualification: $qualification, ')
          ..write('specialization: $specialization, ')
          ..write('bvcRegistrationNo: $bvcRegistrationNo, ')
          ..write('clinicOrHospitalNameEn: $clinicOrHospitalNameEn, ')
          ..write('clinicOrHospitalNameBn: $clinicOrHospitalNameBn, ')
          ..write('addressEn: $addressEn, ')
          ..write('addressBn: $addressBn, ')
          ..write('mobile: $mobile, ')
          ..write('email: $email, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nameEn,
    nameBn,
    photoUrl,
    qualification,
    specialization,
    bvcRegistrationNo,
    clinicOrHospitalNameEn,
    clinicOrHospitalNameBn,
    addressEn,
    addressBn,
    mobile,
    email,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VetDoctorEntity &&
          other.id == this.id &&
          other.nameEn == this.nameEn &&
          other.nameBn == this.nameBn &&
          other.photoUrl == this.photoUrl &&
          other.qualification == this.qualification &&
          other.specialization == this.specialization &&
          other.bvcRegistrationNo == this.bvcRegistrationNo &&
          other.clinicOrHospitalNameEn == this.clinicOrHospitalNameEn &&
          other.clinicOrHospitalNameBn == this.clinicOrHospitalNameBn &&
          other.addressEn == this.addressEn &&
          other.addressBn == this.addressBn &&
          other.mobile == this.mobile &&
          other.email == this.email &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class VetDoctorsCompanion extends UpdateCompanion<VetDoctorEntity> {
  final Value<int> id;
  final Value<String> nameEn;
  final Value<String> nameBn;
  final Value<String?> photoUrl;
  final Value<String?> qualification;
  final Value<String?> specialization;
  final Value<String?> bvcRegistrationNo;
  final Value<String?> clinicOrHospitalNameEn;
  final Value<String?> clinicOrHospitalNameBn;
  final Value<String?> addressEn;
  final Value<String?> addressBn;
  final Value<String> mobile;
  final Value<String?> email;
  final Value<int> isActive;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const VetDoctorsCompanion({
    this.id = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameBn = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.qualification = const Value.absent(),
    this.specialization = const Value.absent(),
    this.bvcRegistrationNo = const Value.absent(),
    this.clinicOrHospitalNameEn = const Value.absent(),
    this.clinicOrHospitalNameBn = const Value.absent(),
    this.addressEn = const Value.absent(),
    this.addressBn = const Value.absent(),
    this.mobile = const Value.absent(),
    this.email = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  VetDoctorsCompanion.insert({
    this.id = const Value.absent(),
    required String nameEn,
    required String nameBn,
    this.photoUrl = const Value.absent(),
    this.qualification = const Value.absent(),
    this.specialization = const Value.absent(),
    this.bvcRegistrationNo = const Value.absent(),
    this.clinicOrHospitalNameEn = const Value.absent(),
    this.clinicOrHospitalNameBn = const Value.absent(),
    this.addressEn = const Value.absent(),
    this.addressBn = const Value.absent(),
    required String mobile,
    this.email = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : nameEn = Value(nameEn),
       nameBn = Value(nameBn),
       mobile = Value(mobile);
  static Insertable<VetDoctorEntity> custom({
    Expression<int>? id,
    Expression<String>? nameEn,
    Expression<String>? nameBn,
    Expression<String>? photoUrl,
    Expression<String>? qualification,
    Expression<String>? specialization,
    Expression<String>? bvcRegistrationNo,
    Expression<String>? clinicOrHospitalNameEn,
    Expression<String>? clinicOrHospitalNameBn,
    Expression<String>? addressEn,
    Expression<String>? addressBn,
    Expression<String>? mobile,
    Expression<String>? email,
    Expression<int>? isActive,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameEn != null) 'name_en': nameEn,
      if (nameBn != null) 'name_bn': nameBn,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (qualification != null) 'qualification': qualification,
      if (specialization != null) 'specialization': specialization,
      if (bvcRegistrationNo != null) 'bvc_registration_no': bvcRegistrationNo,
      if (clinicOrHospitalNameEn != null)
        'clinic_or_hospital_name_en': clinicOrHospitalNameEn,
      if (clinicOrHospitalNameBn != null)
        'clinic_or_hospital_name_bn': clinicOrHospitalNameBn,
      if (addressEn != null) 'address_en': addressEn,
      if (addressBn != null) 'address_bn': addressBn,
      if (mobile != null) 'mobile': mobile,
      if (email != null) 'email': email,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  VetDoctorsCompanion copyWith({
    Value<int>? id,
    Value<String>? nameEn,
    Value<String>? nameBn,
    Value<String?>? photoUrl,
    Value<String?>? qualification,
    Value<String?>? specialization,
    Value<String?>? bvcRegistrationNo,
    Value<String?>? clinicOrHospitalNameEn,
    Value<String?>? clinicOrHospitalNameBn,
    Value<String?>? addressEn,
    Value<String?>? addressBn,
    Value<String>? mobile,
    Value<String?>? email,
    Value<int>? isActive,
    Value<String>? createdAt,
    Value<String>? updatedAt,
  }) {
    return VetDoctorsCompanion(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameBn: nameBn ?? this.nameBn,
      photoUrl: photoUrl ?? this.photoUrl,
      qualification: qualification ?? this.qualification,
      specialization: specialization ?? this.specialization,
      bvcRegistrationNo: bvcRegistrationNo ?? this.bvcRegistrationNo,
      clinicOrHospitalNameEn:
          clinicOrHospitalNameEn ?? this.clinicOrHospitalNameEn,
      clinicOrHospitalNameBn:
          clinicOrHospitalNameBn ?? this.clinicOrHospitalNameBn,
      addressEn: addressEn ?? this.addressEn,
      addressBn: addressBn ?? this.addressBn,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameBn.present) {
      map['name_bn'] = Variable<String>(nameBn.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (qualification.present) {
      map['qualification'] = Variable<String>(qualification.value);
    }
    if (specialization.present) {
      map['specialization'] = Variable<String>(specialization.value);
    }
    if (bvcRegistrationNo.present) {
      map['bvc_registration_no'] = Variable<String>(bvcRegistrationNo.value);
    }
    if (clinicOrHospitalNameEn.present) {
      map['clinic_or_hospital_name_en'] = Variable<String>(
        clinicOrHospitalNameEn.value,
      );
    }
    if (clinicOrHospitalNameBn.present) {
      map['clinic_or_hospital_name_bn'] = Variable<String>(
        clinicOrHospitalNameBn.value,
      );
    }
    if (addressEn.present) {
      map['address_en'] = Variable<String>(addressEn.value);
    }
    if (addressBn.present) {
      map['address_bn'] = Variable<String>(addressBn.value);
    }
    if (mobile.present) {
      map['mobile'] = Variable<String>(mobile.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<int>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VetDoctorsCompanion(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameBn: $nameBn, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('qualification: $qualification, ')
          ..write('specialization: $specialization, ')
          ..write('bvcRegistrationNo: $bvcRegistrationNo, ')
          ..write('clinicOrHospitalNameEn: $clinicOrHospitalNameEn, ')
          ..write('clinicOrHospitalNameBn: $clinicOrHospitalNameBn, ')
          ..write('addressEn: $addressEn, ')
          ..write('addressBn: $addressBn, ')
          ..write('mobile: $mobile, ')
          ..write('email: $email, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $VetDoctorsAreasTable extends VetDoctorsAreas
    with TableInfo<$VetDoctorsAreasTable, VetDoctorsArea> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VetDoctorsAreasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _vetDoctorIdMeta = const VerificationMeta(
    'vetDoctorId',
  );
  @override
  late final GeneratedColumn<int> vetDoctorId = GeneratedColumn<int>(
    'vet_doctor_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES vet_doctors(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _areaIdMeta = const VerificationMeta('areaId');
  @override
  late final GeneratedColumn<int> areaId = GeneratedColumn<int>(
    'area_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES areas(id)',
  );
  @override
  List<GeneratedColumn> get $columns => [vetDoctorId, areaId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vet_doctors_areas';
  @override
  VerificationContext validateIntegrity(
    Insertable<VetDoctorsArea> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('vet_doctor_id')) {
      context.handle(
        _vetDoctorIdMeta,
        vetDoctorId.isAcceptableOrUnknown(
          data['vet_doctor_id']!,
          _vetDoctorIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_vetDoctorIdMeta);
    }
    if (data.containsKey('area_id')) {
      context.handle(
        _areaIdMeta,
        areaId.isAcceptableOrUnknown(data['area_id']!, _areaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_areaIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {vetDoctorId, areaId};
  @override
  VetDoctorsArea map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VetDoctorsArea(
      vetDoctorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vet_doctor_id'],
      )!,
      areaId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}area_id'],
      )!,
    );
  }

  @override
  $VetDoctorsAreasTable createAlias(String alias) {
    return $VetDoctorsAreasTable(attachedDatabase, alias);
  }
}

class VetDoctorsArea extends DataClass implements Insertable<VetDoctorsArea> {
  final int vetDoctorId;
  final int areaId;
  const VetDoctorsArea({required this.vetDoctorId, required this.areaId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['vet_doctor_id'] = Variable<int>(vetDoctorId);
    map['area_id'] = Variable<int>(areaId);
    return map;
  }

  VetDoctorsAreasCompanion toCompanion(bool nullToAbsent) {
    return VetDoctorsAreasCompanion(
      vetDoctorId: Value(vetDoctorId),
      areaId: Value(areaId),
    );
  }

  factory VetDoctorsArea.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VetDoctorsArea(
      vetDoctorId: serializer.fromJson<int>(json['vetDoctorId']),
      areaId: serializer.fromJson<int>(json['areaId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'vetDoctorId': serializer.toJson<int>(vetDoctorId),
      'areaId': serializer.toJson<int>(areaId),
    };
  }

  VetDoctorsArea copyWith({int? vetDoctorId, int? areaId}) => VetDoctorsArea(
    vetDoctorId: vetDoctorId ?? this.vetDoctorId,
    areaId: areaId ?? this.areaId,
  );
  VetDoctorsArea copyWithCompanion(VetDoctorsAreasCompanion data) {
    return VetDoctorsArea(
      vetDoctorId: data.vetDoctorId.present
          ? data.vetDoctorId.value
          : this.vetDoctorId,
      areaId: data.areaId.present ? data.areaId.value : this.areaId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VetDoctorsArea(')
          ..write('vetDoctorId: $vetDoctorId, ')
          ..write('areaId: $areaId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(vetDoctorId, areaId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VetDoctorsArea &&
          other.vetDoctorId == this.vetDoctorId &&
          other.areaId == this.areaId);
}

class VetDoctorsAreasCompanion extends UpdateCompanion<VetDoctorsArea> {
  final Value<int> vetDoctorId;
  final Value<int> areaId;
  final Value<int> rowid;
  const VetDoctorsAreasCompanion({
    this.vetDoctorId = const Value.absent(),
    this.areaId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VetDoctorsAreasCompanion.insert({
    required int vetDoctorId,
    required int areaId,
    this.rowid = const Value.absent(),
  }) : vetDoctorId = Value(vetDoctorId),
       areaId = Value(areaId);
  static Insertable<VetDoctorsArea> custom({
    Expression<int>? vetDoctorId,
    Expression<int>? areaId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (vetDoctorId != null) 'vet_doctor_id': vetDoctorId,
      if (areaId != null) 'area_id': areaId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VetDoctorsAreasCompanion copyWith({
    Value<int>? vetDoctorId,
    Value<int>? areaId,
    Value<int>? rowid,
  }) {
    return VetDoctorsAreasCompanion(
      vetDoctorId: vetDoctorId ?? this.vetDoctorId,
      areaId: areaId ?? this.areaId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (vetDoctorId.present) {
      map['vet_doctor_id'] = Variable<int>(vetDoctorId.value);
    }
    if (areaId.present) {
      map['area_id'] = Variable<int>(areaId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VetDoctorsAreasCompanion(')
          ..write('vetDoctorId: $vetDoctorId, ')
          ..write('areaId: $areaId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$DistributorsDb extends GeneratedDatabase {
  _$DistributorsDb(QueryExecutor e) : super(e);
  $DistributorsDbManager get managers => $DistributorsDbManager(this);
  late final $RegionsTable regions = $RegionsTable(this);
  late final $AreasTable areas = $AreasTable(this);
  late final $DistributorsTable distributors = $DistributorsTable(this);
  late final $SalesPersonnelTable salesPersonnel = $SalesPersonnelTable(this);
  late final $SalesPersonnelAreasTable salesPersonnelAreas =
      $SalesPersonnelAreasTable(this);
  late final $VetDoctorsTable vetDoctors = $VetDoctorsTable(this);
  late final $VetDoctorsAreasTable vetDoctorsAreas = $VetDoctorsAreasTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    regions,
    areas,
    distributors,
    salesPersonnel,
    salesPersonnelAreas,
    vetDoctors,
    vetDoctorsAreas,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sales_personnel',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sales_personnel_areas', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vet_doctors',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('vet_doctors_areas', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$RegionsTableCreateCompanionBuilder =
    RegionsCompanion Function({
      Value<int> id,
      required String nameEn,
      required String nameBn,
    });
typedef $$RegionsTableUpdateCompanionBuilder =
    RegionsCompanion Function({
      Value<int> id,
      Value<String> nameEn,
      Value<String> nameBn,
    });

final class $$RegionsTableReferences
    extends BaseReferences<_$DistributorsDb, $RegionsTable, RegionEntity> {
  $$RegionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AreasTable, List<AreaEntity>> _areasRefsTable(
    _$DistributorsDb db,
  ) => MultiTypedResultKey.fromTable(
    db.areas,
    aliasName: 'regions__id__areas__region_id',
  );

  $$AreasTableProcessedTableManager get areasRefs {
    final manager = $$AreasTableTableManager(
      $_db,
      $_db.areas,
    ).filter((f) => f.regionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_areasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RegionsTableFilterComposer
    extends Composer<_$DistributorsDb, $RegionsTable> {
  $$RegionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> areasRefs(
    Expression<bool> Function($$AreasTableFilterComposer f) f,
  ) {
    final $$AreasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.areas,
      getReferencedColumn: (t) => t.regionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreasTableFilterComposer(
            $db: $db,
            $table: $db.areas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RegionsTableOrderingComposer
    extends Composer<_$DistributorsDb, $RegionsTable> {
  $$RegionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RegionsTableAnnotationComposer
    extends Composer<_$DistributorsDb, $RegionsTable> {
  $$RegionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameBn =>
      $composableBuilder(column: $table.nameBn, builder: (column) => column);

  Expression<T> areasRefs<T extends Object>(
    Expression<T> Function($$AreasTableAnnotationComposer a) f,
  ) {
    final $$AreasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.areas,
      getReferencedColumn: (t) => t.regionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreasTableAnnotationComposer(
            $db: $db,
            $table: $db.areas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RegionsTableTableManager
    extends
        RootTableManager<
          _$DistributorsDb,
          $RegionsTable,
          RegionEntity,
          $$RegionsTableFilterComposer,
          $$RegionsTableOrderingComposer,
          $$RegionsTableAnnotationComposer,
          $$RegionsTableCreateCompanionBuilder,
          $$RegionsTableUpdateCompanionBuilder,
          (RegionEntity, $$RegionsTableReferences),
          RegionEntity,
          PrefetchHooks Function({bool areasRefs})
        > {
  $$RegionsTableTableManager(_$DistributorsDb db, $RegionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RegionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RegionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RegionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> nameBn = const Value.absent(),
              }) => RegionsCompanion(id: id, nameEn: nameEn, nameBn: nameBn),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nameEn,
                required String nameBn,
              }) => RegionsCompanion.insert(
                id: id,
                nameEn: nameEn,
                nameBn: nameBn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RegionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({areasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (areasRefs) db.areas],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (areasRefs)
                    await $_getPrefetchedData<
                      RegionEntity,
                      $RegionsTable,
                      AreaEntity
                    >(
                      currentTable: table,
                      referencedTable: $$RegionsTableReferences._areasRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$RegionsTableReferences(db, table, p0).areasRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.regionId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RegionsTableProcessedTableManager =
    ProcessedTableManager<
      _$DistributorsDb,
      $RegionsTable,
      RegionEntity,
      $$RegionsTableFilterComposer,
      $$RegionsTableOrderingComposer,
      $$RegionsTableAnnotationComposer,
      $$RegionsTableCreateCompanionBuilder,
      $$RegionsTableUpdateCompanionBuilder,
      (RegionEntity, $$RegionsTableReferences),
      RegionEntity,
      PrefetchHooks Function({bool areasRefs})
    >;
typedef $$AreasTableCreateCompanionBuilder =
    AreasCompanion Function({
      Value<int> id,
      required int regionId,
      required String nameEn,
      required String nameBn,
    });
typedef $$AreasTableUpdateCompanionBuilder =
    AreasCompanion Function({
      Value<int> id,
      Value<int> regionId,
      Value<String> nameEn,
      Value<String> nameBn,
    });

final class $$AreasTableReferences
    extends BaseReferences<_$DistributorsDb, $AreasTable, AreaEntity> {
  $$AreasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RegionsTable _regionIdTable(_$DistributorsDb db) =>
      db.regions.createAlias('areas__region_id__regions__id');

  $$RegionsTableProcessedTableManager get regionId {
    final $_column = $_itemColumn<int>('region_id')!;

    final manager = $$RegionsTableTableManager(
      $_db,
      $_db.regions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_regionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DistributorsTable, List<DistributorEntity>>
  _distributorsRefsTable(_$DistributorsDb db) => MultiTypedResultKey.fromTable(
    db.distributors,
    aliasName: 'areas__id__distributors__area_id',
  );

  $$DistributorsTableProcessedTableManager get distributorsRefs {
    final manager = $$DistributorsTableTableManager(
      $_db,
      $_db.distributors,
    ).filter((f) => f.areaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_distributorsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $SalesPersonnelAreasTable,
    List<SalesPersonnelArea>
  >
  _salesPersonnelAreasRefsTable(_$DistributorsDb db) =>
      MultiTypedResultKey.fromTable(
        db.salesPersonnelAreas,
        aliasName: 'areas__id__sales_personnel_areas__area_id',
      );

  $$SalesPersonnelAreasTableProcessedTableManager get salesPersonnelAreasRefs {
    final manager = $$SalesPersonnelAreasTableTableManager(
      $_db,
      $_db.salesPersonnelAreas,
    ).filter((f) => f.areaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _salesPersonnelAreasRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VetDoctorsAreasTable, List<VetDoctorsArea>>
  _vetDoctorsAreasRefsTable(_$DistributorsDb db) =>
      MultiTypedResultKey.fromTable(
        db.vetDoctorsAreas,
        aliasName: 'areas__id__vet_doctors_areas__area_id',
      );

  $$VetDoctorsAreasTableProcessedTableManager get vetDoctorsAreasRefs {
    final manager = $$VetDoctorsAreasTableTableManager(
      $_db,
      $_db.vetDoctorsAreas,
    ).filter((f) => f.areaId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _vetDoctorsAreasRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AreasTableFilterComposer
    extends Composer<_$DistributorsDb, $AreasTable> {
  $$AreasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnFilters(column),
  );

  $$RegionsTableFilterComposer get regionId {
    final $$RegionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.regionId,
      referencedTable: $db.regions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RegionsTableFilterComposer(
            $db: $db,
            $table: $db.regions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> distributorsRefs(
    Expression<bool> Function($$DistributorsTableFilterComposer f) f,
  ) {
    final $$DistributorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.distributors,
      getReferencedColumn: (t) => t.areaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DistributorsTableFilterComposer(
            $db: $db,
            $table: $db.distributors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> salesPersonnelAreasRefs(
    Expression<bool> Function($$SalesPersonnelAreasTableFilterComposer f) f,
  ) {
    final $$SalesPersonnelAreasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.salesPersonnelAreas,
      getReferencedColumn: (t) => t.areaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesPersonnelAreasTableFilterComposer(
            $db: $db,
            $table: $db.salesPersonnelAreas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> vetDoctorsAreasRefs(
    Expression<bool> Function($$VetDoctorsAreasTableFilterComposer f) f,
  ) {
    final $$VetDoctorsAreasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vetDoctorsAreas,
      getReferencedColumn: (t) => t.areaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VetDoctorsAreasTableFilterComposer(
            $db: $db,
            $table: $db.vetDoctorsAreas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AreasTableOrderingComposer
    extends Composer<_$DistributorsDb, $AreasTable> {
  $$AreasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnOrderings(column),
  );

  $$RegionsTableOrderingComposer get regionId {
    final $$RegionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.regionId,
      referencedTable: $db.regions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RegionsTableOrderingComposer(
            $db: $db,
            $table: $db.regions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AreasTableAnnotationComposer
    extends Composer<_$DistributorsDb, $AreasTable> {
  $$AreasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameBn =>
      $composableBuilder(column: $table.nameBn, builder: (column) => column);

  $$RegionsTableAnnotationComposer get regionId {
    final $$RegionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.regionId,
      referencedTable: $db.regions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RegionsTableAnnotationComposer(
            $db: $db,
            $table: $db.regions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> distributorsRefs<T extends Object>(
    Expression<T> Function($$DistributorsTableAnnotationComposer a) f,
  ) {
    final $$DistributorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.distributors,
      getReferencedColumn: (t) => t.areaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DistributorsTableAnnotationComposer(
            $db: $db,
            $table: $db.distributors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> salesPersonnelAreasRefs<T extends Object>(
    Expression<T> Function($$SalesPersonnelAreasTableAnnotationComposer a) f,
  ) {
    final $$SalesPersonnelAreasTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.salesPersonnelAreas,
          getReferencedColumn: (t) => t.areaId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SalesPersonnelAreasTableAnnotationComposer(
                $db: $db,
                $table: $db.salesPersonnelAreas,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> vetDoctorsAreasRefs<T extends Object>(
    Expression<T> Function($$VetDoctorsAreasTableAnnotationComposer a) f,
  ) {
    final $$VetDoctorsAreasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vetDoctorsAreas,
      getReferencedColumn: (t) => t.areaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VetDoctorsAreasTableAnnotationComposer(
            $db: $db,
            $table: $db.vetDoctorsAreas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AreasTableTableManager
    extends
        RootTableManager<
          _$DistributorsDb,
          $AreasTable,
          AreaEntity,
          $$AreasTableFilterComposer,
          $$AreasTableOrderingComposer,
          $$AreasTableAnnotationComposer,
          $$AreasTableCreateCompanionBuilder,
          $$AreasTableUpdateCompanionBuilder,
          (AreaEntity, $$AreasTableReferences),
          AreaEntity,
          PrefetchHooks Function({
            bool regionId,
            bool distributorsRefs,
            bool salesPersonnelAreasRefs,
            bool vetDoctorsAreasRefs,
          })
        > {
  $$AreasTableTableManager(_$DistributorsDb db, $AreasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AreasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AreasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AreasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> regionId = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> nameBn = const Value.absent(),
              }) => AreasCompanion(
                id: id,
                regionId: regionId,
                nameEn: nameEn,
                nameBn: nameBn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int regionId,
                required String nameEn,
                required String nameBn,
              }) => AreasCompanion.insert(
                id: id,
                regionId: regionId,
                nameEn: nameEn,
                nameBn: nameBn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$AreasTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                regionId = false,
                distributorsRefs = false,
                salesPersonnelAreasRefs = false,
                vetDoctorsAreasRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (distributorsRefs) db.distributors,
                    if (salesPersonnelAreasRefs) db.salesPersonnelAreas,
                    if (vetDoctorsAreasRefs) db.vetDoctorsAreas,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (regionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.regionId,
                                    referencedTable: $$AreasTableReferences
                                        ._regionIdTable(db),
                                    referencedColumn: $$AreasTableReferences
                                        ._regionIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (distributorsRefs)
                        await $_getPrefetchedData<
                          AreaEntity,
                          $AreasTable,
                          DistributorEntity
                        >(
                          currentTable: table,
                          referencedTable: $$AreasTableReferences
                              ._distributorsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AreasTableReferences(
                                db,
                                table,
                                p0,
                              ).distributorsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.areaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (salesPersonnelAreasRefs)
                        await $_getPrefetchedData<
                          AreaEntity,
                          $AreasTable,
                          SalesPersonnelArea
                        >(
                          currentTable: table,
                          referencedTable: $$AreasTableReferences
                              ._salesPersonnelAreasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AreasTableReferences(
                                db,
                                table,
                                p0,
                              ).salesPersonnelAreasRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.areaId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (vetDoctorsAreasRefs)
                        await $_getPrefetchedData<
                          AreaEntity,
                          $AreasTable,
                          VetDoctorsArea
                        >(
                          currentTable: table,
                          referencedTable: $$AreasTableReferences
                              ._vetDoctorsAreasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AreasTableReferences(
                                db,
                                table,
                                p0,
                              ).vetDoctorsAreasRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.areaId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AreasTableProcessedTableManager =
    ProcessedTableManager<
      _$DistributorsDb,
      $AreasTable,
      AreaEntity,
      $$AreasTableFilterComposer,
      $$AreasTableOrderingComposer,
      $$AreasTableAnnotationComposer,
      $$AreasTableCreateCompanionBuilder,
      $$AreasTableUpdateCompanionBuilder,
      (AreaEntity, $$AreasTableReferences),
      AreaEntity,
      PrefetchHooks Function({
        bool regionId,
        bool distributorsRefs,
        bool salesPersonnelAreasRefs,
        bool vetDoctorsAreasRefs,
      })
    >;
typedef $$DistributorsTableCreateCompanionBuilder =
    DistributorsCompanion Function({
      Value<int> id,
      required String nameEn,
      required String nameBn,
      Value<String?> designation,
      Value<String?> addressEn,
      Value<String?> addressBn,
      required int areaId,
      required String mobile,
      Value<int> isActive,
      Value<String> createdAt,
      Value<String> updatedAt,
    });
typedef $$DistributorsTableUpdateCompanionBuilder =
    DistributorsCompanion Function({
      Value<int> id,
      Value<String> nameEn,
      Value<String> nameBn,
      Value<String?> designation,
      Value<String?> addressEn,
      Value<String?> addressBn,
      Value<int> areaId,
      Value<String> mobile,
      Value<int> isActive,
      Value<String> createdAt,
      Value<String> updatedAt,
    });

final class $$DistributorsTableReferences
    extends
        BaseReferences<
          _$DistributorsDb,
          $DistributorsTable,
          DistributorEntity
        > {
  $$DistributorsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AreasTable _areaIdTable(_$DistributorsDb db) =>
      db.areas.createAlias('distributors__area_id__areas__id');

  $$AreasTableProcessedTableManager get areaId {
    final $_column = $_itemColumn<int>('area_id')!;

    final manager = $$AreasTableTableManager(
      $_db,
      $_db.areas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_areaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DistributorsTableFilterComposer
    extends Composer<_$DistributorsDb, $DistributorsTable> {
  $$DistributorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get designation => $composableBuilder(
    column: $table.designation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addressEn => $composableBuilder(
    column: $table.addressEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addressBn => $composableBuilder(
    column: $table.addressBn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mobile => $composableBuilder(
    column: $table.mobile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AreasTableFilterComposer get areaId {
    final $$AreasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.areaId,
      referencedTable: $db.areas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreasTableFilterComposer(
            $db: $db,
            $table: $db.areas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DistributorsTableOrderingComposer
    extends Composer<_$DistributorsDb, $DistributorsTable> {
  $$DistributorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get designation => $composableBuilder(
    column: $table.designation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addressEn => $composableBuilder(
    column: $table.addressEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addressBn => $composableBuilder(
    column: $table.addressBn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mobile => $composableBuilder(
    column: $table.mobile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AreasTableOrderingComposer get areaId {
    final $$AreasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.areaId,
      referencedTable: $db.areas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreasTableOrderingComposer(
            $db: $db,
            $table: $db.areas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DistributorsTableAnnotationComposer
    extends Composer<_$DistributorsDb, $DistributorsTable> {
  $$DistributorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameBn =>
      $composableBuilder(column: $table.nameBn, builder: (column) => column);

  GeneratedColumn<String> get designation => $composableBuilder(
    column: $table.designation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get addressEn =>
      $composableBuilder(column: $table.addressEn, builder: (column) => column);

  GeneratedColumn<String> get addressBn =>
      $composableBuilder(column: $table.addressBn, builder: (column) => column);

  GeneratedColumn<String> get mobile =>
      $composableBuilder(column: $table.mobile, builder: (column) => column);

  GeneratedColumn<int> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$AreasTableAnnotationComposer get areaId {
    final $$AreasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.areaId,
      referencedTable: $db.areas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreasTableAnnotationComposer(
            $db: $db,
            $table: $db.areas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DistributorsTableTableManager
    extends
        RootTableManager<
          _$DistributorsDb,
          $DistributorsTable,
          DistributorEntity,
          $$DistributorsTableFilterComposer,
          $$DistributorsTableOrderingComposer,
          $$DistributorsTableAnnotationComposer,
          $$DistributorsTableCreateCompanionBuilder,
          $$DistributorsTableUpdateCompanionBuilder,
          (DistributorEntity, $$DistributorsTableReferences),
          DistributorEntity,
          PrefetchHooks Function({bool areaId})
        > {
  $$DistributorsTableTableManager(_$DistributorsDb db, $DistributorsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DistributorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DistributorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DistributorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> nameBn = const Value.absent(),
                Value<String?> designation = const Value.absent(),
                Value<String?> addressEn = const Value.absent(),
                Value<String?> addressBn = const Value.absent(),
                Value<int> areaId = const Value.absent(),
                Value<String> mobile = const Value.absent(),
                Value<int> isActive = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
              }) => DistributorsCompanion(
                id: id,
                nameEn: nameEn,
                nameBn: nameBn,
                designation: designation,
                addressEn: addressEn,
                addressBn: addressBn,
                areaId: areaId,
                mobile: mobile,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nameEn,
                required String nameBn,
                Value<String?> designation = const Value.absent(),
                Value<String?> addressEn = const Value.absent(),
                Value<String?> addressBn = const Value.absent(),
                required int areaId,
                required String mobile,
                Value<int> isActive = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
              }) => DistributorsCompanion.insert(
                id: id,
                nameEn: nameEn,
                nameBn: nameBn,
                designation: designation,
                addressEn: addressEn,
                addressBn: addressBn,
                areaId: areaId,
                mobile: mobile,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DistributorsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({areaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (areaId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.areaId,
                                referencedTable: $$DistributorsTableReferences
                                    ._areaIdTable(db),
                                referencedColumn: $$DistributorsTableReferences
                                    ._areaIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DistributorsTableProcessedTableManager =
    ProcessedTableManager<
      _$DistributorsDb,
      $DistributorsTable,
      DistributorEntity,
      $$DistributorsTableFilterComposer,
      $$DistributorsTableOrderingComposer,
      $$DistributorsTableAnnotationComposer,
      $$DistributorsTableCreateCompanionBuilder,
      $$DistributorsTableUpdateCompanionBuilder,
      (DistributorEntity, $$DistributorsTableReferences),
      DistributorEntity,
      PrefetchHooks Function({bool areaId})
    >;
typedef $$SalesPersonnelTableCreateCompanionBuilder =
    SalesPersonnelCompanion Function({
      Value<int> id,
      required String nameEn,
      required String nameBn,
      Value<String?> designation,
      Value<String?> photoUrl,
      required String mobile,
      Value<String?> email,
      Value<String?> employeeId,
      Value<int> isActive,
      Value<String> createdAt,
      Value<String> updatedAt,
    });
typedef $$SalesPersonnelTableUpdateCompanionBuilder =
    SalesPersonnelCompanion Function({
      Value<int> id,
      Value<String> nameEn,
      Value<String> nameBn,
      Value<String?> designation,
      Value<String?> photoUrl,
      Value<String> mobile,
      Value<String?> email,
      Value<String?> employeeId,
      Value<int> isActive,
      Value<String> createdAt,
      Value<String> updatedAt,
    });

final class $$SalesPersonnelTableReferences
    extends
        BaseReferences<
          _$DistributorsDb,
          $SalesPersonnelTable,
          SalesPersonnelEntity
        > {
  $$SalesPersonnelTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $SalesPersonnelAreasTable,
    List<SalesPersonnelArea>
  >
  _salesPersonnelAreasRefsTable(_$DistributorsDb db) =>
      MultiTypedResultKey.fromTable(
        db.salesPersonnelAreas,
        aliasName:
            'sales_personnel__id__sales_personnel_areas__sales_personnel_id',
      );

  $$SalesPersonnelAreasTableProcessedTableManager get salesPersonnelAreasRefs {
    final manager = $$SalesPersonnelAreasTableTableManager(
      $_db,
      $_db.salesPersonnelAreas,
    ).filter((f) => f.salesPersonnelId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _salesPersonnelAreasRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SalesPersonnelTableFilterComposer
    extends Composer<_$DistributorsDb, $SalesPersonnelTable> {
  $$SalesPersonnelTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get designation => $composableBuilder(
    column: $table.designation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mobile => $composableBuilder(
    column: $table.mobile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get employeeId => $composableBuilder(
    column: $table.employeeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> salesPersonnelAreasRefs(
    Expression<bool> Function($$SalesPersonnelAreasTableFilterComposer f) f,
  ) {
    final $$SalesPersonnelAreasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.salesPersonnelAreas,
      getReferencedColumn: (t) => t.salesPersonnelId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesPersonnelAreasTableFilterComposer(
            $db: $db,
            $table: $db.salesPersonnelAreas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SalesPersonnelTableOrderingComposer
    extends Composer<_$DistributorsDb, $SalesPersonnelTable> {
  $$SalesPersonnelTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get designation => $composableBuilder(
    column: $table.designation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mobile => $composableBuilder(
    column: $table.mobile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get employeeId => $composableBuilder(
    column: $table.employeeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SalesPersonnelTableAnnotationComposer
    extends Composer<_$DistributorsDb, $SalesPersonnelTable> {
  $$SalesPersonnelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameBn =>
      $composableBuilder(column: $table.nameBn, builder: (column) => column);

  GeneratedColumn<String> get designation => $composableBuilder(
    column: $table.designation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<String> get mobile =>
      $composableBuilder(column: $table.mobile, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get employeeId => $composableBuilder(
    column: $table.employeeId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> salesPersonnelAreasRefs<T extends Object>(
    Expression<T> Function($$SalesPersonnelAreasTableAnnotationComposer a) f,
  ) {
    final $$SalesPersonnelAreasTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.salesPersonnelAreas,
          getReferencedColumn: (t) => t.salesPersonnelId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SalesPersonnelAreasTableAnnotationComposer(
                $db: $db,
                $table: $db.salesPersonnelAreas,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SalesPersonnelTableTableManager
    extends
        RootTableManager<
          _$DistributorsDb,
          $SalesPersonnelTable,
          SalesPersonnelEntity,
          $$SalesPersonnelTableFilterComposer,
          $$SalesPersonnelTableOrderingComposer,
          $$SalesPersonnelTableAnnotationComposer,
          $$SalesPersonnelTableCreateCompanionBuilder,
          $$SalesPersonnelTableUpdateCompanionBuilder,
          (SalesPersonnelEntity, $$SalesPersonnelTableReferences),
          SalesPersonnelEntity,
          PrefetchHooks Function({bool salesPersonnelAreasRefs})
        > {
  $$SalesPersonnelTableTableManager(
    _$DistributorsDb db,
    $SalesPersonnelTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesPersonnelTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesPersonnelTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SalesPersonnelTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> nameBn = const Value.absent(),
                Value<String?> designation = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<String> mobile = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> employeeId = const Value.absent(),
                Value<int> isActive = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
              }) => SalesPersonnelCompanion(
                id: id,
                nameEn: nameEn,
                nameBn: nameBn,
                designation: designation,
                photoUrl: photoUrl,
                mobile: mobile,
                email: email,
                employeeId: employeeId,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nameEn,
                required String nameBn,
                Value<String?> designation = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                required String mobile,
                Value<String?> email = const Value.absent(),
                Value<String?> employeeId = const Value.absent(),
                Value<int> isActive = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
              }) => SalesPersonnelCompanion.insert(
                id: id,
                nameEn: nameEn,
                nameBn: nameBn,
                designation: designation,
                photoUrl: photoUrl,
                mobile: mobile,
                email: email,
                employeeId: employeeId,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SalesPersonnelTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({salesPersonnelAreasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (salesPersonnelAreasRefs) db.salesPersonnelAreas,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (salesPersonnelAreasRefs)
                    await $_getPrefetchedData<
                      SalesPersonnelEntity,
                      $SalesPersonnelTable,
                      SalesPersonnelArea
                    >(
                      currentTable: table,
                      referencedTable: $$SalesPersonnelTableReferences
                          ._salesPersonnelAreasRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SalesPersonnelTableReferences(
                            db,
                            table,
                            p0,
                          ).salesPersonnelAreasRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.salesPersonnelId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SalesPersonnelTableProcessedTableManager =
    ProcessedTableManager<
      _$DistributorsDb,
      $SalesPersonnelTable,
      SalesPersonnelEntity,
      $$SalesPersonnelTableFilterComposer,
      $$SalesPersonnelTableOrderingComposer,
      $$SalesPersonnelTableAnnotationComposer,
      $$SalesPersonnelTableCreateCompanionBuilder,
      $$SalesPersonnelTableUpdateCompanionBuilder,
      (SalesPersonnelEntity, $$SalesPersonnelTableReferences),
      SalesPersonnelEntity,
      PrefetchHooks Function({bool salesPersonnelAreasRefs})
    >;
typedef $$SalesPersonnelAreasTableCreateCompanionBuilder =
    SalesPersonnelAreasCompanion Function({
      required int salesPersonnelId,
      required int areaId,
      Value<int> rowid,
    });
typedef $$SalesPersonnelAreasTableUpdateCompanionBuilder =
    SalesPersonnelAreasCompanion Function({
      Value<int> salesPersonnelId,
      Value<int> areaId,
      Value<int> rowid,
    });

final class $$SalesPersonnelAreasTableReferences
    extends
        BaseReferences<
          _$DistributorsDb,
          $SalesPersonnelAreasTable,
          SalesPersonnelArea
        > {
  $$SalesPersonnelAreasTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SalesPersonnelTable _salesPersonnelIdTable(_$DistributorsDb db) =>
      db.salesPersonnel.createAlias(
        'sales_personnel_areas__sales_personnel_id__sales_personnel__id',
      );

  $$SalesPersonnelTableProcessedTableManager get salesPersonnelId {
    final $_column = $_itemColumn<int>('sales_personnel_id')!;

    final manager = $$SalesPersonnelTableTableManager(
      $_db,
      $_db.salesPersonnel,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_salesPersonnelIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AreasTable _areaIdTable(_$DistributorsDb db) =>
      db.areas.createAlias('sales_personnel_areas__area_id__areas__id');

  $$AreasTableProcessedTableManager get areaId {
    final $_column = $_itemColumn<int>('area_id')!;

    final manager = $$AreasTableTableManager(
      $_db,
      $_db.areas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_areaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SalesPersonnelAreasTableFilterComposer
    extends Composer<_$DistributorsDb, $SalesPersonnelAreasTable> {
  $$SalesPersonnelAreasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SalesPersonnelTableFilterComposer get salesPersonnelId {
    final $$SalesPersonnelTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.salesPersonnelId,
      referencedTable: $db.salesPersonnel,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesPersonnelTableFilterComposer(
            $db: $db,
            $table: $db.salesPersonnel,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AreasTableFilterComposer get areaId {
    final $$AreasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.areaId,
      referencedTable: $db.areas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreasTableFilterComposer(
            $db: $db,
            $table: $db.areas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SalesPersonnelAreasTableOrderingComposer
    extends Composer<_$DistributorsDb, $SalesPersonnelAreasTable> {
  $$SalesPersonnelAreasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SalesPersonnelTableOrderingComposer get salesPersonnelId {
    final $$SalesPersonnelTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.salesPersonnelId,
      referencedTable: $db.salesPersonnel,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesPersonnelTableOrderingComposer(
            $db: $db,
            $table: $db.salesPersonnel,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AreasTableOrderingComposer get areaId {
    final $$AreasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.areaId,
      referencedTable: $db.areas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreasTableOrderingComposer(
            $db: $db,
            $table: $db.areas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SalesPersonnelAreasTableAnnotationComposer
    extends Composer<_$DistributorsDb, $SalesPersonnelAreasTable> {
  $$SalesPersonnelAreasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SalesPersonnelTableAnnotationComposer get salesPersonnelId {
    final $$SalesPersonnelTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.salesPersonnelId,
      referencedTable: $db.salesPersonnel,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SalesPersonnelTableAnnotationComposer(
            $db: $db,
            $table: $db.salesPersonnel,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AreasTableAnnotationComposer get areaId {
    final $$AreasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.areaId,
      referencedTable: $db.areas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreasTableAnnotationComposer(
            $db: $db,
            $table: $db.areas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SalesPersonnelAreasTableTableManager
    extends
        RootTableManager<
          _$DistributorsDb,
          $SalesPersonnelAreasTable,
          SalesPersonnelArea,
          $$SalesPersonnelAreasTableFilterComposer,
          $$SalesPersonnelAreasTableOrderingComposer,
          $$SalesPersonnelAreasTableAnnotationComposer,
          $$SalesPersonnelAreasTableCreateCompanionBuilder,
          $$SalesPersonnelAreasTableUpdateCompanionBuilder,
          (SalesPersonnelArea, $$SalesPersonnelAreasTableReferences),
          SalesPersonnelArea,
          PrefetchHooks Function({bool salesPersonnelId, bool areaId})
        > {
  $$SalesPersonnelAreasTableTableManager(
    _$DistributorsDb db,
    $SalesPersonnelAreasTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SalesPersonnelAreasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SalesPersonnelAreasTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SalesPersonnelAreasTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> salesPersonnelId = const Value.absent(),
                Value<int> areaId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SalesPersonnelAreasCompanion(
                salesPersonnelId: salesPersonnelId,
                areaId: areaId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int salesPersonnelId,
                required int areaId,
                Value<int> rowid = const Value.absent(),
              }) => SalesPersonnelAreasCompanion.insert(
                salesPersonnelId: salesPersonnelId,
                areaId: areaId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SalesPersonnelAreasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({salesPersonnelId = false, areaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (salesPersonnelId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.salesPersonnelId,
                                referencedTable:
                                    $$SalesPersonnelAreasTableReferences
                                        ._salesPersonnelIdTable(db),
                                referencedColumn:
                                    $$SalesPersonnelAreasTableReferences
                                        ._salesPersonnelIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (areaId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.areaId,
                                referencedTable:
                                    $$SalesPersonnelAreasTableReferences
                                        ._areaIdTable(db),
                                referencedColumn:
                                    $$SalesPersonnelAreasTableReferences
                                        ._areaIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SalesPersonnelAreasTableProcessedTableManager =
    ProcessedTableManager<
      _$DistributorsDb,
      $SalesPersonnelAreasTable,
      SalesPersonnelArea,
      $$SalesPersonnelAreasTableFilterComposer,
      $$SalesPersonnelAreasTableOrderingComposer,
      $$SalesPersonnelAreasTableAnnotationComposer,
      $$SalesPersonnelAreasTableCreateCompanionBuilder,
      $$SalesPersonnelAreasTableUpdateCompanionBuilder,
      (SalesPersonnelArea, $$SalesPersonnelAreasTableReferences),
      SalesPersonnelArea,
      PrefetchHooks Function({bool salesPersonnelId, bool areaId})
    >;
typedef $$VetDoctorsTableCreateCompanionBuilder =
    VetDoctorsCompanion Function({
      Value<int> id,
      required String nameEn,
      required String nameBn,
      Value<String?> photoUrl,
      Value<String?> qualification,
      Value<String?> specialization,
      Value<String?> bvcRegistrationNo,
      Value<String?> clinicOrHospitalNameEn,
      Value<String?> clinicOrHospitalNameBn,
      Value<String?> addressEn,
      Value<String?> addressBn,
      required String mobile,
      Value<String?> email,
      Value<int> isActive,
      Value<String> createdAt,
      Value<String> updatedAt,
    });
typedef $$VetDoctorsTableUpdateCompanionBuilder =
    VetDoctorsCompanion Function({
      Value<int> id,
      Value<String> nameEn,
      Value<String> nameBn,
      Value<String?> photoUrl,
      Value<String?> qualification,
      Value<String?> specialization,
      Value<String?> bvcRegistrationNo,
      Value<String?> clinicOrHospitalNameEn,
      Value<String?> clinicOrHospitalNameBn,
      Value<String?> addressEn,
      Value<String?> addressBn,
      Value<String> mobile,
      Value<String?> email,
      Value<int> isActive,
      Value<String> createdAt,
      Value<String> updatedAt,
    });

final class $$VetDoctorsTableReferences
    extends
        BaseReferences<_$DistributorsDb, $VetDoctorsTable, VetDoctorEntity> {
  $$VetDoctorsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$VetDoctorsAreasTable, List<VetDoctorsArea>>
  _vetDoctorsAreasRefsTable(_$DistributorsDb db) =>
      MultiTypedResultKey.fromTable(
        db.vetDoctorsAreas,
        aliasName: 'vet_doctors__id__vet_doctors_areas__vet_doctor_id',
      );

  $$VetDoctorsAreasTableProcessedTableManager get vetDoctorsAreasRefs {
    final manager = $$VetDoctorsAreasTableTableManager(
      $_db,
      $_db.vetDoctorsAreas,
    ).filter((f) => f.vetDoctorId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _vetDoctorsAreasRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VetDoctorsTableFilterComposer
    extends Composer<_$DistributorsDb, $VetDoctorsTable> {
  $$VetDoctorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qualification => $composableBuilder(
    column: $table.qualification,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get specialization => $composableBuilder(
    column: $table.specialization,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bvcRegistrationNo => $composableBuilder(
    column: $table.bvcRegistrationNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clinicOrHospitalNameEn => $composableBuilder(
    column: $table.clinicOrHospitalNameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clinicOrHospitalNameBn => $composableBuilder(
    column: $table.clinicOrHospitalNameBn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addressEn => $composableBuilder(
    column: $table.addressEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addressBn => $composableBuilder(
    column: $table.addressBn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mobile => $composableBuilder(
    column: $table.mobile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> vetDoctorsAreasRefs(
    Expression<bool> Function($$VetDoctorsAreasTableFilterComposer f) f,
  ) {
    final $$VetDoctorsAreasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vetDoctorsAreas,
      getReferencedColumn: (t) => t.vetDoctorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VetDoctorsAreasTableFilterComposer(
            $db: $db,
            $table: $db.vetDoctorsAreas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VetDoctorsTableOrderingComposer
    extends Composer<_$DistributorsDb, $VetDoctorsTable> {
  $$VetDoctorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameBn => $composableBuilder(
    column: $table.nameBn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qualification => $composableBuilder(
    column: $table.qualification,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get specialization => $composableBuilder(
    column: $table.specialization,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bvcRegistrationNo => $composableBuilder(
    column: $table.bvcRegistrationNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clinicOrHospitalNameEn => $composableBuilder(
    column: $table.clinicOrHospitalNameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clinicOrHospitalNameBn => $composableBuilder(
    column: $table.clinicOrHospitalNameBn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addressEn => $composableBuilder(
    column: $table.addressEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addressBn => $composableBuilder(
    column: $table.addressBn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mobile => $composableBuilder(
    column: $table.mobile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VetDoctorsTableAnnotationComposer
    extends Composer<_$DistributorsDb, $VetDoctorsTable> {
  $$VetDoctorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameBn =>
      $composableBuilder(column: $table.nameBn, builder: (column) => column);

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<String> get qualification => $composableBuilder(
    column: $table.qualification,
    builder: (column) => column,
  );

  GeneratedColumn<String> get specialization => $composableBuilder(
    column: $table.specialization,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bvcRegistrationNo => $composableBuilder(
    column: $table.bvcRegistrationNo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get clinicOrHospitalNameEn => $composableBuilder(
    column: $table.clinicOrHospitalNameEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get clinicOrHospitalNameBn => $composableBuilder(
    column: $table.clinicOrHospitalNameBn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get addressEn =>
      $composableBuilder(column: $table.addressEn, builder: (column) => column);

  GeneratedColumn<String> get addressBn =>
      $composableBuilder(column: $table.addressBn, builder: (column) => column);

  GeneratedColumn<String> get mobile =>
      $composableBuilder(column: $table.mobile, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<int> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> vetDoctorsAreasRefs<T extends Object>(
    Expression<T> Function($$VetDoctorsAreasTableAnnotationComposer a) f,
  ) {
    final $$VetDoctorsAreasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vetDoctorsAreas,
      getReferencedColumn: (t) => t.vetDoctorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VetDoctorsAreasTableAnnotationComposer(
            $db: $db,
            $table: $db.vetDoctorsAreas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VetDoctorsTableTableManager
    extends
        RootTableManager<
          _$DistributorsDb,
          $VetDoctorsTable,
          VetDoctorEntity,
          $$VetDoctorsTableFilterComposer,
          $$VetDoctorsTableOrderingComposer,
          $$VetDoctorsTableAnnotationComposer,
          $$VetDoctorsTableCreateCompanionBuilder,
          $$VetDoctorsTableUpdateCompanionBuilder,
          (VetDoctorEntity, $$VetDoctorsTableReferences),
          VetDoctorEntity,
          PrefetchHooks Function({bool vetDoctorsAreasRefs})
        > {
  $$VetDoctorsTableTableManager(_$DistributorsDb db, $VetDoctorsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VetDoctorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VetDoctorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VetDoctorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> nameBn = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<String?> qualification = const Value.absent(),
                Value<String?> specialization = const Value.absent(),
                Value<String?> bvcRegistrationNo = const Value.absent(),
                Value<String?> clinicOrHospitalNameEn = const Value.absent(),
                Value<String?> clinicOrHospitalNameBn = const Value.absent(),
                Value<String?> addressEn = const Value.absent(),
                Value<String?> addressBn = const Value.absent(),
                Value<String> mobile = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<int> isActive = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
              }) => VetDoctorsCompanion(
                id: id,
                nameEn: nameEn,
                nameBn: nameBn,
                photoUrl: photoUrl,
                qualification: qualification,
                specialization: specialization,
                bvcRegistrationNo: bvcRegistrationNo,
                clinicOrHospitalNameEn: clinicOrHospitalNameEn,
                clinicOrHospitalNameBn: clinicOrHospitalNameBn,
                addressEn: addressEn,
                addressBn: addressBn,
                mobile: mobile,
                email: email,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nameEn,
                required String nameBn,
                Value<String?> photoUrl = const Value.absent(),
                Value<String?> qualification = const Value.absent(),
                Value<String?> specialization = const Value.absent(),
                Value<String?> bvcRegistrationNo = const Value.absent(),
                Value<String?> clinicOrHospitalNameEn = const Value.absent(),
                Value<String?> clinicOrHospitalNameBn = const Value.absent(),
                Value<String?> addressEn = const Value.absent(),
                Value<String?> addressBn = const Value.absent(),
                required String mobile,
                Value<String?> email = const Value.absent(),
                Value<int> isActive = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
              }) => VetDoctorsCompanion.insert(
                id: id,
                nameEn: nameEn,
                nameBn: nameBn,
                photoUrl: photoUrl,
                qualification: qualification,
                specialization: specialization,
                bvcRegistrationNo: bvcRegistrationNo,
                clinicOrHospitalNameEn: clinicOrHospitalNameEn,
                clinicOrHospitalNameBn: clinicOrHospitalNameBn,
                addressEn: addressEn,
                addressBn: addressBn,
                mobile: mobile,
                email: email,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VetDoctorsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vetDoctorsAreasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (vetDoctorsAreasRefs) db.vetDoctorsAreas,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (vetDoctorsAreasRefs)
                    await $_getPrefetchedData<
                      VetDoctorEntity,
                      $VetDoctorsTable,
                      VetDoctorsArea
                    >(
                      currentTable: table,
                      referencedTable: $$VetDoctorsTableReferences
                          ._vetDoctorsAreasRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$VetDoctorsTableReferences(
                            db,
                            table,
                            p0,
                          ).vetDoctorsAreasRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.vetDoctorId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$VetDoctorsTableProcessedTableManager =
    ProcessedTableManager<
      _$DistributorsDb,
      $VetDoctorsTable,
      VetDoctorEntity,
      $$VetDoctorsTableFilterComposer,
      $$VetDoctorsTableOrderingComposer,
      $$VetDoctorsTableAnnotationComposer,
      $$VetDoctorsTableCreateCompanionBuilder,
      $$VetDoctorsTableUpdateCompanionBuilder,
      (VetDoctorEntity, $$VetDoctorsTableReferences),
      VetDoctorEntity,
      PrefetchHooks Function({bool vetDoctorsAreasRefs})
    >;
typedef $$VetDoctorsAreasTableCreateCompanionBuilder =
    VetDoctorsAreasCompanion Function({
      required int vetDoctorId,
      required int areaId,
      Value<int> rowid,
    });
typedef $$VetDoctorsAreasTableUpdateCompanionBuilder =
    VetDoctorsAreasCompanion Function({
      Value<int> vetDoctorId,
      Value<int> areaId,
      Value<int> rowid,
    });

final class $$VetDoctorsAreasTableReferences
    extends
        BaseReferences<
          _$DistributorsDb,
          $VetDoctorsAreasTable,
          VetDoctorsArea
        > {
  $$VetDoctorsAreasTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VetDoctorsTable _vetDoctorIdTable(_$DistributorsDb db) => db
      .vetDoctors
      .createAlias('vet_doctors_areas__vet_doctor_id__vet_doctors__id');

  $$VetDoctorsTableProcessedTableManager get vetDoctorId {
    final $_column = $_itemColumn<int>('vet_doctor_id')!;

    final manager = $$VetDoctorsTableTableManager(
      $_db,
      $_db.vetDoctors,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vetDoctorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AreasTable _areaIdTable(_$DistributorsDb db) =>
      db.areas.createAlias('vet_doctors_areas__area_id__areas__id');

  $$AreasTableProcessedTableManager get areaId {
    final $_column = $_itemColumn<int>('area_id')!;

    final manager = $$AreasTableTableManager(
      $_db,
      $_db.areas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_areaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VetDoctorsAreasTableFilterComposer
    extends Composer<_$DistributorsDb, $VetDoctorsAreasTable> {
  $$VetDoctorsAreasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$VetDoctorsTableFilterComposer get vetDoctorId {
    final $$VetDoctorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vetDoctorId,
      referencedTable: $db.vetDoctors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VetDoctorsTableFilterComposer(
            $db: $db,
            $table: $db.vetDoctors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AreasTableFilterComposer get areaId {
    final $$AreasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.areaId,
      referencedTable: $db.areas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreasTableFilterComposer(
            $db: $db,
            $table: $db.areas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VetDoctorsAreasTableOrderingComposer
    extends Composer<_$DistributorsDb, $VetDoctorsAreasTable> {
  $$VetDoctorsAreasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$VetDoctorsTableOrderingComposer get vetDoctorId {
    final $$VetDoctorsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vetDoctorId,
      referencedTable: $db.vetDoctors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VetDoctorsTableOrderingComposer(
            $db: $db,
            $table: $db.vetDoctors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AreasTableOrderingComposer get areaId {
    final $$AreasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.areaId,
      referencedTable: $db.areas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreasTableOrderingComposer(
            $db: $db,
            $table: $db.areas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VetDoctorsAreasTableAnnotationComposer
    extends Composer<_$DistributorsDb, $VetDoctorsAreasTable> {
  $$VetDoctorsAreasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$VetDoctorsTableAnnotationComposer get vetDoctorId {
    final $$VetDoctorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vetDoctorId,
      referencedTable: $db.vetDoctors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VetDoctorsTableAnnotationComposer(
            $db: $db,
            $table: $db.vetDoctors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AreasTableAnnotationComposer get areaId {
    final $$AreasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.areaId,
      referencedTable: $db.areas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AreasTableAnnotationComposer(
            $db: $db,
            $table: $db.areas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VetDoctorsAreasTableTableManager
    extends
        RootTableManager<
          _$DistributorsDb,
          $VetDoctorsAreasTable,
          VetDoctorsArea,
          $$VetDoctorsAreasTableFilterComposer,
          $$VetDoctorsAreasTableOrderingComposer,
          $$VetDoctorsAreasTableAnnotationComposer,
          $$VetDoctorsAreasTableCreateCompanionBuilder,
          $$VetDoctorsAreasTableUpdateCompanionBuilder,
          (VetDoctorsArea, $$VetDoctorsAreasTableReferences),
          VetDoctorsArea,
          PrefetchHooks Function({bool vetDoctorId, bool areaId})
        > {
  $$VetDoctorsAreasTableTableManager(
    _$DistributorsDb db,
    $VetDoctorsAreasTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VetDoctorsAreasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VetDoctorsAreasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VetDoctorsAreasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> vetDoctorId = const Value.absent(),
                Value<int> areaId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VetDoctorsAreasCompanion(
                vetDoctorId: vetDoctorId,
                areaId: areaId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int vetDoctorId,
                required int areaId,
                Value<int> rowid = const Value.absent(),
              }) => VetDoctorsAreasCompanion.insert(
                vetDoctorId: vetDoctorId,
                areaId: areaId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VetDoctorsAreasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vetDoctorId = false, areaId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vetDoctorId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vetDoctorId,
                                referencedTable:
                                    $$VetDoctorsAreasTableReferences
                                        ._vetDoctorIdTable(db),
                                referencedColumn:
                                    $$VetDoctorsAreasTableReferences
                                        ._vetDoctorIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (areaId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.areaId,
                                referencedTable:
                                    $$VetDoctorsAreasTableReferences
                                        ._areaIdTable(db),
                                referencedColumn:
                                    $$VetDoctorsAreasTableReferences
                                        ._areaIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VetDoctorsAreasTableProcessedTableManager =
    ProcessedTableManager<
      _$DistributorsDb,
      $VetDoctorsAreasTable,
      VetDoctorsArea,
      $$VetDoctorsAreasTableFilterComposer,
      $$VetDoctorsAreasTableOrderingComposer,
      $$VetDoctorsAreasTableAnnotationComposer,
      $$VetDoctorsAreasTableCreateCompanionBuilder,
      $$VetDoctorsAreasTableUpdateCompanionBuilder,
      (VetDoctorsArea, $$VetDoctorsAreasTableReferences),
      VetDoctorsArea,
      PrefetchHooks Function({bool vetDoctorId, bool areaId})
    >;

class $DistributorsDbManager {
  final _$DistributorsDb _db;
  $DistributorsDbManager(this._db);
  $$RegionsTableTableManager get regions =>
      $$RegionsTableTableManager(_db, _db.regions);
  $$AreasTableTableManager get areas =>
      $$AreasTableTableManager(_db, _db.areas);
  $$DistributorsTableTableManager get distributors =>
      $$DistributorsTableTableManager(_db, _db.distributors);
  $$SalesPersonnelTableTableManager get salesPersonnel =>
      $$SalesPersonnelTableTableManager(_db, _db.salesPersonnel);
  $$SalesPersonnelAreasTableTableManager get salesPersonnelAreas =>
      $$SalesPersonnelAreasTableTableManager(_db, _db.salesPersonnelAreas);
  $$VetDoctorsTableTableManager get vetDoctors =>
      $$VetDoctorsTableTableManager(_db, _db.vetDoctors);
  $$VetDoctorsAreasTableTableManager get vetDoctorsAreas =>
      $$VetDoctorsAreasTableTableManager(_db, _db.vetDoctorsAreas);
}

class $FavoriteProductsTable extends FavoriteProducts
    with TableInfo<$FavoriteProductsTable, FavoriteProduct> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addedAtMeta = const VerificationMeta(
    'addedAt',
  );
  @override
  late final GeneratedColumn<String> addedAt = GeneratedColumn<String>(
    'added_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toIso8601String(),
  );
  @override
  List<GeneratedColumn> get $columns => [productId, addedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_products';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteProduct> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    }
    if (data.containsKey('added_at')) {
      context.handle(
        _addedAtMeta,
        addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {productId};
  @override
  FavoriteProduct map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteProduct(
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      addedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}added_at'],
      )!,
    );
  }

  @override
  $FavoriteProductsTable createAlias(String alias) {
    return $FavoriteProductsTable(attachedDatabase, alias);
  }
}

class FavoriteProduct extends DataClass implements Insertable<FavoriteProduct> {
  final int productId;
  final String addedAt;
  const FavoriteProduct({required this.productId, required this.addedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['product_id'] = Variable<int>(productId);
    map['added_at'] = Variable<String>(addedAt);
    return map;
  }

  FavoriteProductsCompanion toCompanion(bool nullToAbsent) {
    return FavoriteProductsCompanion(
      productId: Value(productId),
      addedAt: Value(addedAt),
    );
  }

  factory FavoriteProduct.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteProduct(
      productId: serializer.fromJson<int>(json['productId']),
      addedAt: serializer.fromJson<String>(json['addedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productId': serializer.toJson<int>(productId),
      'addedAt': serializer.toJson<String>(addedAt),
    };
  }

  FavoriteProduct copyWith({int? productId, String? addedAt}) =>
      FavoriteProduct(
        productId: productId ?? this.productId,
        addedAt: addedAt ?? this.addedAt,
      );
  FavoriteProduct copyWithCompanion(FavoriteProductsCompanion data) {
    return FavoriteProduct(
      productId: data.productId.present ? data.productId.value : this.productId,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteProduct(')
          ..write('productId: $productId, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(productId, addedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteProduct &&
          other.productId == this.productId &&
          other.addedAt == this.addedAt);
}

class FavoriteProductsCompanion extends UpdateCompanion<FavoriteProduct> {
  final Value<int> productId;
  final Value<String> addedAt;
  const FavoriteProductsCompanion({
    this.productId = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  FavoriteProductsCompanion.insert({
    this.productId = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  static Insertable<FavoriteProduct> custom({
    Expression<int>? productId,
    Expression<String>? addedAt,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (addedAt != null) 'added_at': addedAt,
    });
  }

  FavoriteProductsCompanion copyWith({
    Value<int>? productId,
    Value<String>? addedAt,
  }) {
    return FavoriteProductsCompanion(
      productId: productId ?? this.productId,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<String>(addedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteProductsCompanion(')
          ..write('productId: $productId, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }
}

class $FavoriteDistributorsTable extends FavoriteDistributors
    with TableInfo<$FavoriteDistributorsTable, FavoriteDistributor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteDistributorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _distributorIdMeta = const VerificationMeta(
    'distributorId',
  );
  @override
  late final GeneratedColumn<int> distributorId = GeneratedColumn<int>(
    'distributor_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addedAtMeta = const VerificationMeta(
    'addedAt',
  );
  @override
  late final GeneratedColumn<String> addedAt = GeneratedColumn<String>(
    'added_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toIso8601String(),
  );
  @override
  List<GeneratedColumn> get $columns => [distributorId, addedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_distributors';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteDistributor> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('distributor_id')) {
      context.handle(
        _distributorIdMeta,
        distributorId.isAcceptableOrUnknown(
          data['distributor_id']!,
          _distributorIdMeta,
        ),
      );
    }
    if (data.containsKey('added_at')) {
      context.handle(
        _addedAtMeta,
        addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {distributorId};
  @override
  FavoriteDistributor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteDistributor(
      distributorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}distributor_id'],
      )!,
      addedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}added_at'],
      )!,
    );
  }

  @override
  $FavoriteDistributorsTable createAlias(String alias) {
    return $FavoriteDistributorsTable(attachedDatabase, alias);
  }
}

class FavoriteDistributor extends DataClass
    implements Insertable<FavoriteDistributor> {
  final int distributorId;
  final String addedAt;
  const FavoriteDistributor({
    required this.distributorId,
    required this.addedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['distributor_id'] = Variable<int>(distributorId);
    map['added_at'] = Variable<String>(addedAt);
    return map;
  }

  FavoriteDistributorsCompanion toCompanion(bool nullToAbsent) {
    return FavoriteDistributorsCompanion(
      distributorId: Value(distributorId),
      addedAt: Value(addedAt),
    );
  }

  factory FavoriteDistributor.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteDistributor(
      distributorId: serializer.fromJson<int>(json['distributorId']),
      addedAt: serializer.fromJson<String>(json['addedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'distributorId': serializer.toJson<int>(distributorId),
      'addedAt': serializer.toJson<String>(addedAt),
    };
  }

  FavoriteDistributor copyWith({int? distributorId, String? addedAt}) =>
      FavoriteDistributor(
        distributorId: distributorId ?? this.distributorId,
        addedAt: addedAt ?? this.addedAt,
      );
  FavoriteDistributor copyWithCompanion(FavoriteDistributorsCompanion data) {
    return FavoriteDistributor(
      distributorId: data.distributorId.present
          ? data.distributorId.value
          : this.distributorId,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteDistributor(')
          ..write('distributorId: $distributorId, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(distributorId, addedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteDistributor &&
          other.distributorId == this.distributorId &&
          other.addedAt == this.addedAt);
}

class FavoriteDistributorsCompanion
    extends UpdateCompanion<FavoriteDistributor> {
  final Value<int> distributorId;
  final Value<String> addedAt;
  const FavoriteDistributorsCompanion({
    this.distributorId = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  FavoriteDistributorsCompanion.insert({
    this.distributorId = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  static Insertable<FavoriteDistributor> custom({
    Expression<int>? distributorId,
    Expression<String>? addedAt,
  }) {
    return RawValuesInsertable({
      if (distributorId != null) 'distributor_id': distributorId,
      if (addedAt != null) 'added_at': addedAt,
    });
  }

  FavoriteDistributorsCompanion copyWith({
    Value<int>? distributorId,
    Value<String>? addedAt,
  }) {
    return FavoriteDistributorsCompanion(
      distributorId: distributorId ?? this.distributorId,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (distributorId.present) {
      map['distributor_id'] = Variable<int>(distributorId.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<String>(addedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteDistributorsCompanion(')
          ..write('distributorId: $distributorId, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }
}

class $FavoriteSalesPersonnelTable extends FavoriteSalesPersonnel
    with TableInfo<$FavoriteSalesPersonnelTable, FavoriteSalesPersonnelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteSalesPersonnelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _salesPersonnelIdMeta = const VerificationMeta(
    'salesPersonnelId',
  );
  @override
  late final GeneratedColumn<int> salesPersonnelId = GeneratedColumn<int>(
    'sales_personnel_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addedAtMeta = const VerificationMeta(
    'addedAt',
  );
  @override
  late final GeneratedColumn<String> addedAt = GeneratedColumn<String>(
    'added_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toIso8601String(),
  );
  @override
  List<GeneratedColumn> get $columns => [salesPersonnelId, addedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_sales_personnel';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteSalesPersonnelData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('sales_personnel_id')) {
      context.handle(
        _salesPersonnelIdMeta,
        salesPersonnelId.isAcceptableOrUnknown(
          data['sales_personnel_id']!,
          _salesPersonnelIdMeta,
        ),
      );
    }
    if (data.containsKey('added_at')) {
      context.handle(
        _addedAtMeta,
        addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {salesPersonnelId};
  @override
  FavoriteSalesPersonnelData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteSalesPersonnelData(
      salesPersonnelId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sales_personnel_id'],
      )!,
      addedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}added_at'],
      )!,
    );
  }

  @override
  $FavoriteSalesPersonnelTable createAlias(String alias) {
    return $FavoriteSalesPersonnelTable(attachedDatabase, alias);
  }
}

class FavoriteSalesPersonnelData extends DataClass
    implements Insertable<FavoriteSalesPersonnelData> {
  final int salesPersonnelId;
  final String addedAt;
  const FavoriteSalesPersonnelData({
    required this.salesPersonnelId,
    required this.addedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['sales_personnel_id'] = Variable<int>(salesPersonnelId);
    map['added_at'] = Variable<String>(addedAt);
    return map;
  }

  FavoriteSalesPersonnelCompanion toCompanion(bool nullToAbsent) {
    return FavoriteSalesPersonnelCompanion(
      salesPersonnelId: Value(salesPersonnelId),
      addedAt: Value(addedAt),
    );
  }

  factory FavoriteSalesPersonnelData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteSalesPersonnelData(
      salesPersonnelId: serializer.fromJson<int>(json['salesPersonnelId']),
      addedAt: serializer.fromJson<String>(json['addedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'salesPersonnelId': serializer.toJson<int>(salesPersonnelId),
      'addedAt': serializer.toJson<String>(addedAt),
    };
  }

  FavoriteSalesPersonnelData copyWith({
    int? salesPersonnelId,
    String? addedAt,
  }) => FavoriteSalesPersonnelData(
    salesPersonnelId: salesPersonnelId ?? this.salesPersonnelId,
    addedAt: addedAt ?? this.addedAt,
  );
  FavoriteSalesPersonnelData copyWithCompanion(
    FavoriteSalesPersonnelCompanion data,
  ) {
    return FavoriteSalesPersonnelData(
      salesPersonnelId: data.salesPersonnelId.present
          ? data.salesPersonnelId.value
          : this.salesPersonnelId,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteSalesPersonnelData(')
          ..write('salesPersonnelId: $salesPersonnelId, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(salesPersonnelId, addedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteSalesPersonnelData &&
          other.salesPersonnelId == this.salesPersonnelId &&
          other.addedAt == this.addedAt);
}

class FavoriteSalesPersonnelCompanion
    extends UpdateCompanion<FavoriteSalesPersonnelData> {
  final Value<int> salesPersonnelId;
  final Value<String> addedAt;
  const FavoriteSalesPersonnelCompanion({
    this.salesPersonnelId = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  FavoriteSalesPersonnelCompanion.insert({
    this.salesPersonnelId = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  static Insertable<FavoriteSalesPersonnelData> custom({
    Expression<int>? salesPersonnelId,
    Expression<String>? addedAt,
  }) {
    return RawValuesInsertable({
      if (salesPersonnelId != null) 'sales_personnel_id': salesPersonnelId,
      if (addedAt != null) 'added_at': addedAt,
    });
  }

  FavoriteSalesPersonnelCompanion copyWith({
    Value<int>? salesPersonnelId,
    Value<String>? addedAt,
  }) {
    return FavoriteSalesPersonnelCompanion(
      salesPersonnelId: salesPersonnelId ?? this.salesPersonnelId,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (salesPersonnelId.present) {
      map['sales_personnel_id'] = Variable<int>(salesPersonnelId.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<String>(addedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteSalesPersonnelCompanion(')
          ..write('salesPersonnelId: $salesPersonnelId, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }
}

class $FavoriteVetDoctorsTable extends FavoriteVetDoctors
    with TableInfo<$FavoriteVetDoctorsTable, FavoriteVetDoctor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteVetDoctorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _vetDoctorIdMeta = const VerificationMeta(
    'vetDoctorId',
  );
  @override
  late final GeneratedColumn<int> vetDoctorId = GeneratedColumn<int>(
    'vet_doctor_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addedAtMeta = const VerificationMeta(
    'addedAt',
  );
  @override
  late final GeneratedColumn<String> addedAt = GeneratedColumn<String>(
    'added_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toIso8601String(),
  );
  @override
  List<GeneratedColumn> get $columns => [vetDoctorId, addedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_vet_doctors';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteVetDoctor> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('vet_doctor_id')) {
      context.handle(
        _vetDoctorIdMeta,
        vetDoctorId.isAcceptableOrUnknown(
          data['vet_doctor_id']!,
          _vetDoctorIdMeta,
        ),
      );
    }
    if (data.containsKey('added_at')) {
      context.handle(
        _addedAtMeta,
        addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {vetDoctorId};
  @override
  FavoriteVetDoctor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteVetDoctor(
      vetDoctorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vet_doctor_id'],
      )!,
      addedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}added_at'],
      )!,
    );
  }

  @override
  $FavoriteVetDoctorsTable createAlias(String alias) {
    return $FavoriteVetDoctorsTable(attachedDatabase, alias);
  }
}

class FavoriteVetDoctor extends DataClass
    implements Insertable<FavoriteVetDoctor> {
  final int vetDoctorId;
  final String addedAt;
  const FavoriteVetDoctor({required this.vetDoctorId, required this.addedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['vet_doctor_id'] = Variable<int>(vetDoctorId);
    map['added_at'] = Variable<String>(addedAt);
    return map;
  }

  FavoriteVetDoctorsCompanion toCompanion(bool nullToAbsent) {
    return FavoriteVetDoctorsCompanion(
      vetDoctorId: Value(vetDoctorId),
      addedAt: Value(addedAt),
    );
  }

  factory FavoriteVetDoctor.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteVetDoctor(
      vetDoctorId: serializer.fromJson<int>(json['vetDoctorId']),
      addedAt: serializer.fromJson<String>(json['addedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'vetDoctorId': serializer.toJson<int>(vetDoctorId),
      'addedAt': serializer.toJson<String>(addedAt),
    };
  }

  FavoriteVetDoctor copyWith({int? vetDoctorId, String? addedAt}) =>
      FavoriteVetDoctor(
        vetDoctorId: vetDoctorId ?? this.vetDoctorId,
        addedAt: addedAt ?? this.addedAt,
      );
  FavoriteVetDoctor copyWithCompanion(FavoriteVetDoctorsCompanion data) {
    return FavoriteVetDoctor(
      vetDoctorId: data.vetDoctorId.present
          ? data.vetDoctorId.value
          : this.vetDoctorId,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteVetDoctor(')
          ..write('vetDoctorId: $vetDoctorId, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(vetDoctorId, addedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteVetDoctor &&
          other.vetDoctorId == this.vetDoctorId &&
          other.addedAt == this.addedAt);
}

class FavoriteVetDoctorsCompanion extends UpdateCompanion<FavoriteVetDoctor> {
  final Value<int> vetDoctorId;
  final Value<String> addedAt;
  const FavoriteVetDoctorsCompanion({
    this.vetDoctorId = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  FavoriteVetDoctorsCompanion.insert({
    this.vetDoctorId = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  static Insertable<FavoriteVetDoctor> custom({
    Expression<int>? vetDoctorId,
    Expression<String>? addedAt,
  }) {
    return RawValuesInsertable({
      if (vetDoctorId != null) 'vet_doctor_id': vetDoctorId,
      if (addedAt != null) 'added_at': addedAt,
    });
  }

  FavoriteVetDoctorsCompanion copyWith({
    Value<int>? vetDoctorId,
    Value<String>? addedAt,
  }) {
    return FavoriteVetDoctorsCompanion(
      vetDoctorId: vetDoctorId ?? this.vetDoctorId,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (vetDoctorId.present) {
      map['vet_doctor_id'] = Variable<int>(vetDoctorId.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<String>(addedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteVetDoctorsCompanion(')
          ..write('vetDoctorId: $vetDoctorId, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      ),
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String key;
  final String? value;
  const AppSetting({required this.key, this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      key: Value(key),
      value: value == null && nullToAbsent
          ? const Value.absent()
          : Value(value),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String?>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String?>(value),
    };
  }

  AppSetting copyWith({
    String? key,
    Value<String?> value = const Value.absent(),
  }) => AppSetting(
    key: key ?? this.key,
    value: value.present ? value.value : this.value,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.key == this.key &&
          other.value == this.value);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> key;
  final Value<String?> value;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key);
  static Insertable<AppSetting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? key,
    Value<String?>? value,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DbMetaTable extends DbMeta with TableInfo<$DbMetaTable, DbMetaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbMetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbMetaData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  DbMetaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbMetaData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      ),
    );
  }

  @override
  $DbMetaTable createAlias(String alias) {
    return $DbMetaTable(attachedDatabase, alias);
  }
}

class DbMetaData extends DataClass implements Insertable<DbMetaData> {
  final String key;
  final String? value;
  const DbMetaData({required this.key, this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    return map;
  }

  DbMetaCompanion toCompanion(bool nullToAbsent) {
    return DbMetaCompanion(
      key: Value(key),
      value: value == null && nullToAbsent
          ? const Value.absent()
          : Value(value),
    );
  }

  factory DbMetaData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbMetaData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String?>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String?>(value),
    };
  }

  DbMetaData copyWith({
    String? key,
    Value<String?> value = const Value.absent(),
  }) => DbMetaData(
    key: key ?? this.key,
    value: value.present ? value.value : this.value,
  );
  DbMetaData copyWithCompanion(DbMetaCompanion data) {
    return DbMetaData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbMetaData(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbMetaData &&
          other.key == this.key &&
          other.value == this.value);
}

class DbMetaCompanion extends UpdateCompanion<DbMetaData> {
  final Value<String> key;
  final Value<String?> value;
  final Value<int> rowid;
  const DbMetaCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DbMetaCompanion.insert({
    required String key,
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key);
  static Insertable<DbMetaData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DbMetaCompanion copyWith({
    Value<String>? key,
    Value<String?>? value,
    Value<int>? rowid,
  }) {
    return DbMetaCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbMetaCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppMaintenanceDb extends GeneratedDatabase {
  _$AppMaintenanceDb(QueryExecutor e) : super(e);
  $AppMaintenanceDbManager get managers => $AppMaintenanceDbManager(this);
  late final $FavoriteProductsTable favoriteProducts = $FavoriteProductsTable(
    this,
  );
  late final $FavoriteDistributorsTable favoriteDistributors =
      $FavoriteDistributorsTable(this);
  late final $FavoriteSalesPersonnelTable favoriteSalesPersonnel =
      $FavoriteSalesPersonnelTable(this);
  late final $FavoriteVetDoctorsTable favoriteVetDoctors =
      $FavoriteVetDoctorsTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $DbMetaTable dbMeta = $DbMetaTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    favoriteProducts,
    favoriteDistributors,
    favoriteSalesPersonnel,
    favoriteVetDoctors,
    appSettings,
    dbMeta,
  ];
}

typedef $$FavoriteProductsTableCreateCompanionBuilder =
    FavoriteProductsCompanion Function({
      Value<int> productId,
      Value<String> addedAt,
    });
typedef $$FavoriteProductsTableUpdateCompanionBuilder =
    FavoriteProductsCompanion Function({
      Value<int> productId,
      Value<String> addedAt,
    });

class $$FavoriteProductsTableFilterComposer
    extends Composer<_$AppMaintenanceDb, $FavoriteProductsTable> {
  $$FavoriteProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoriteProductsTableOrderingComposer
    extends Composer<_$AppMaintenanceDb, $FavoriteProductsTable> {
  $$FavoriteProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoriteProductsTableAnnotationComposer
    extends Composer<_$AppMaintenanceDb, $FavoriteProductsTable> {
  $$FavoriteProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);
}

class $$FavoriteProductsTableTableManager
    extends
        RootTableManager<
          _$AppMaintenanceDb,
          $FavoriteProductsTable,
          FavoriteProduct,
          $$FavoriteProductsTableFilterComposer,
          $$FavoriteProductsTableOrderingComposer,
          $$FavoriteProductsTableAnnotationComposer,
          $$FavoriteProductsTableCreateCompanionBuilder,
          $$FavoriteProductsTableUpdateCompanionBuilder,
          (
            FavoriteProduct,
            BaseReferences<
              _$AppMaintenanceDb,
              $FavoriteProductsTable,
              FavoriteProduct
            >,
          ),
          FavoriteProduct,
          PrefetchHooks Function()
        > {
  $$FavoriteProductsTableTableManager(
    _$AppMaintenanceDb db,
    $FavoriteProductsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoriteProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoriteProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> productId = const Value.absent(),
                Value<String> addedAt = const Value.absent(),
              }) => FavoriteProductsCompanion(
                productId: productId,
                addedAt: addedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> productId = const Value.absent(),
                Value<String> addedAt = const Value.absent(),
              }) => FavoriteProductsCompanion.insert(
                productId: productId,
                addedAt: addedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoriteProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppMaintenanceDb,
      $FavoriteProductsTable,
      FavoriteProduct,
      $$FavoriteProductsTableFilterComposer,
      $$FavoriteProductsTableOrderingComposer,
      $$FavoriteProductsTableAnnotationComposer,
      $$FavoriteProductsTableCreateCompanionBuilder,
      $$FavoriteProductsTableUpdateCompanionBuilder,
      (
        FavoriteProduct,
        BaseReferences<
          _$AppMaintenanceDb,
          $FavoriteProductsTable,
          FavoriteProduct
        >,
      ),
      FavoriteProduct,
      PrefetchHooks Function()
    >;
typedef $$FavoriteDistributorsTableCreateCompanionBuilder =
    FavoriteDistributorsCompanion Function({
      Value<int> distributorId,
      Value<String> addedAt,
    });
typedef $$FavoriteDistributorsTableUpdateCompanionBuilder =
    FavoriteDistributorsCompanion Function({
      Value<int> distributorId,
      Value<String> addedAt,
    });

class $$FavoriteDistributorsTableFilterComposer
    extends Composer<_$AppMaintenanceDb, $FavoriteDistributorsTable> {
  $$FavoriteDistributorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get distributorId => $composableBuilder(
    column: $table.distributorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoriteDistributorsTableOrderingComposer
    extends Composer<_$AppMaintenanceDb, $FavoriteDistributorsTable> {
  $$FavoriteDistributorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get distributorId => $composableBuilder(
    column: $table.distributorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoriteDistributorsTableAnnotationComposer
    extends Composer<_$AppMaintenanceDb, $FavoriteDistributorsTable> {
  $$FavoriteDistributorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get distributorId => $composableBuilder(
    column: $table.distributorId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);
}

class $$FavoriteDistributorsTableTableManager
    extends
        RootTableManager<
          _$AppMaintenanceDb,
          $FavoriteDistributorsTable,
          FavoriteDistributor,
          $$FavoriteDistributorsTableFilterComposer,
          $$FavoriteDistributorsTableOrderingComposer,
          $$FavoriteDistributorsTableAnnotationComposer,
          $$FavoriteDistributorsTableCreateCompanionBuilder,
          $$FavoriteDistributorsTableUpdateCompanionBuilder,
          (
            FavoriteDistributor,
            BaseReferences<
              _$AppMaintenanceDb,
              $FavoriteDistributorsTable,
              FavoriteDistributor
            >,
          ),
          FavoriteDistributor,
          PrefetchHooks Function()
        > {
  $$FavoriteDistributorsTableTableManager(
    _$AppMaintenanceDb db,
    $FavoriteDistributorsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteDistributorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoriteDistributorsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$FavoriteDistributorsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> distributorId = const Value.absent(),
                Value<String> addedAt = const Value.absent(),
              }) => FavoriteDistributorsCompanion(
                distributorId: distributorId,
                addedAt: addedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> distributorId = const Value.absent(),
                Value<String> addedAt = const Value.absent(),
              }) => FavoriteDistributorsCompanion.insert(
                distributorId: distributorId,
                addedAt: addedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoriteDistributorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppMaintenanceDb,
      $FavoriteDistributorsTable,
      FavoriteDistributor,
      $$FavoriteDistributorsTableFilterComposer,
      $$FavoriteDistributorsTableOrderingComposer,
      $$FavoriteDistributorsTableAnnotationComposer,
      $$FavoriteDistributorsTableCreateCompanionBuilder,
      $$FavoriteDistributorsTableUpdateCompanionBuilder,
      (
        FavoriteDistributor,
        BaseReferences<
          _$AppMaintenanceDb,
          $FavoriteDistributorsTable,
          FavoriteDistributor
        >,
      ),
      FavoriteDistributor,
      PrefetchHooks Function()
    >;
typedef $$FavoriteSalesPersonnelTableCreateCompanionBuilder =
    FavoriteSalesPersonnelCompanion Function({
      Value<int> salesPersonnelId,
      Value<String> addedAt,
    });
typedef $$FavoriteSalesPersonnelTableUpdateCompanionBuilder =
    FavoriteSalesPersonnelCompanion Function({
      Value<int> salesPersonnelId,
      Value<String> addedAt,
    });

class $$FavoriteSalesPersonnelTableFilterComposer
    extends Composer<_$AppMaintenanceDb, $FavoriteSalesPersonnelTable> {
  $$FavoriteSalesPersonnelTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get salesPersonnelId => $composableBuilder(
    column: $table.salesPersonnelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoriteSalesPersonnelTableOrderingComposer
    extends Composer<_$AppMaintenanceDb, $FavoriteSalesPersonnelTable> {
  $$FavoriteSalesPersonnelTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get salesPersonnelId => $composableBuilder(
    column: $table.salesPersonnelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoriteSalesPersonnelTableAnnotationComposer
    extends Composer<_$AppMaintenanceDb, $FavoriteSalesPersonnelTable> {
  $$FavoriteSalesPersonnelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get salesPersonnelId => $composableBuilder(
    column: $table.salesPersonnelId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);
}

class $$FavoriteSalesPersonnelTableTableManager
    extends
        RootTableManager<
          _$AppMaintenanceDb,
          $FavoriteSalesPersonnelTable,
          FavoriteSalesPersonnelData,
          $$FavoriteSalesPersonnelTableFilterComposer,
          $$FavoriteSalesPersonnelTableOrderingComposer,
          $$FavoriteSalesPersonnelTableAnnotationComposer,
          $$FavoriteSalesPersonnelTableCreateCompanionBuilder,
          $$FavoriteSalesPersonnelTableUpdateCompanionBuilder,
          (
            FavoriteSalesPersonnelData,
            BaseReferences<
              _$AppMaintenanceDb,
              $FavoriteSalesPersonnelTable,
              FavoriteSalesPersonnelData
            >,
          ),
          FavoriteSalesPersonnelData,
          PrefetchHooks Function()
        > {
  $$FavoriteSalesPersonnelTableTableManager(
    _$AppMaintenanceDb db,
    $FavoriteSalesPersonnelTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteSalesPersonnelTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$FavoriteSalesPersonnelTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$FavoriteSalesPersonnelTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> salesPersonnelId = const Value.absent(),
                Value<String> addedAt = const Value.absent(),
              }) => FavoriteSalesPersonnelCompanion(
                salesPersonnelId: salesPersonnelId,
                addedAt: addedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> salesPersonnelId = const Value.absent(),
                Value<String> addedAt = const Value.absent(),
              }) => FavoriteSalesPersonnelCompanion.insert(
                salesPersonnelId: salesPersonnelId,
                addedAt: addedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoriteSalesPersonnelTableProcessedTableManager =
    ProcessedTableManager<
      _$AppMaintenanceDb,
      $FavoriteSalesPersonnelTable,
      FavoriteSalesPersonnelData,
      $$FavoriteSalesPersonnelTableFilterComposer,
      $$FavoriteSalesPersonnelTableOrderingComposer,
      $$FavoriteSalesPersonnelTableAnnotationComposer,
      $$FavoriteSalesPersonnelTableCreateCompanionBuilder,
      $$FavoriteSalesPersonnelTableUpdateCompanionBuilder,
      (
        FavoriteSalesPersonnelData,
        BaseReferences<
          _$AppMaintenanceDb,
          $FavoriteSalesPersonnelTable,
          FavoriteSalesPersonnelData
        >,
      ),
      FavoriteSalesPersonnelData,
      PrefetchHooks Function()
    >;
typedef $$FavoriteVetDoctorsTableCreateCompanionBuilder =
    FavoriteVetDoctorsCompanion Function({
      Value<int> vetDoctorId,
      Value<String> addedAt,
    });
typedef $$FavoriteVetDoctorsTableUpdateCompanionBuilder =
    FavoriteVetDoctorsCompanion Function({
      Value<int> vetDoctorId,
      Value<String> addedAt,
    });

class $$FavoriteVetDoctorsTableFilterComposer
    extends Composer<_$AppMaintenanceDb, $FavoriteVetDoctorsTable> {
  $$FavoriteVetDoctorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get vetDoctorId => $composableBuilder(
    column: $table.vetDoctorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoriteVetDoctorsTableOrderingComposer
    extends Composer<_$AppMaintenanceDb, $FavoriteVetDoctorsTable> {
  $$FavoriteVetDoctorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get vetDoctorId => $composableBuilder(
    column: $table.vetDoctorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoriteVetDoctorsTableAnnotationComposer
    extends Composer<_$AppMaintenanceDb, $FavoriteVetDoctorsTable> {
  $$FavoriteVetDoctorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get vetDoctorId => $composableBuilder(
    column: $table.vetDoctorId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);
}

class $$FavoriteVetDoctorsTableTableManager
    extends
        RootTableManager<
          _$AppMaintenanceDb,
          $FavoriteVetDoctorsTable,
          FavoriteVetDoctor,
          $$FavoriteVetDoctorsTableFilterComposer,
          $$FavoriteVetDoctorsTableOrderingComposer,
          $$FavoriteVetDoctorsTableAnnotationComposer,
          $$FavoriteVetDoctorsTableCreateCompanionBuilder,
          $$FavoriteVetDoctorsTableUpdateCompanionBuilder,
          (
            FavoriteVetDoctor,
            BaseReferences<
              _$AppMaintenanceDb,
              $FavoriteVetDoctorsTable,
              FavoriteVetDoctor
            >,
          ),
          FavoriteVetDoctor,
          PrefetchHooks Function()
        > {
  $$FavoriteVetDoctorsTableTableManager(
    _$AppMaintenanceDb db,
    $FavoriteVetDoctorsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteVetDoctorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoriteVetDoctorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoriteVetDoctorsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> vetDoctorId = const Value.absent(),
                Value<String> addedAt = const Value.absent(),
              }) => FavoriteVetDoctorsCompanion(
                vetDoctorId: vetDoctorId,
                addedAt: addedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> vetDoctorId = const Value.absent(),
                Value<String> addedAt = const Value.absent(),
              }) => FavoriteVetDoctorsCompanion.insert(
                vetDoctorId: vetDoctorId,
                addedAt: addedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoriteVetDoctorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppMaintenanceDb,
      $FavoriteVetDoctorsTable,
      FavoriteVetDoctor,
      $$FavoriteVetDoctorsTableFilterComposer,
      $$FavoriteVetDoctorsTableOrderingComposer,
      $$FavoriteVetDoctorsTableAnnotationComposer,
      $$FavoriteVetDoctorsTableCreateCompanionBuilder,
      $$FavoriteVetDoctorsTableUpdateCompanionBuilder,
      (
        FavoriteVetDoctor,
        BaseReferences<
          _$AppMaintenanceDb,
          $FavoriteVetDoctorsTable,
          FavoriteVetDoctor
        >,
      ),
      FavoriteVetDoctor,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String key,
      Value<String?> value,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> key,
      Value<String?> value,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppMaintenanceDb, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppMaintenanceDb, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppMaintenanceDb, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppMaintenanceDb,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppMaintenanceDb, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppMaintenanceDb db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String?> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                Value<String?> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppMaintenanceDb,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppMaintenanceDb, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;
typedef $$DbMetaTableCreateCompanionBuilder =
    DbMetaCompanion Function({
      required String key,
      Value<String?> value,
      Value<int> rowid,
    });
typedef $$DbMetaTableUpdateCompanionBuilder =
    DbMetaCompanion Function({
      Value<String> key,
      Value<String?> value,
      Value<int> rowid,
    });

class $$DbMetaTableFilterComposer
    extends Composer<_$AppMaintenanceDb, $DbMetaTable> {
  $$DbMetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DbMetaTableOrderingComposer
    extends Composer<_$AppMaintenanceDb, $DbMetaTable> {
  $$DbMetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DbMetaTableAnnotationComposer
    extends Composer<_$AppMaintenanceDb, $DbMetaTable> {
  $$DbMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$DbMetaTableTableManager
    extends
        RootTableManager<
          _$AppMaintenanceDb,
          $DbMetaTable,
          DbMetaData,
          $$DbMetaTableFilterComposer,
          $$DbMetaTableOrderingComposer,
          $$DbMetaTableAnnotationComposer,
          $$DbMetaTableCreateCompanionBuilder,
          $$DbMetaTableUpdateCompanionBuilder,
          (
            DbMetaData,
            BaseReferences<_$AppMaintenanceDb, $DbMetaTable, DbMetaData>,
          ),
          DbMetaData,
          PrefetchHooks Function()
        > {
  $$DbMetaTableTableManager(_$AppMaintenanceDb db, $DbMetaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DbMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DbMetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DbMetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String?> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DbMetaCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                Value<String?> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) =>
                  DbMetaCompanion.insert(key: key, value: value, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DbMetaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppMaintenanceDb,
      $DbMetaTable,
      DbMetaData,
      $$DbMetaTableFilterComposer,
      $$DbMetaTableOrderingComposer,
      $$DbMetaTableAnnotationComposer,
      $$DbMetaTableCreateCompanionBuilder,
      $$DbMetaTableUpdateCompanionBuilder,
      (
        DbMetaData,
        BaseReferences<_$AppMaintenanceDb, $DbMetaTable, DbMetaData>,
      ),
      DbMetaData,
      PrefetchHooks Function()
    >;

class $AppMaintenanceDbManager {
  final _$AppMaintenanceDb _db;
  $AppMaintenanceDbManager(this._db);
  $$FavoriteProductsTableTableManager get favoriteProducts =>
      $$FavoriteProductsTableTableManager(_db, _db.favoriteProducts);
  $$FavoriteDistributorsTableTableManager get favoriteDistributors =>
      $$FavoriteDistributorsTableTableManager(_db, _db.favoriteDistributors);
  $$FavoriteSalesPersonnelTableTableManager get favoriteSalesPersonnel =>
      $$FavoriteSalesPersonnelTableTableManager(
        _db,
        _db.favoriteSalesPersonnel,
      );
  $$FavoriteVetDoctorsTableTableManager get favoriteVetDoctors =>
      $$FavoriteVetDoctorsTableTableManager(_db, _db.favoriteVetDoctors);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$DbMetaTableTableManager get dbMeta =>
      $$DbMetaTableTableManager(_db, _db.dbMeta);
}
