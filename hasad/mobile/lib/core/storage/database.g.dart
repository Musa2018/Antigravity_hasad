// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $FarmersTable extends Farmers with TableInfo<$FarmersTable, FarmerLocal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FarmersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idTypeIdMeta = const VerificationMeta(
    'idTypeId',
  );
  @override
  late final GeneratedColumn<int> idTypeId = GeneratedColumn<int>(
    'id_type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _idNumberMeta = const VerificationMeta(
    'idNumber',
  );
  @override
  late final GeneratedColumn<String> idNumber = GeneratedColumn<String>(
    'id_number',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _firstNameArMeta = const VerificationMeta(
    'firstNameAr',
  );
  @override
  late final GeneratedColumn<String> firstNameAr = GeneratedColumn<String>(
    'first_name_ar',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _fatherNameArMeta = const VerificationMeta(
    'fatherNameAr',
  );
  @override
  late final GeneratedColumn<String> fatherNameAr = GeneratedColumn<String>(
    'father_name_ar',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _grandfatherNameArMeta = const VerificationMeta(
    'grandfatherNameAr',
  );
  @override
  late final GeneratedColumn<String> grandfatherNameAr =
      GeneratedColumn<String>(
        'grandfather_name_ar',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _familyNameArMeta = const VerificationMeta(
    'familyNameAr',
  );
  @override
  late final GeneratedColumn<String> familyNameAr = GeneratedColumn<String>(
    'family_name_ar',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _firstNameEnMeta = const VerificationMeta(
    'firstNameEn',
  );
  @override
  late final GeneratedColumn<String> firstNameEn = GeneratedColumn<String>(
    'first_name_en',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _fatherNameEnMeta = const VerificationMeta(
    'fatherNameEn',
  );
  @override
  late final GeneratedColumn<String> fatherNameEn = GeneratedColumn<String>(
    'father_name_en',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _grandfatherNameEnMeta = const VerificationMeta(
    'grandfatherNameEn',
  );
  @override
  late final GeneratedColumn<String> grandfatherNameEn =
      GeneratedColumn<String>(
        'grandfather_name_en',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _familyNameEnMeta = const VerificationMeta(
    'familyNameEn',
  );
  @override
  late final GeneratedColumn<String> familyNameEn = GeneratedColumn<String>(
    'family_name_en',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _birthDateMeta = const VerificationMeta(
    'birthDate',
  );
  @override
  late final GeneratedColumn<DateTime> birthDate = GeneratedColumn<DateTime>(
    'birth_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<int> gender = GeneratedColumn<int>(
    'gender',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _familySizeMeta = const VerificationMeta(
    'familySize',
  );
  @override
  late final GeneratedColumn<int> familySize = GeneratedColumn<int>(
    'family_size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _governorateIdMeta = const VerificationMeta(
    'governorateId',
  );
  @override
  late final GeneratedColumn<String> governorateId = GeneratedColumn<String>(
    'governorate_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _localityIdMeta = const VerificationMeta(
    'localityId',
  );
  @override
  late final GeneratedColumn<String> localityId = GeneratedColumn<String>(
    'locality_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 200),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _nationalIdMeta = const VerificationMeta(
    'nationalId',
  );
  @override
  late final GeneratedColumn<String> nationalId = GeneratedColumn<String>(
    'national_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _rowVersionMeta = const VerificationMeta(
    'rowVersion',
  );
  @override
  late final GeneratedColumn<String> rowVersion = GeneratedColumn<String>(
    'row_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('completed'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    idTypeId,
    idNumber,
    firstNameAr,
    fatherNameAr,
    grandfatherNameAr,
    familyNameAr,
    firstNameEn,
    fatherNameEn,
    grandfatherNameEn,
    familyNameEn,
    birthDate,
    gender,
    phoneNumber,
    familySize,
    governorateId,
    localityId,
    address,
    name,
    nationalId,
    rowVersion,
    syncStatus,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'farmers';
  @override
  VerificationContext validateIntegrity(
    Insertable<FarmerLocal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('id_type_id')) {
      context.handle(
        _idTypeIdMeta,
        idTypeId.isAcceptableOrUnknown(data['id_type_id']!, _idTypeIdMeta),
      );
    }
    if (data.containsKey('id_number')) {
      context.handle(
        _idNumberMeta,
        idNumber.isAcceptableOrUnknown(data['id_number']!, _idNumberMeta),
      );
    }
    if (data.containsKey('first_name_ar')) {
      context.handle(
        _firstNameArMeta,
        firstNameAr.isAcceptableOrUnknown(
          data['first_name_ar']!,
          _firstNameArMeta,
        ),
      );
    }
    if (data.containsKey('father_name_ar')) {
      context.handle(
        _fatherNameArMeta,
        fatherNameAr.isAcceptableOrUnknown(
          data['father_name_ar']!,
          _fatherNameArMeta,
        ),
      );
    }
    if (data.containsKey('grandfather_name_ar')) {
      context.handle(
        _grandfatherNameArMeta,
        grandfatherNameAr.isAcceptableOrUnknown(
          data['grandfather_name_ar']!,
          _grandfatherNameArMeta,
        ),
      );
    }
    if (data.containsKey('family_name_ar')) {
      context.handle(
        _familyNameArMeta,
        familyNameAr.isAcceptableOrUnknown(
          data['family_name_ar']!,
          _familyNameArMeta,
        ),
      );
    }
    if (data.containsKey('first_name_en')) {
      context.handle(
        _firstNameEnMeta,
        firstNameEn.isAcceptableOrUnknown(
          data['first_name_en']!,
          _firstNameEnMeta,
        ),
      );
    }
    if (data.containsKey('father_name_en')) {
      context.handle(
        _fatherNameEnMeta,
        fatherNameEn.isAcceptableOrUnknown(
          data['father_name_en']!,
          _fatherNameEnMeta,
        ),
      );
    }
    if (data.containsKey('grandfather_name_en')) {
      context.handle(
        _grandfatherNameEnMeta,
        grandfatherNameEn.isAcceptableOrUnknown(
          data['grandfather_name_en']!,
          _grandfatherNameEnMeta,
        ),
      );
    }
    if (data.containsKey('family_name_en')) {
      context.handle(
        _familyNameEnMeta,
        familyNameEn.isAcceptableOrUnknown(
          data['family_name_en']!,
          _familyNameEnMeta,
        ),
      );
    }
    if (data.containsKey('birth_date')) {
      context.handle(
        _birthDateMeta,
        birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta),
      );
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    }
    if (data.containsKey('family_size')) {
      context.handle(
        _familySizeMeta,
        familySize.isAcceptableOrUnknown(data['family_size']!, _familySizeMeta),
      );
    }
    if (data.containsKey('governorate_id')) {
      context.handle(
        _governorateIdMeta,
        governorateId.isAcceptableOrUnknown(
          data['governorate_id']!,
          _governorateIdMeta,
        ),
      );
    }
    if (data.containsKey('locality_id')) {
      context.handle(
        _localityIdMeta,
        localityId.isAcceptableOrUnknown(data['locality_id']!, _localityIdMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('national_id')) {
      context.handle(
        _nationalIdMeta,
        nationalId.isAcceptableOrUnknown(data['national_id']!, _nationalIdMeta),
      );
    }
    if (data.containsKey('row_version')) {
      context.handle(
        _rowVersionMeta,
        rowVersion.isAcceptableOrUnknown(data['row_version']!, _rowVersionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
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
  FarmerLocal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FarmerLocal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      ),
      idTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_type_id'],
      )!,
      idNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_number'],
      )!,
      firstNameAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name_ar'],
      )!,
      fatherNameAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}father_name_ar'],
      )!,
      grandfatherNameAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grandfather_name_ar'],
      )!,
      familyNameAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}family_name_ar'],
      )!,
      firstNameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name_en'],
      )!,
      fatherNameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}father_name_en'],
      )!,
      grandfatherNameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grandfather_name_en'],
      )!,
      familyNameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}family_name_en'],
      )!,
      birthDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}birth_date'],
      ),
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gender'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      )!,
      familySize: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}family_size'],
      )!,
      governorateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}governorate_id'],
      )!,
      localityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locality_id'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      nationalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}national_id'],
      )!,
      rowVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}row_version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $FarmersTable createAlias(String alias) {
    return $FarmersTable(attachedDatabase, alias);
  }
}

class FarmerLocal extends DataClass implements Insertable<FarmerLocal> {
  final String id;
  final String? serverId;
  final int idTypeId;
  final String idNumber;
  final String firstNameAr;
  final String fatherNameAr;
  final String grandfatherNameAr;
  final String familyNameAr;
  final String firstNameEn;
  final String fatherNameEn;
  final String grandfatherNameEn;
  final String familyNameEn;
  final DateTime? birthDate;
  final int gender;
  final String phoneNumber;
  final int familySize;
  final String governorateId;
  final String localityId;
  final String address;
  final String name;
  final String nationalId;
  final String rowVersion;
  final String syncStatus;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const FarmerLocal({
    required this.id,
    this.serverId,
    required this.idTypeId,
    required this.idNumber,
    required this.firstNameAr,
    required this.fatherNameAr,
    required this.grandfatherNameAr,
    required this.familyNameAr,
    required this.firstNameEn,
    required this.fatherNameEn,
    required this.grandfatherNameEn,
    required this.familyNameEn,
    this.birthDate,
    required this.gender,
    required this.phoneNumber,
    required this.familySize,
    required this.governorateId,
    required this.localityId,
    required this.address,
    required this.name,
    required this.nationalId,
    required this.rowVersion,
    required this.syncStatus,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    map['id_type_id'] = Variable<int>(idTypeId);
    map['id_number'] = Variable<String>(idNumber);
    map['first_name_ar'] = Variable<String>(firstNameAr);
    map['father_name_ar'] = Variable<String>(fatherNameAr);
    map['grandfather_name_ar'] = Variable<String>(grandfatherNameAr);
    map['family_name_ar'] = Variable<String>(familyNameAr);
    map['first_name_en'] = Variable<String>(firstNameEn);
    map['father_name_en'] = Variable<String>(fatherNameEn);
    map['grandfather_name_en'] = Variable<String>(grandfatherNameEn);
    map['family_name_en'] = Variable<String>(familyNameEn);
    if (!nullToAbsent || birthDate != null) {
      map['birth_date'] = Variable<DateTime>(birthDate);
    }
    map['gender'] = Variable<int>(gender);
    map['phone_number'] = Variable<String>(phoneNumber);
    map['family_size'] = Variable<int>(familySize);
    map['governorate_id'] = Variable<String>(governorateId);
    map['locality_id'] = Variable<String>(localityId);
    map['address'] = Variable<String>(address);
    map['name'] = Variable<String>(name);
    map['national_id'] = Variable<String>(nationalId);
    map['row_version'] = Variable<String>(rowVersion);
    map['sync_status'] = Variable<String>(syncStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  FarmersCompanion toCompanion(bool nullToAbsent) {
    return FarmersCompanion(
      id: Value(id),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      idTypeId: Value(idTypeId),
      idNumber: Value(idNumber),
      firstNameAr: Value(firstNameAr),
      fatherNameAr: Value(fatherNameAr),
      grandfatherNameAr: Value(grandfatherNameAr),
      familyNameAr: Value(familyNameAr),
      firstNameEn: Value(firstNameEn),
      fatherNameEn: Value(fatherNameEn),
      grandfatherNameEn: Value(grandfatherNameEn),
      familyNameEn: Value(familyNameEn),
      birthDate: birthDate == null && nullToAbsent
          ? const Value.absent()
          : Value(birthDate),
      gender: Value(gender),
      phoneNumber: Value(phoneNumber),
      familySize: Value(familySize),
      governorateId: Value(governorateId),
      localityId: Value(localityId),
      address: Value(address),
      name: Value(name),
      nationalId: Value(nationalId),
      rowVersion: Value(rowVersion),
      syncStatus: Value(syncStatus),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory FarmerLocal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FarmerLocal(
      id: serializer.fromJson<String>(json['id']),
      serverId: serializer.fromJson<String?>(json['serverId']),
      idTypeId: serializer.fromJson<int>(json['idTypeId']),
      idNumber: serializer.fromJson<String>(json['idNumber']),
      firstNameAr: serializer.fromJson<String>(json['firstNameAr']),
      fatherNameAr: serializer.fromJson<String>(json['fatherNameAr']),
      grandfatherNameAr: serializer.fromJson<String>(json['grandfatherNameAr']),
      familyNameAr: serializer.fromJson<String>(json['familyNameAr']),
      firstNameEn: serializer.fromJson<String>(json['firstNameEn']),
      fatherNameEn: serializer.fromJson<String>(json['fatherNameEn']),
      grandfatherNameEn: serializer.fromJson<String>(json['grandfatherNameEn']),
      familyNameEn: serializer.fromJson<String>(json['familyNameEn']),
      birthDate: serializer.fromJson<DateTime?>(json['birthDate']),
      gender: serializer.fromJson<int>(json['gender']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      familySize: serializer.fromJson<int>(json['familySize']),
      governorateId: serializer.fromJson<String>(json['governorateId']),
      localityId: serializer.fromJson<String>(json['localityId']),
      address: serializer.fromJson<String>(json['address']),
      name: serializer.fromJson<String>(json['name']),
      nationalId: serializer.fromJson<String>(json['nationalId']),
      rowVersion: serializer.fromJson<String>(json['rowVersion']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'serverId': serializer.toJson<String?>(serverId),
      'idTypeId': serializer.toJson<int>(idTypeId),
      'idNumber': serializer.toJson<String>(idNumber),
      'firstNameAr': serializer.toJson<String>(firstNameAr),
      'fatherNameAr': serializer.toJson<String>(fatherNameAr),
      'grandfatherNameAr': serializer.toJson<String>(grandfatherNameAr),
      'familyNameAr': serializer.toJson<String>(familyNameAr),
      'firstNameEn': serializer.toJson<String>(firstNameEn),
      'fatherNameEn': serializer.toJson<String>(fatherNameEn),
      'grandfatherNameEn': serializer.toJson<String>(grandfatherNameEn),
      'familyNameEn': serializer.toJson<String>(familyNameEn),
      'birthDate': serializer.toJson<DateTime?>(birthDate),
      'gender': serializer.toJson<int>(gender),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'familySize': serializer.toJson<int>(familySize),
      'governorateId': serializer.toJson<String>(governorateId),
      'localityId': serializer.toJson<String>(localityId),
      'address': serializer.toJson<String>(address),
      'name': serializer.toJson<String>(name),
      'nationalId': serializer.toJson<String>(nationalId),
      'rowVersion': serializer.toJson<String>(rowVersion),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  FarmerLocal copyWith({
    String? id,
    Value<String?> serverId = const Value.absent(),
    int? idTypeId,
    String? idNumber,
    String? firstNameAr,
    String? fatherNameAr,
    String? grandfatherNameAr,
    String? familyNameAr,
    String? firstNameEn,
    String? fatherNameEn,
    String? grandfatherNameEn,
    String? familyNameEn,
    Value<DateTime?> birthDate = const Value.absent(),
    int? gender,
    String? phoneNumber,
    int? familySize,
    String? governorateId,
    String? localityId,
    String? address,
    String? name,
    String? nationalId,
    String? rowVersion,
    String? syncStatus,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => FarmerLocal(
    id: id ?? this.id,
    serverId: serverId.present ? serverId.value : this.serverId,
    idTypeId: idTypeId ?? this.idTypeId,
    idNumber: idNumber ?? this.idNumber,
    firstNameAr: firstNameAr ?? this.firstNameAr,
    fatherNameAr: fatherNameAr ?? this.fatherNameAr,
    grandfatherNameAr: grandfatherNameAr ?? this.grandfatherNameAr,
    familyNameAr: familyNameAr ?? this.familyNameAr,
    firstNameEn: firstNameEn ?? this.firstNameEn,
    fatherNameEn: fatherNameEn ?? this.fatherNameEn,
    grandfatherNameEn: grandfatherNameEn ?? this.grandfatherNameEn,
    familyNameEn: familyNameEn ?? this.familyNameEn,
    birthDate: birthDate.present ? birthDate.value : this.birthDate,
    gender: gender ?? this.gender,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    familySize: familySize ?? this.familySize,
    governorateId: governorateId ?? this.governorateId,
    localityId: localityId ?? this.localityId,
    address: address ?? this.address,
    name: name ?? this.name,
    nationalId: nationalId ?? this.nationalId,
    rowVersion: rowVersion ?? this.rowVersion,
    syncStatus: syncStatus ?? this.syncStatus,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  FarmerLocal copyWithCompanion(FarmersCompanion data) {
    return FarmerLocal(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      idTypeId: data.idTypeId.present ? data.idTypeId.value : this.idTypeId,
      idNumber: data.idNumber.present ? data.idNumber.value : this.idNumber,
      firstNameAr: data.firstNameAr.present
          ? data.firstNameAr.value
          : this.firstNameAr,
      fatherNameAr: data.fatherNameAr.present
          ? data.fatherNameAr.value
          : this.fatherNameAr,
      grandfatherNameAr: data.grandfatherNameAr.present
          ? data.grandfatherNameAr.value
          : this.grandfatherNameAr,
      familyNameAr: data.familyNameAr.present
          ? data.familyNameAr.value
          : this.familyNameAr,
      firstNameEn: data.firstNameEn.present
          ? data.firstNameEn.value
          : this.firstNameEn,
      fatherNameEn: data.fatherNameEn.present
          ? data.fatherNameEn.value
          : this.fatherNameEn,
      grandfatherNameEn: data.grandfatherNameEn.present
          ? data.grandfatherNameEn.value
          : this.grandfatherNameEn,
      familyNameEn: data.familyNameEn.present
          ? data.familyNameEn.value
          : this.familyNameEn,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      gender: data.gender.present ? data.gender.value : this.gender,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      familySize: data.familySize.present
          ? data.familySize.value
          : this.familySize,
      governorateId: data.governorateId.present
          ? data.governorateId.value
          : this.governorateId,
      localityId: data.localityId.present
          ? data.localityId.value
          : this.localityId,
      address: data.address.present ? data.address.value : this.address,
      name: data.name.present ? data.name.value : this.name,
      nationalId: data.nationalId.present
          ? data.nationalId.value
          : this.nationalId,
      rowVersion: data.rowVersion.present
          ? data.rowVersion.value
          : this.rowVersion,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FarmerLocal(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('idTypeId: $idTypeId, ')
          ..write('idNumber: $idNumber, ')
          ..write('firstNameAr: $firstNameAr, ')
          ..write('fatherNameAr: $fatherNameAr, ')
          ..write('grandfatherNameAr: $grandfatherNameAr, ')
          ..write('familyNameAr: $familyNameAr, ')
          ..write('firstNameEn: $firstNameEn, ')
          ..write('fatherNameEn: $fatherNameEn, ')
          ..write('grandfatherNameEn: $grandfatherNameEn, ')
          ..write('familyNameEn: $familyNameEn, ')
          ..write('birthDate: $birthDate, ')
          ..write('gender: $gender, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('familySize: $familySize, ')
          ..write('governorateId: $governorateId, ')
          ..write('localityId: $localityId, ')
          ..write('address: $address, ')
          ..write('name: $name, ')
          ..write('nationalId: $nationalId, ')
          ..write('rowVersion: $rowVersion, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    serverId,
    idTypeId,
    idNumber,
    firstNameAr,
    fatherNameAr,
    grandfatherNameAr,
    familyNameAr,
    firstNameEn,
    fatherNameEn,
    grandfatherNameEn,
    familyNameEn,
    birthDate,
    gender,
    phoneNumber,
    familySize,
    governorateId,
    localityId,
    address,
    name,
    nationalId,
    rowVersion,
    syncStatus,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FarmerLocal &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.idTypeId == this.idTypeId &&
          other.idNumber == this.idNumber &&
          other.firstNameAr == this.firstNameAr &&
          other.fatherNameAr == this.fatherNameAr &&
          other.grandfatherNameAr == this.grandfatherNameAr &&
          other.familyNameAr == this.familyNameAr &&
          other.firstNameEn == this.firstNameEn &&
          other.fatherNameEn == this.fatherNameEn &&
          other.grandfatherNameEn == this.grandfatherNameEn &&
          other.familyNameEn == this.familyNameEn &&
          other.birthDate == this.birthDate &&
          other.gender == this.gender &&
          other.phoneNumber == this.phoneNumber &&
          other.familySize == this.familySize &&
          other.governorateId == this.governorateId &&
          other.localityId == this.localityId &&
          other.address == this.address &&
          other.name == this.name &&
          other.nationalId == this.nationalId &&
          other.rowVersion == this.rowVersion &&
          other.syncStatus == this.syncStatus &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FarmersCompanion extends UpdateCompanion<FarmerLocal> {
  final Value<String> id;
  final Value<String?> serverId;
  final Value<int> idTypeId;
  final Value<String> idNumber;
  final Value<String> firstNameAr;
  final Value<String> fatherNameAr;
  final Value<String> grandfatherNameAr;
  final Value<String> familyNameAr;
  final Value<String> firstNameEn;
  final Value<String> fatherNameEn;
  final Value<String> grandfatherNameEn;
  final Value<String> familyNameEn;
  final Value<DateTime?> birthDate;
  final Value<int> gender;
  final Value<String> phoneNumber;
  final Value<int> familySize;
  final Value<String> governorateId;
  final Value<String> localityId;
  final Value<String> address;
  final Value<String> name;
  final Value<String> nationalId;
  final Value<String> rowVersion;
  final Value<String> syncStatus;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const FarmersCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.idTypeId = const Value.absent(),
    this.idNumber = const Value.absent(),
    this.firstNameAr = const Value.absent(),
    this.fatherNameAr = const Value.absent(),
    this.grandfatherNameAr = const Value.absent(),
    this.familyNameAr = const Value.absent(),
    this.firstNameEn = const Value.absent(),
    this.fatherNameEn = const Value.absent(),
    this.grandfatherNameEn = const Value.absent(),
    this.familyNameEn = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.gender = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.familySize = const Value.absent(),
    this.governorateId = const Value.absent(),
    this.localityId = const Value.absent(),
    this.address = const Value.absent(),
    this.name = const Value.absent(),
    this.nationalId = const Value.absent(),
    this.rowVersion = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FarmersCompanion.insert({
    required String id,
    this.serverId = const Value.absent(),
    this.idTypeId = const Value.absent(),
    this.idNumber = const Value.absent(),
    this.firstNameAr = const Value.absent(),
    this.fatherNameAr = const Value.absent(),
    this.grandfatherNameAr = const Value.absent(),
    this.familyNameAr = const Value.absent(),
    this.firstNameEn = const Value.absent(),
    this.fatherNameEn = const Value.absent(),
    this.grandfatherNameEn = const Value.absent(),
    this.familyNameEn = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.gender = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.familySize = const Value.absent(),
    this.governorateId = const Value.absent(),
    this.localityId = const Value.absent(),
    this.address = const Value.absent(),
    this.name = const Value.absent(),
    this.nationalId = const Value.absent(),
    this.rowVersion = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<FarmerLocal> custom({
    Expression<String>? id,
    Expression<String>? serverId,
    Expression<int>? idTypeId,
    Expression<String>? idNumber,
    Expression<String>? firstNameAr,
    Expression<String>? fatherNameAr,
    Expression<String>? grandfatherNameAr,
    Expression<String>? familyNameAr,
    Expression<String>? firstNameEn,
    Expression<String>? fatherNameEn,
    Expression<String>? grandfatherNameEn,
    Expression<String>? familyNameEn,
    Expression<DateTime>? birthDate,
    Expression<int>? gender,
    Expression<String>? phoneNumber,
    Expression<int>? familySize,
    Expression<String>? governorateId,
    Expression<String>? localityId,
    Expression<String>? address,
    Expression<String>? name,
    Expression<String>? nationalId,
    Expression<String>? rowVersion,
    Expression<String>? syncStatus,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (idTypeId != null) 'id_type_id': idTypeId,
      if (idNumber != null) 'id_number': idNumber,
      if (firstNameAr != null) 'first_name_ar': firstNameAr,
      if (fatherNameAr != null) 'father_name_ar': fatherNameAr,
      if (grandfatherNameAr != null) 'grandfather_name_ar': grandfatherNameAr,
      if (familyNameAr != null) 'family_name_ar': familyNameAr,
      if (firstNameEn != null) 'first_name_en': firstNameEn,
      if (fatherNameEn != null) 'father_name_en': fatherNameEn,
      if (grandfatherNameEn != null) 'grandfather_name_en': grandfatherNameEn,
      if (familyNameEn != null) 'family_name_en': familyNameEn,
      if (birthDate != null) 'birth_date': birthDate,
      if (gender != null) 'gender': gender,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (familySize != null) 'family_size': familySize,
      if (governorateId != null) 'governorate_id': governorateId,
      if (localityId != null) 'locality_id': localityId,
      if (address != null) 'address': address,
      if (name != null) 'name': name,
      if (nationalId != null) 'national_id': nationalId,
      if (rowVersion != null) 'row_version': rowVersion,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FarmersCompanion copyWith({
    Value<String>? id,
    Value<String?>? serverId,
    Value<int>? idTypeId,
    Value<String>? idNumber,
    Value<String>? firstNameAr,
    Value<String>? fatherNameAr,
    Value<String>? grandfatherNameAr,
    Value<String>? familyNameAr,
    Value<String>? firstNameEn,
    Value<String>? fatherNameEn,
    Value<String>? grandfatherNameEn,
    Value<String>? familyNameEn,
    Value<DateTime?>? birthDate,
    Value<int>? gender,
    Value<String>? phoneNumber,
    Value<int>? familySize,
    Value<String>? governorateId,
    Value<String>? localityId,
    Value<String>? address,
    Value<String>? name,
    Value<String>? nationalId,
    Value<String>? rowVersion,
    Value<String>? syncStatus,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return FarmersCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      idTypeId: idTypeId ?? this.idTypeId,
      idNumber: idNumber ?? this.idNumber,
      firstNameAr: firstNameAr ?? this.firstNameAr,
      fatherNameAr: fatherNameAr ?? this.fatherNameAr,
      grandfatherNameAr: grandfatherNameAr ?? this.grandfatherNameAr,
      familyNameAr: familyNameAr ?? this.familyNameAr,
      firstNameEn: firstNameEn ?? this.firstNameEn,
      fatherNameEn: fatherNameEn ?? this.fatherNameEn,
      grandfatherNameEn: grandfatherNameEn ?? this.grandfatherNameEn,
      familyNameEn: familyNameEn ?? this.familyNameEn,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      familySize: familySize ?? this.familySize,
      governorateId: governorateId ?? this.governorateId,
      localityId: localityId ?? this.localityId,
      address: address ?? this.address,
      name: name ?? this.name,
      nationalId: nationalId ?? this.nationalId,
      rowVersion: rowVersion ?? this.rowVersion,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (idTypeId.present) {
      map['id_type_id'] = Variable<int>(idTypeId.value);
    }
    if (idNumber.present) {
      map['id_number'] = Variable<String>(idNumber.value);
    }
    if (firstNameAr.present) {
      map['first_name_ar'] = Variable<String>(firstNameAr.value);
    }
    if (fatherNameAr.present) {
      map['father_name_ar'] = Variable<String>(fatherNameAr.value);
    }
    if (grandfatherNameAr.present) {
      map['grandfather_name_ar'] = Variable<String>(grandfatherNameAr.value);
    }
    if (familyNameAr.present) {
      map['family_name_ar'] = Variable<String>(familyNameAr.value);
    }
    if (firstNameEn.present) {
      map['first_name_en'] = Variable<String>(firstNameEn.value);
    }
    if (fatherNameEn.present) {
      map['father_name_en'] = Variable<String>(fatherNameEn.value);
    }
    if (grandfatherNameEn.present) {
      map['grandfather_name_en'] = Variable<String>(grandfatherNameEn.value);
    }
    if (familyNameEn.present) {
      map['family_name_en'] = Variable<String>(familyNameEn.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<DateTime>(birthDate.value);
    }
    if (gender.present) {
      map['gender'] = Variable<int>(gender.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (familySize.present) {
      map['family_size'] = Variable<int>(familySize.value);
    }
    if (governorateId.present) {
      map['governorate_id'] = Variable<String>(governorateId.value);
    }
    if (localityId.present) {
      map['locality_id'] = Variable<String>(localityId.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nationalId.present) {
      map['national_id'] = Variable<String>(nationalId.value);
    }
    if (rowVersion.present) {
      map['row_version'] = Variable<String>(rowVersion.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FarmersCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('idTypeId: $idTypeId, ')
          ..write('idNumber: $idNumber, ')
          ..write('firstNameAr: $firstNameAr, ')
          ..write('fatherNameAr: $fatherNameAr, ')
          ..write('grandfatherNameAr: $grandfatherNameAr, ')
          ..write('familyNameAr: $familyNameAr, ')
          ..write('firstNameEn: $firstNameEn, ')
          ..write('fatherNameEn: $fatherNameEn, ')
          ..write('grandfatherNameEn: $grandfatherNameEn, ')
          ..write('familyNameEn: $familyNameEn, ')
          ..write('birthDate: $birthDate, ')
          ..write('gender: $gender, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('familySize: $familySize, ')
          ..write('governorateId: $governorateId, ')
          ..write('localityId: $localityId, ')
          ..write('address: $address, ')
          ..write('name: $name, ')
          ..write('nationalId: $nationalId, ')
          ..write('rowVersion: $rowVersion, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FarmsTable extends Farms with TableInfo<$FarmsTable, FarmLocal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FarmsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _farmerIdMeta = const VerificationMeta(
    'farmerId',
  );
  @override
  late final GeneratedColumn<String> farmerId = GeneratedColumn<String>(
    'farmer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 200),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _governorateIdMeta = const VerificationMeta(
    'governorateId',
  );
  @override
  late final GeneratedColumn<String> governorateId = GeneratedColumn<String>(
    'governorate_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localityIdMeta = const VerificationMeta(
    'localityId',
  );
  @override
  late final GeneratedColumn<String> localityId = GeneratedColumn<String>(
    'locality_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _landAreaMeta = const VerificationMeta(
    'landArea',
  );
  @override
  late final GeneratedColumn<double> landArea = GeneratedColumn<double>(
    'land_area',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _landAreaUnitMeta = const VerificationMeta(
    'landAreaUnit',
  );
  @override
  late final GeneratedColumn<String> landAreaUnit = GeneratedColumn<String>(
    'land_area_unit',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ownershipTypeIdMeta = const VerificationMeta(
    'ownershipTypeId',
  );
  @override
  late final GeneratedColumn<String> ownershipTypeId = GeneratedColumn<String>(
    'ownership_type_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rowVersionMeta = const VerificationMeta(
    'rowVersion',
  );
  @override
  late final GeneratedColumn<String> rowVersion = GeneratedColumn<String>(
    'row_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('completed'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    farmerId,
    name,
    governorateId,
    localityId,
    landArea,
    landAreaUnit,
    latitude,
    longitude,
    ownershipTypeId,
    rowVersion,
    syncStatus,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'farms';
  @override
  VerificationContext validateIntegrity(
    Insertable<FarmLocal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('farmer_id')) {
      context.handle(
        _farmerIdMeta,
        farmerId.isAcceptableOrUnknown(data['farmer_id']!, _farmerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_farmerIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('governorate_id')) {
      context.handle(
        _governorateIdMeta,
        governorateId.isAcceptableOrUnknown(
          data['governorate_id']!,
          _governorateIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_governorateIdMeta);
    }
    if (data.containsKey('locality_id')) {
      context.handle(
        _localityIdMeta,
        localityId.isAcceptableOrUnknown(data['locality_id']!, _localityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_localityIdMeta);
    }
    if (data.containsKey('land_area')) {
      context.handle(
        _landAreaMeta,
        landArea.isAcceptableOrUnknown(data['land_area']!, _landAreaMeta),
      );
    } else if (isInserting) {
      context.missing(_landAreaMeta);
    }
    if (data.containsKey('land_area_unit')) {
      context.handle(
        _landAreaUnitMeta,
        landAreaUnit.isAcceptableOrUnknown(
          data['land_area_unit']!,
          _landAreaUnitMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_landAreaUnitMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('ownership_type_id')) {
      context.handle(
        _ownershipTypeIdMeta,
        ownershipTypeId.isAcceptableOrUnknown(
          data['ownership_type_id']!,
          _ownershipTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ownershipTypeIdMeta);
    }
    if (data.containsKey('row_version')) {
      context.handle(
        _rowVersionMeta,
        rowVersion.isAcceptableOrUnknown(data['row_version']!, _rowVersionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
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
  FarmLocal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FarmLocal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      ),
      farmerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}farmer_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      governorateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}governorate_id'],
      )!,
      localityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locality_id'],
      )!,
      landArea: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}land_area'],
      )!,
      landAreaUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}land_area_unit'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      ownershipTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ownership_type_id'],
      )!,
      rowVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}row_version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $FarmsTable createAlias(String alias) {
    return $FarmsTable(attachedDatabase, alias);
  }
}

class FarmLocal extends DataClass implements Insertable<FarmLocal> {
  final String id;
  final String? serverId;
  final String farmerId;
  final String name;
  final String governorateId;
  final String localityId;
  final double landArea;
  final String landAreaUnit;
  final double? latitude;
  final double? longitude;
  final String ownershipTypeId;
  final String rowVersion;
  final String syncStatus;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const FarmLocal({
    required this.id,
    this.serverId,
    required this.farmerId,
    required this.name,
    required this.governorateId,
    required this.localityId,
    required this.landArea,
    required this.landAreaUnit,
    this.latitude,
    this.longitude,
    required this.ownershipTypeId,
    required this.rowVersion,
    required this.syncStatus,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    map['farmer_id'] = Variable<String>(farmerId);
    map['name'] = Variable<String>(name);
    map['governorate_id'] = Variable<String>(governorateId);
    map['locality_id'] = Variable<String>(localityId);
    map['land_area'] = Variable<double>(landArea);
    map['land_area_unit'] = Variable<String>(landAreaUnit);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    map['ownership_type_id'] = Variable<String>(ownershipTypeId);
    map['row_version'] = Variable<String>(rowVersion);
    map['sync_status'] = Variable<String>(syncStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  FarmsCompanion toCompanion(bool nullToAbsent) {
    return FarmsCompanion(
      id: Value(id),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      farmerId: Value(farmerId),
      name: Value(name),
      governorateId: Value(governorateId),
      localityId: Value(localityId),
      landArea: Value(landArea),
      landAreaUnit: Value(landAreaUnit),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      ownershipTypeId: Value(ownershipTypeId),
      rowVersion: Value(rowVersion),
      syncStatus: Value(syncStatus),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory FarmLocal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FarmLocal(
      id: serializer.fromJson<String>(json['id']),
      serverId: serializer.fromJson<String?>(json['serverId']),
      farmerId: serializer.fromJson<String>(json['farmerId']),
      name: serializer.fromJson<String>(json['name']),
      governorateId: serializer.fromJson<String>(json['governorateId']),
      localityId: serializer.fromJson<String>(json['localityId']),
      landArea: serializer.fromJson<double>(json['landArea']),
      landAreaUnit: serializer.fromJson<String>(json['landAreaUnit']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      ownershipTypeId: serializer.fromJson<String>(json['ownershipTypeId']),
      rowVersion: serializer.fromJson<String>(json['rowVersion']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'serverId': serializer.toJson<String?>(serverId),
      'farmerId': serializer.toJson<String>(farmerId),
      'name': serializer.toJson<String>(name),
      'governorateId': serializer.toJson<String>(governorateId),
      'localityId': serializer.toJson<String>(localityId),
      'landArea': serializer.toJson<double>(landArea),
      'landAreaUnit': serializer.toJson<String>(landAreaUnit),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'ownershipTypeId': serializer.toJson<String>(ownershipTypeId),
      'rowVersion': serializer.toJson<String>(rowVersion),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  FarmLocal copyWith({
    String? id,
    Value<String?> serverId = const Value.absent(),
    String? farmerId,
    String? name,
    String? governorateId,
    String? localityId,
    double? landArea,
    String? landAreaUnit,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    String? ownershipTypeId,
    String? rowVersion,
    String? syncStatus,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => FarmLocal(
    id: id ?? this.id,
    serverId: serverId.present ? serverId.value : this.serverId,
    farmerId: farmerId ?? this.farmerId,
    name: name ?? this.name,
    governorateId: governorateId ?? this.governorateId,
    localityId: localityId ?? this.localityId,
    landArea: landArea ?? this.landArea,
    landAreaUnit: landAreaUnit ?? this.landAreaUnit,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    ownershipTypeId: ownershipTypeId ?? this.ownershipTypeId,
    rowVersion: rowVersion ?? this.rowVersion,
    syncStatus: syncStatus ?? this.syncStatus,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  FarmLocal copyWithCompanion(FarmsCompanion data) {
    return FarmLocal(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      farmerId: data.farmerId.present ? data.farmerId.value : this.farmerId,
      name: data.name.present ? data.name.value : this.name,
      governorateId: data.governorateId.present
          ? data.governorateId.value
          : this.governorateId,
      localityId: data.localityId.present
          ? data.localityId.value
          : this.localityId,
      landArea: data.landArea.present ? data.landArea.value : this.landArea,
      landAreaUnit: data.landAreaUnit.present
          ? data.landAreaUnit.value
          : this.landAreaUnit,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      ownershipTypeId: data.ownershipTypeId.present
          ? data.ownershipTypeId.value
          : this.ownershipTypeId,
      rowVersion: data.rowVersion.present
          ? data.rowVersion.value
          : this.rowVersion,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FarmLocal(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('farmerId: $farmerId, ')
          ..write('name: $name, ')
          ..write('governorateId: $governorateId, ')
          ..write('localityId: $localityId, ')
          ..write('landArea: $landArea, ')
          ..write('landAreaUnit: $landAreaUnit, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('ownershipTypeId: $ownershipTypeId, ')
          ..write('rowVersion: $rowVersion, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    farmerId,
    name,
    governorateId,
    localityId,
    landArea,
    landAreaUnit,
    latitude,
    longitude,
    ownershipTypeId,
    rowVersion,
    syncStatus,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FarmLocal &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.farmerId == this.farmerId &&
          other.name == this.name &&
          other.governorateId == this.governorateId &&
          other.localityId == this.localityId &&
          other.landArea == this.landArea &&
          other.landAreaUnit == this.landAreaUnit &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.ownershipTypeId == this.ownershipTypeId &&
          other.rowVersion == this.rowVersion &&
          other.syncStatus == this.syncStatus &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FarmsCompanion extends UpdateCompanion<FarmLocal> {
  final Value<String> id;
  final Value<String?> serverId;
  final Value<String> farmerId;
  final Value<String> name;
  final Value<String> governorateId;
  final Value<String> localityId;
  final Value<double> landArea;
  final Value<String> landAreaUnit;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String> ownershipTypeId;
  final Value<String> rowVersion;
  final Value<String> syncStatus;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const FarmsCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.farmerId = const Value.absent(),
    this.name = const Value.absent(),
    this.governorateId = const Value.absent(),
    this.localityId = const Value.absent(),
    this.landArea = const Value.absent(),
    this.landAreaUnit = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.ownershipTypeId = const Value.absent(),
    this.rowVersion = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FarmsCompanion.insert({
    required String id,
    this.serverId = const Value.absent(),
    required String farmerId,
    required String name,
    required String governorateId,
    required String localityId,
    required double landArea,
    required String landAreaUnit,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    required String ownershipTypeId,
    this.rowVersion = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       farmerId = Value(farmerId),
       name = Value(name),
       governorateId = Value(governorateId),
       localityId = Value(localityId),
       landArea = Value(landArea),
       landAreaUnit = Value(landAreaUnit),
       ownershipTypeId = Value(ownershipTypeId);
  static Insertable<FarmLocal> custom({
    Expression<String>? id,
    Expression<String>? serverId,
    Expression<String>? farmerId,
    Expression<String>? name,
    Expression<String>? governorateId,
    Expression<String>? localityId,
    Expression<double>? landArea,
    Expression<String>? landAreaUnit,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? ownershipTypeId,
    Expression<String>? rowVersion,
    Expression<String>? syncStatus,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (farmerId != null) 'farmer_id': farmerId,
      if (name != null) 'name': name,
      if (governorateId != null) 'governorate_id': governorateId,
      if (localityId != null) 'locality_id': localityId,
      if (landArea != null) 'land_area': landArea,
      if (landAreaUnit != null) 'land_area_unit': landAreaUnit,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (ownershipTypeId != null) 'ownership_type_id': ownershipTypeId,
      if (rowVersion != null) 'row_version': rowVersion,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FarmsCompanion copyWith({
    Value<String>? id,
    Value<String?>? serverId,
    Value<String>? farmerId,
    Value<String>? name,
    Value<String>? governorateId,
    Value<String>? localityId,
    Value<double>? landArea,
    Value<String>? landAreaUnit,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<String>? ownershipTypeId,
    Value<String>? rowVersion,
    Value<String>? syncStatus,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return FarmsCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      farmerId: farmerId ?? this.farmerId,
      name: name ?? this.name,
      governorateId: governorateId ?? this.governorateId,
      localityId: localityId ?? this.localityId,
      landArea: landArea ?? this.landArea,
      landAreaUnit: landAreaUnit ?? this.landAreaUnit,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      ownershipTypeId: ownershipTypeId ?? this.ownershipTypeId,
      rowVersion: rowVersion ?? this.rowVersion,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (farmerId.present) {
      map['farmer_id'] = Variable<String>(farmerId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (governorateId.present) {
      map['governorate_id'] = Variable<String>(governorateId.value);
    }
    if (localityId.present) {
      map['locality_id'] = Variable<String>(localityId.value);
    }
    if (landArea.present) {
      map['land_area'] = Variable<double>(landArea.value);
    }
    if (landAreaUnit.present) {
      map['land_area_unit'] = Variable<String>(landAreaUnit.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (ownershipTypeId.present) {
      map['ownership_type_id'] = Variable<String>(ownershipTypeId.value);
    }
    if (rowVersion.present) {
      map['row_version'] = Variable<String>(rowVersion.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FarmsCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('farmerId: $farmerId, ')
          ..write('name: $name, ')
          ..write('governorateId: $governorateId, ')
          ..write('localityId: $localityId, ')
          ..write('landArea: $landArea, ')
          ..write('landAreaUnit: $landAreaUnit, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('ownershipTypeId: $ownershipTypeId, ')
          ..write('rowVersion: $rowVersion, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DamageReportsTable extends DamageReports
    with TableInfo<$DamageReportsTable, DamageReportLocal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DamageReportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _farmIdMeta = const VerificationMeta('farmId');
  @override
  late final GeneratedColumn<String> farmId = GeneratedColumn<String>(
    'farm_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _farmerIdMeta = const VerificationMeta(
    'farmerId',
  );
  @override
  late final GeneratedColumn<String> farmerId = GeneratedColumn<String>(
    'farmer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _damageDateMeta = const VerificationMeta(
    'damageDate',
  );
  @override
  late final GeneratedColumn<DateTime> damageDate = GeneratedColumn<DateTime>(
    'damage_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _documentationDateMeta = const VerificationMeta(
    'documentationDate',
  );
  @override
  late final GeneratedColumn<DateTime> documentationDate =
      GeneratedColumn<DateTime>(
        'documentation_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _governorateIdMeta = const VerificationMeta(
    'governorateId',
  );
  @override
  late final GeneratedColumn<String> governorateId = GeneratedColumn<String>(
    'governorate_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localityIdMeta = const VerificationMeta(
    'localityId',
  );
  @override
  late final GeneratedColumn<String> localityId = GeneratedColumn<String>(
    'locality_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusIdMeta = const VerificationMeta(
    'statusId',
  );
  @override
  late final GeneratedColumn<String> statusId = GeneratedColumn<String>(
    'status_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rowVersionMeta = const VerificationMeta(
    'rowVersion',
  );
  @override
  late final GeneratedColumn<String> rowVersion = GeneratedColumn<String>(
    'row_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('completed'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    farmId,
    farmerId,
    damageDate,
    documentationDate,
    governorateId,
    localityId,
    latitude,
    longitude,
    statusId,
    notes,
    rowVersion,
    syncStatus,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'damage_reports';
  @override
  VerificationContext validateIntegrity(
    Insertable<DamageReportLocal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('farm_id')) {
      context.handle(
        _farmIdMeta,
        farmId.isAcceptableOrUnknown(data['farm_id']!, _farmIdMeta),
      );
    } else if (isInserting) {
      context.missing(_farmIdMeta);
    }
    if (data.containsKey('farmer_id')) {
      context.handle(
        _farmerIdMeta,
        farmerId.isAcceptableOrUnknown(data['farmer_id']!, _farmerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_farmerIdMeta);
    }
    if (data.containsKey('damage_date')) {
      context.handle(
        _damageDateMeta,
        damageDate.isAcceptableOrUnknown(data['damage_date']!, _damageDateMeta),
      );
    } else if (isInserting) {
      context.missing(_damageDateMeta);
    }
    if (data.containsKey('documentation_date')) {
      context.handle(
        _documentationDateMeta,
        documentationDate.isAcceptableOrUnknown(
          data['documentation_date']!,
          _documentationDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_documentationDateMeta);
    }
    if (data.containsKey('governorate_id')) {
      context.handle(
        _governorateIdMeta,
        governorateId.isAcceptableOrUnknown(
          data['governorate_id']!,
          _governorateIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_governorateIdMeta);
    }
    if (data.containsKey('locality_id')) {
      context.handle(
        _localityIdMeta,
        localityId.isAcceptableOrUnknown(data['locality_id']!, _localityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_localityIdMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('status_id')) {
      context.handle(
        _statusIdMeta,
        statusId.isAcceptableOrUnknown(data['status_id']!, _statusIdMeta),
      );
    } else if (isInserting) {
      context.missing(_statusIdMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    } else if (isInserting) {
      context.missing(_notesMeta);
    }
    if (data.containsKey('row_version')) {
      context.handle(
        _rowVersionMeta,
        rowVersion.isAcceptableOrUnknown(data['row_version']!, _rowVersionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
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
  DamageReportLocal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DamageReportLocal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      ),
      farmId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}farm_id'],
      )!,
      farmerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}farmer_id'],
      )!,
      damageDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}damage_date'],
      )!,
      documentationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}documentation_date'],
      )!,
      governorateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}governorate_id'],
      )!,
      localityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}locality_id'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      statusId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status_id'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      rowVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}row_version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $DamageReportsTable createAlias(String alias) {
    return $DamageReportsTable(attachedDatabase, alias);
  }
}

class DamageReportLocal extends DataClass
    implements Insertable<DamageReportLocal> {
  final String id;
  final String? serverId;
  final String farmId;
  final String farmerId;
  final DateTime damageDate;
  final DateTime documentationDate;
  final String governorateId;
  final String localityId;
  final double? latitude;
  final double? longitude;
  final String statusId;
  final String notes;
  final String rowVersion;
  final String syncStatus;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const DamageReportLocal({
    required this.id,
    this.serverId,
    required this.farmId,
    required this.farmerId,
    required this.damageDate,
    required this.documentationDate,
    required this.governorateId,
    required this.localityId,
    this.latitude,
    this.longitude,
    required this.statusId,
    required this.notes,
    required this.rowVersion,
    required this.syncStatus,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    map['farm_id'] = Variable<String>(farmId);
    map['farmer_id'] = Variable<String>(farmerId);
    map['damage_date'] = Variable<DateTime>(damageDate);
    map['documentation_date'] = Variable<DateTime>(documentationDate);
    map['governorate_id'] = Variable<String>(governorateId);
    map['locality_id'] = Variable<String>(localityId);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    map['status_id'] = Variable<String>(statusId);
    map['notes'] = Variable<String>(notes);
    map['row_version'] = Variable<String>(rowVersion);
    map['sync_status'] = Variable<String>(syncStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  DamageReportsCompanion toCompanion(bool nullToAbsent) {
    return DamageReportsCompanion(
      id: Value(id),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      farmId: Value(farmId),
      farmerId: Value(farmerId),
      damageDate: Value(damageDate),
      documentationDate: Value(documentationDate),
      governorateId: Value(governorateId),
      localityId: Value(localityId),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      statusId: Value(statusId),
      notes: Value(notes),
      rowVersion: Value(rowVersion),
      syncStatus: Value(syncStatus),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory DamageReportLocal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DamageReportLocal(
      id: serializer.fromJson<String>(json['id']),
      serverId: serializer.fromJson<String?>(json['serverId']),
      farmId: serializer.fromJson<String>(json['farmId']),
      farmerId: serializer.fromJson<String>(json['farmerId']),
      damageDate: serializer.fromJson<DateTime>(json['damageDate']),
      documentationDate: serializer.fromJson<DateTime>(
        json['documentationDate'],
      ),
      governorateId: serializer.fromJson<String>(json['governorateId']),
      localityId: serializer.fromJson<String>(json['localityId']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      statusId: serializer.fromJson<String>(json['statusId']),
      notes: serializer.fromJson<String>(json['notes']),
      rowVersion: serializer.fromJson<String>(json['rowVersion']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'serverId': serializer.toJson<String?>(serverId),
      'farmId': serializer.toJson<String>(farmId),
      'farmerId': serializer.toJson<String>(farmerId),
      'damageDate': serializer.toJson<DateTime>(damageDate),
      'documentationDate': serializer.toJson<DateTime>(documentationDate),
      'governorateId': serializer.toJson<String>(governorateId),
      'localityId': serializer.toJson<String>(localityId),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'statusId': serializer.toJson<String>(statusId),
      'notes': serializer.toJson<String>(notes),
      'rowVersion': serializer.toJson<String>(rowVersion),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  DamageReportLocal copyWith({
    String? id,
    Value<String?> serverId = const Value.absent(),
    String? farmId,
    String? farmerId,
    DateTime? damageDate,
    DateTime? documentationDate,
    String? governorateId,
    String? localityId,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    String? statusId,
    String? notes,
    String? rowVersion,
    String? syncStatus,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => DamageReportLocal(
    id: id ?? this.id,
    serverId: serverId.present ? serverId.value : this.serverId,
    farmId: farmId ?? this.farmId,
    farmerId: farmerId ?? this.farmerId,
    damageDate: damageDate ?? this.damageDate,
    documentationDate: documentationDate ?? this.documentationDate,
    governorateId: governorateId ?? this.governorateId,
    localityId: localityId ?? this.localityId,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    statusId: statusId ?? this.statusId,
    notes: notes ?? this.notes,
    rowVersion: rowVersion ?? this.rowVersion,
    syncStatus: syncStatus ?? this.syncStatus,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  DamageReportLocal copyWithCompanion(DamageReportsCompanion data) {
    return DamageReportLocal(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      farmId: data.farmId.present ? data.farmId.value : this.farmId,
      farmerId: data.farmerId.present ? data.farmerId.value : this.farmerId,
      damageDate: data.damageDate.present
          ? data.damageDate.value
          : this.damageDate,
      documentationDate: data.documentationDate.present
          ? data.documentationDate.value
          : this.documentationDate,
      governorateId: data.governorateId.present
          ? data.governorateId.value
          : this.governorateId,
      localityId: data.localityId.present
          ? data.localityId.value
          : this.localityId,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      statusId: data.statusId.present ? data.statusId.value : this.statusId,
      notes: data.notes.present ? data.notes.value : this.notes,
      rowVersion: data.rowVersion.present
          ? data.rowVersion.value
          : this.rowVersion,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DamageReportLocal(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('farmId: $farmId, ')
          ..write('farmerId: $farmerId, ')
          ..write('damageDate: $damageDate, ')
          ..write('documentationDate: $documentationDate, ')
          ..write('governorateId: $governorateId, ')
          ..write('localityId: $localityId, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('statusId: $statusId, ')
          ..write('notes: $notes, ')
          ..write('rowVersion: $rowVersion, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    farmId,
    farmerId,
    damageDate,
    documentationDate,
    governorateId,
    localityId,
    latitude,
    longitude,
    statusId,
    notes,
    rowVersion,
    syncStatus,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DamageReportLocal &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.farmId == this.farmId &&
          other.farmerId == this.farmerId &&
          other.damageDate == this.damageDate &&
          other.documentationDate == this.documentationDate &&
          other.governorateId == this.governorateId &&
          other.localityId == this.localityId &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.statusId == this.statusId &&
          other.notes == this.notes &&
          other.rowVersion == this.rowVersion &&
          other.syncStatus == this.syncStatus &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DamageReportsCompanion extends UpdateCompanion<DamageReportLocal> {
  final Value<String> id;
  final Value<String?> serverId;
  final Value<String> farmId;
  final Value<String> farmerId;
  final Value<DateTime> damageDate;
  final Value<DateTime> documentationDate;
  final Value<String> governorateId;
  final Value<String> localityId;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String> statusId;
  final Value<String> notes;
  final Value<String> rowVersion;
  final Value<String> syncStatus;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const DamageReportsCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.farmId = const Value.absent(),
    this.farmerId = const Value.absent(),
    this.damageDate = const Value.absent(),
    this.documentationDate = const Value.absent(),
    this.governorateId = const Value.absent(),
    this.localityId = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.statusId = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowVersion = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DamageReportsCompanion.insert({
    required String id,
    this.serverId = const Value.absent(),
    required String farmId,
    required String farmerId,
    required DateTime damageDate,
    required DateTime documentationDate,
    required String governorateId,
    required String localityId,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    required String statusId,
    required String notes,
    this.rowVersion = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       farmId = Value(farmId),
       farmerId = Value(farmerId),
       damageDate = Value(damageDate),
       documentationDate = Value(documentationDate),
       governorateId = Value(governorateId),
       localityId = Value(localityId),
       statusId = Value(statusId),
       notes = Value(notes);
  static Insertable<DamageReportLocal> custom({
    Expression<String>? id,
    Expression<String>? serverId,
    Expression<String>? farmId,
    Expression<String>? farmerId,
    Expression<DateTime>? damageDate,
    Expression<DateTime>? documentationDate,
    Expression<String>? governorateId,
    Expression<String>? localityId,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? statusId,
    Expression<String>? notes,
    Expression<String>? rowVersion,
    Expression<String>? syncStatus,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (farmId != null) 'farm_id': farmId,
      if (farmerId != null) 'farmer_id': farmerId,
      if (damageDate != null) 'damage_date': damageDate,
      if (documentationDate != null) 'documentation_date': documentationDate,
      if (governorateId != null) 'governorate_id': governorateId,
      if (localityId != null) 'locality_id': localityId,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (statusId != null) 'status_id': statusId,
      if (notes != null) 'notes': notes,
      if (rowVersion != null) 'row_version': rowVersion,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DamageReportsCompanion copyWith({
    Value<String>? id,
    Value<String?>? serverId,
    Value<String>? farmId,
    Value<String>? farmerId,
    Value<DateTime>? damageDate,
    Value<DateTime>? documentationDate,
    Value<String>? governorateId,
    Value<String>? localityId,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<String>? statusId,
    Value<String>? notes,
    Value<String>? rowVersion,
    Value<String>? syncStatus,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return DamageReportsCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      farmId: farmId ?? this.farmId,
      farmerId: farmerId ?? this.farmerId,
      damageDate: damageDate ?? this.damageDate,
      documentationDate: documentationDate ?? this.documentationDate,
      governorateId: governorateId ?? this.governorateId,
      localityId: localityId ?? this.localityId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      statusId: statusId ?? this.statusId,
      notes: notes ?? this.notes,
      rowVersion: rowVersion ?? this.rowVersion,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (farmId.present) {
      map['farm_id'] = Variable<String>(farmId.value);
    }
    if (farmerId.present) {
      map['farmer_id'] = Variable<String>(farmerId.value);
    }
    if (damageDate.present) {
      map['damage_date'] = Variable<DateTime>(damageDate.value);
    }
    if (documentationDate.present) {
      map['documentation_date'] = Variable<DateTime>(documentationDate.value);
    }
    if (governorateId.present) {
      map['governorate_id'] = Variable<String>(governorateId.value);
    }
    if (localityId.present) {
      map['locality_id'] = Variable<String>(localityId.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (statusId.present) {
      map['status_id'] = Variable<String>(statusId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowVersion.present) {
      map['row_version'] = Variable<String>(rowVersion.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DamageReportsCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('farmId: $farmId, ')
          ..write('farmerId: $farmerId, ')
          ..write('damageDate: $damageDate, ')
          ..write('documentationDate: $documentationDate, ')
          ..write('governorateId: $governorateId, ')
          ..write('localityId: $localityId, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('statusId: $statusId, ')
          ..write('notes: $notes, ')
          ..write('rowVersion: $rowVersion, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DamageItemsTable extends DamageItems
    with TableInfo<$DamageItemsTable, DamageItemLocal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DamageItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _damageReportIdMeta = const VerificationMeta(
    'damageReportId',
  );
  @override
  late final GeneratedColumn<String> damageReportId = GeneratedColumn<String>(
    'damage_report_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _agriculturalSectorIdMeta =
      const VerificationMeta('agriculturalSectorId');
  @override
  late final GeneratedColumn<String> agriculturalSectorId =
      GeneratedColumn<String>(
        'agricultural_sector_id',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _subSectorIdMeta = const VerificationMeta(
    'subSectorId',
  );
  @override
  late final GeneratedColumn<String> subSectorId = GeneratedColumn<String>(
    'sub_sector_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cropIdMeta = const VerificationMeta('cropId');
  @override
  late final GeneratedColumn<String> cropId = GeneratedColumn<String>(
    'crop_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _damageTypeIdMeta = const VerificationMeta(
    'damageTypeId',
  );
  @override
  late final GeneratedColumn<String> damageTypeId = GeneratedColumn<String>(
    'damage_type_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _affectedAreaMeta = const VerificationMeta(
    'affectedArea',
  );
  @override
  late final GeneratedColumn<double> affectedArea = GeneratedColumn<double>(
    'affected_area',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _damagePercentageMeta = const VerificationMeta(
    'damagePercentage',
  );
  @override
  late final GeneratedColumn<double> damagePercentage = GeneratedColumn<double>(
    'damage_percentage',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estimatedLossMeta = const VerificationMeta(
    'estimatedLoss',
  );
  @override
  late final GeneratedColumn<double> estimatedLoss = GeneratedColumn<double>(
    'estimated_loss',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rowVersionMeta = const VerificationMeta(
    'rowVersion',
  );
  @override
  late final GeneratedColumn<String> rowVersion = GeneratedColumn<String>(
    'row_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('completed'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    damageReportId,
    agriculturalSectorId,
    subSectorId,
    cropId,
    damageTypeId,
    affectedArea,
    damagePercentage,
    quantity,
    estimatedLoss,
    rowVersion,
    syncStatus,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'damage_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<DamageItemLocal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('damage_report_id')) {
      context.handle(
        _damageReportIdMeta,
        damageReportId.isAcceptableOrUnknown(
          data['damage_report_id']!,
          _damageReportIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_damageReportIdMeta);
    }
    if (data.containsKey('agricultural_sector_id')) {
      context.handle(
        _agriculturalSectorIdMeta,
        agriculturalSectorId.isAcceptableOrUnknown(
          data['agricultural_sector_id']!,
          _agriculturalSectorIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_agriculturalSectorIdMeta);
    }
    if (data.containsKey('sub_sector_id')) {
      context.handle(
        _subSectorIdMeta,
        subSectorId.isAcceptableOrUnknown(
          data['sub_sector_id']!,
          _subSectorIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subSectorIdMeta);
    }
    if (data.containsKey('crop_id')) {
      context.handle(
        _cropIdMeta,
        cropId.isAcceptableOrUnknown(data['crop_id']!, _cropIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cropIdMeta);
    }
    if (data.containsKey('damage_type_id')) {
      context.handle(
        _damageTypeIdMeta,
        damageTypeId.isAcceptableOrUnknown(
          data['damage_type_id']!,
          _damageTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_damageTypeIdMeta);
    }
    if (data.containsKey('affected_area')) {
      context.handle(
        _affectedAreaMeta,
        affectedArea.isAcceptableOrUnknown(
          data['affected_area']!,
          _affectedAreaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_affectedAreaMeta);
    }
    if (data.containsKey('damage_percentage')) {
      context.handle(
        _damagePercentageMeta,
        damagePercentage.isAcceptableOrUnknown(
          data['damage_percentage']!,
          _damagePercentageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_damagePercentageMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('estimated_loss')) {
      context.handle(
        _estimatedLossMeta,
        estimatedLoss.isAcceptableOrUnknown(
          data['estimated_loss']!,
          _estimatedLossMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_estimatedLossMeta);
    }
    if (data.containsKey('row_version')) {
      context.handle(
        _rowVersionMeta,
        rowVersion.isAcceptableOrUnknown(data['row_version']!, _rowVersionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
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
  DamageItemLocal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DamageItemLocal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      ),
      damageReportId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}damage_report_id'],
      )!,
      agriculturalSectorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}agricultural_sector_id'],
      )!,
      subSectorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sub_sector_id'],
      )!,
      cropId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}crop_id'],
      )!,
      damageTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}damage_type_id'],
      )!,
      affectedArea: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}affected_area'],
      )!,
      damagePercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}damage_percentage'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      estimatedLoss: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}estimated_loss'],
      )!,
      rowVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}row_version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $DamageItemsTable createAlias(String alias) {
    return $DamageItemsTable(attachedDatabase, alias);
  }
}

class DamageItemLocal extends DataClass implements Insertable<DamageItemLocal> {
  final String id;
  final String? serverId;
  final String damageReportId;
  final String agriculturalSectorId;
  final String subSectorId;
  final String cropId;
  final String damageTypeId;
  final double affectedArea;
  final double damagePercentage;
  final double quantity;
  final double estimatedLoss;
  final String rowVersion;
  final String syncStatus;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const DamageItemLocal({
    required this.id,
    this.serverId,
    required this.damageReportId,
    required this.agriculturalSectorId,
    required this.subSectorId,
    required this.cropId,
    required this.damageTypeId,
    required this.affectedArea,
    required this.damagePercentage,
    required this.quantity,
    required this.estimatedLoss,
    required this.rowVersion,
    required this.syncStatus,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    map['damage_report_id'] = Variable<String>(damageReportId);
    map['agricultural_sector_id'] = Variable<String>(agriculturalSectorId);
    map['sub_sector_id'] = Variable<String>(subSectorId);
    map['crop_id'] = Variable<String>(cropId);
    map['damage_type_id'] = Variable<String>(damageTypeId);
    map['affected_area'] = Variable<double>(affectedArea);
    map['damage_percentage'] = Variable<double>(damagePercentage);
    map['quantity'] = Variable<double>(quantity);
    map['estimated_loss'] = Variable<double>(estimatedLoss);
    map['row_version'] = Variable<String>(rowVersion);
    map['sync_status'] = Variable<String>(syncStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  DamageItemsCompanion toCompanion(bool nullToAbsent) {
    return DamageItemsCompanion(
      id: Value(id),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      damageReportId: Value(damageReportId),
      agriculturalSectorId: Value(agriculturalSectorId),
      subSectorId: Value(subSectorId),
      cropId: Value(cropId),
      damageTypeId: Value(damageTypeId),
      affectedArea: Value(affectedArea),
      damagePercentage: Value(damagePercentage),
      quantity: Value(quantity),
      estimatedLoss: Value(estimatedLoss),
      rowVersion: Value(rowVersion),
      syncStatus: Value(syncStatus),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory DamageItemLocal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DamageItemLocal(
      id: serializer.fromJson<String>(json['id']),
      serverId: serializer.fromJson<String?>(json['serverId']),
      damageReportId: serializer.fromJson<String>(json['damageReportId']),
      agriculturalSectorId: serializer.fromJson<String>(
        json['agriculturalSectorId'],
      ),
      subSectorId: serializer.fromJson<String>(json['subSectorId']),
      cropId: serializer.fromJson<String>(json['cropId']),
      damageTypeId: serializer.fromJson<String>(json['damageTypeId']),
      affectedArea: serializer.fromJson<double>(json['affectedArea']),
      damagePercentage: serializer.fromJson<double>(json['damagePercentage']),
      quantity: serializer.fromJson<double>(json['quantity']),
      estimatedLoss: serializer.fromJson<double>(json['estimatedLoss']),
      rowVersion: serializer.fromJson<String>(json['rowVersion']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'serverId': serializer.toJson<String?>(serverId),
      'damageReportId': serializer.toJson<String>(damageReportId),
      'agriculturalSectorId': serializer.toJson<String>(agriculturalSectorId),
      'subSectorId': serializer.toJson<String>(subSectorId),
      'cropId': serializer.toJson<String>(cropId),
      'damageTypeId': serializer.toJson<String>(damageTypeId),
      'affectedArea': serializer.toJson<double>(affectedArea),
      'damagePercentage': serializer.toJson<double>(damagePercentage),
      'quantity': serializer.toJson<double>(quantity),
      'estimatedLoss': serializer.toJson<double>(estimatedLoss),
      'rowVersion': serializer.toJson<String>(rowVersion),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  DamageItemLocal copyWith({
    String? id,
    Value<String?> serverId = const Value.absent(),
    String? damageReportId,
    String? agriculturalSectorId,
    String? subSectorId,
    String? cropId,
    String? damageTypeId,
    double? affectedArea,
    double? damagePercentage,
    double? quantity,
    double? estimatedLoss,
    String? rowVersion,
    String? syncStatus,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => DamageItemLocal(
    id: id ?? this.id,
    serverId: serverId.present ? serverId.value : this.serverId,
    damageReportId: damageReportId ?? this.damageReportId,
    agriculturalSectorId: agriculturalSectorId ?? this.agriculturalSectorId,
    subSectorId: subSectorId ?? this.subSectorId,
    cropId: cropId ?? this.cropId,
    damageTypeId: damageTypeId ?? this.damageTypeId,
    affectedArea: affectedArea ?? this.affectedArea,
    damagePercentage: damagePercentage ?? this.damagePercentage,
    quantity: quantity ?? this.quantity,
    estimatedLoss: estimatedLoss ?? this.estimatedLoss,
    rowVersion: rowVersion ?? this.rowVersion,
    syncStatus: syncStatus ?? this.syncStatus,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  DamageItemLocal copyWithCompanion(DamageItemsCompanion data) {
    return DamageItemLocal(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      damageReportId: data.damageReportId.present
          ? data.damageReportId.value
          : this.damageReportId,
      agriculturalSectorId: data.agriculturalSectorId.present
          ? data.agriculturalSectorId.value
          : this.agriculturalSectorId,
      subSectorId: data.subSectorId.present
          ? data.subSectorId.value
          : this.subSectorId,
      cropId: data.cropId.present ? data.cropId.value : this.cropId,
      damageTypeId: data.damageTypeId.present
          ? data.damageTypeId.value
          : this.damageTypeId,
      affectedArea: data.affectedArea.present
          ? data.affectedArea.value
          : this.affectedArea,
      damagePercentage: data.damagePercentage.present
          ? data.damagePercentage.value
          : this.damagePercentage,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      estimatedLoss: data.estimatedLoss.present
          ? data.estimatedLoss.value
          : this.estimatedLoss,
      rowVersion: data.rowVersion.present
          ? data.rowVersion.value
          : this.rowVersion,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DamageItemLocal(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('damageReportId: $damageReportId, ')
          ..write('agriculturalSectorId: $agriculturalSectorId, ')
          ..write('subSectorId: $subSectorId, ')
          ..write('cropId: $cropId, ')
          ..write('damageTypeId: $damageTypeId, ')
          ..write('affectedArea: $affectedArea, ')
          ..write('damagePercentage: $damagePercentage, ')
          ..write('quantity: $quantity, ')
          ..write('estimatedLoss: $estimatedLoss, ')
          ..write('rowVersion: $rowVersion, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    damageReportId,
    agriculturalSectorId,
    subSectorId,
    cropId,
    damageTypeId,
    affectedArea,
    damagePercentage,
    quantity,
    estimatedLoss,
    rowVersion,
    syncStatus,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DamageItemLocal &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.damageReportId == this.damageReportId &&
          other.agriculturalSectorId == this.agriculturalSectorId &&
          other.subSectorId == this.subSectorId &&
          other.cropId == this.cropId &&
          other.damageTypeId == this.damageTypeId &&
          other.affectedArea == this.affectedArea &&
          other.damagePercentage == this.damagePercentage &&
          other.quantity == this.quantity &&
          other.estimatedLoss == this.estimatedLoss &&
          other.rowVersion == this.rowVersion &&
          other.syncStatus == this.syncStatus &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DamageItemsCompanion extends UpdateCompanion<DamageItemLocal> {
  final Value<String> id;
  final Value<String?> serverId;
  final Value<String> damageReportId;
  final Value<String> agriculturalSectorId;
  final Value<String> subSectorId;
  final Value<String> cropId;
  final Value<String> damageTypeId;
  final Value<double> affectedArea;
  final Value<double> damagePercentage;
  final Value<double> quantity;
  final Value<double> estimatedLoss;
  final Value<String> rowVersion;
  final Value<String> syncStatus;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const DamageItemsCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.damageReportId = const Value.absent(),
    this.agriculturalSectorId = const Value.absent(),
    this.subSectorId = const Value.absent(),
    this.cropId = const Value.absent(),
    this.damageTypeId = const Value.absent(),
    this.affectedArea = const Value.absent(),
    this.damagePercentage = const Value.absent(),
    this.quantity = const Value.absent(),
    this.estimatedLoss = const Value.absent(),
    this.rowVersion = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DamageItemsCompanion.insert({
    required String id,
    this.serverId = const Value.absent(),
    required String damageReportId,
    required String agriculturalSectorId,
    required String subSectorId,
    required String cropId,
    required String damageTypeId,
    required double affectedArea,
    required double damagePercentage,
    required double quantity,
    required double estimatedLoss,
    this.rowVersion = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       damageReportId = Value(damageReportId),
       agriculturalSectorId = Value(agriculturalSectorId),
       subSectorId = Value(subSectorId),
       cropId = Value(cropId),
       damageTypeId = Value(damageTypeId),
       affectedArea = Value(affectedArea),
       damagePercentage = Value(damagePercentage),
       quantity = Value(quantity),
       estimatedLoss = Value(estimatedLoss);
  static Insertable<DamageItemLocal> custom({
    Expression<String>? id,
    Expression<String>? serverId,
    Expression<String>? damageReportId,
    Expression<String>? agriculturalSectorId,
    Expression<String>? subSectorId,
    Expression<String>? cropId,
    Expression<String>? damageTypeId,
    Expression<double>? affectedArea,
    Expression<double>? damagePercentage,
    Expression<double>? quantity,
    Expression<double>? estimatedLoss,
    Expression<String>? rowVersion,
    Expression<String>? syncStatus,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (damageReportId != null) 'damage_report_id': damageReportId,
      if (agriculturalSectorId != null)
        'agricultural_sector_id': agriculturalSectorId,
      if (subSectorId != null) 'sub_sector_id': subSectorId,
      if (cropId != null) 'crop_id': cropId,
      if (damageTypeId != null) 'damage_type_id': damageTypeId,
      if (affectedArea != null) 'affected_area': affectedArea,
      if (damagePercentage != null) 'damage_percentage': damagePercentage,
      if (quantity != null) 'quantity': quantity,
      if (estimatedLoss != null) 'estimated_loss': estimatedLoss,
      if (rowVersion != null) 'row_version': rowVersion,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DamageItemsCompanion copyWith({
    Value<String>? id,
    Value<String?>? serverId,
    Value<String>? damageReportId,
    Value<String>? agriculturalSectorId,
    Value<String>? subSectorId,
    Value<String>? cropId,
    Value<String>? damageTypeId,
    Value<double>? affectedArea,
    Value<double>? damagePercentage,
    Value<double>? quantity,
    Value<double>? estimatedLoss,
    Value<String>? rowVersion,
    Value<String>? syncStatus,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return DamageItemsCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      damageReportId: damageReportId ?? this.damageReportId,
      agriculturalSectorId: agriculturalSectorId ?? this.agriculturalSectorId,
      subSectorId: subSectorId ?? this.subSectorId,
      cropId: cropId ?? this.cropId,
      damageTypeId: damageTypeId ?? this.damageTypeId,
      affectedArea: affectedArea ?? this.affectedArea,
      damagePercentage: damagePercentage ?? this.damagePercentage,
      quantity: quantity ?? this.quantity,
      estimatedLoss: estimatedLoss ?? this.estimatedLoss,
      rowVersion: rowVersion ?? this.rowVersion,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (damageReportId.present) {
      map['damage_report_id'] = Variable<String>(damageReportId.value);
    }
    if (agriculturalSectorId.present) {
      map['agricultural_sector_id'] = Variable<String>(
        agriculturalSectorId.value,
      );
    }
    if (subSectorId.present) {
      map['sub_sector_id'] = Variable<String>(subSectorId.value);
    }
    if (cropId.present) {
      map['crop_id'] = Variable<String>(cropId.value);
    }
    if (damageTypeId.present) {
      map['damage_type_id'] = Variable<String>(damageTypeId.value);
    }
    if (affectedArea.present) {
      map['affected_area'] = Variable<double>(affectedArea.value);
    }
    if (damagePercentage.present) {
      map['damage_percentage'] = Variable<double>(damagePercentage.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (estimatedLoss.present) {
      map['estimated_loss'] = Variable<double>(estimatedLoss.value);
    }
    if (rowVersion.present) {
      map['row_version'] = Variable<String>(rowVersion.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DamageItemsCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('damageReportId: $damageReportId, ')
          ..write('agriculturalSectorId: $agriculturalSectorId, ')
          ..write('subSectorId: $subSectorId, ')
          ..write('cropId: $cropId, ')
          ..write('damageTypeId: $damageTypeId, ')
          ..write('affectedArea: $affectedArea, ')
          ..write('damagePercentage: $damagePercentage, ')
          ..write('quantity: $quantity, ')
          ..write('estimatedLoss: $estimatedLoss, ')
          ..write('rowVersion: $rowVersion, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DamageReportAttachmentsTable extends DamageReportAttachments
    with TableInfo<$DamageReportAttachmentsTable, DamageReportAttachmentLocal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DamageReportAttachmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serverIdMeta = const VerificationMeta(
    'serverId',
  );
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
    'server_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _damageReportIdMeta = const VerificationMeta(
    'damageReportId',
  );
  @override
  late final GeneratedColumn<String> damageReportId = GeneratedColumn<String>(
    'damage_report_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remotePathMeta = const VerificationMeta(
    'remotePath',
  );
  @override
  late final GeneratedColumn<String> remotePath = GeneratedColumn<String>(
    'remote_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _uploadStatusMeta = const VerificationMeta(
    'uploadStatus',
  );
  @override
  late final GeneratedColumn<String> uploadStatus = GeneratedColumn<String>(
    'upload_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverId,
    damageReportId,
    localPath,
    remotePath,
    uploadStatus,
    syncStatus,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'damage_report_attachments';
  @override
  VerificationContext validateIntegrity(
    Insertable<DamageReportAttachmentLocal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(
        _serverIdMeta,
        serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta),
      );
    }
    if (data.containsKey('damage_report_id')) {
      context.handle(
        _damageReportIdMeta,
        damageReportId.isAcceptableOrUnknown(
          data['damage_report_id']!,
          _damageReportIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_damageReportIdMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('remote_path')) {
      context.handle(
        _remotePathMeta,
        remotePath.isAcceptableOrUnknown(data['remote_path']!, _remotePathMeta),
      );
    }
    if (data.containsKey('upload_status')) {
      context.handle(
        _uploadStatusMeta,
        uploadStatus.isAcceptableOrUnknown(
          data['upload_status']!,
          _uploadStatusMeta,
        ),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
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
  DamageReportAttachmentLocal map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DamageReportAttachmentLocal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      serverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_id'],
      ),
      damageReportId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}damage_report_id'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      )!,
      remotePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_path'],
      ),
      uploadStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}upload_status'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $DamageReportAttachmentsTable createAlias(String alias) {
    return $DamageReportAttachmentsTable(attachedDatabase, alias);
  }
}

class DamageReportAttachmentLocal extends DataClass
    implements Insertable<DamageReportAttachmentLocal> {
  final String id;
  final String? serverId;
  final String damageReportId;
  final String localPath;
  final String? remotePath;
  final String uploadStatus;
  final String syncStatus;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const DamageReportAttachmentLocal({
    required this.id,
    this.serverId,
    required this.damageReportId,
    required this.localPath,
    this.remotePath,
    required this.uploadStatus,
    required this.syncStatus,
    required this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    map['damage_report_id'] = Variable<String>(damageReportId);
    map['local_path'] = Variable<String>(localPath);
    if (!nullToAbsent || remotePath != null) {
      map['remote_path'] = Variable<String>(remotePath);
    }
    map['upload_status'] = Variable<String>(uploadStatus);
    map['sync_status'] = Variable<String>(syncStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  DamageReportAttachmentsCompanion toCompanion(bool nullToAbsent) {
    return DamageReportAttachmentsCompanion(
      id: Value(id),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      damageReportId: Value(damageReportId),
      localPath: Value(localPath),
      remotePath: remotePath == null && nullToAbsent
          ? const Value.absent()
          : Value(remotePath),
      uploadStatus: Value(uploadStatus),
      syncStatus: Value(syncStatus),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory DamageReportAttachmentLocal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DamageReportAttachmentLocal(
      id: serializer.fromJson<String>(json['id']),
      serverId: serializer.fromJson<String?>(json['serverId']),
      damageReportId: serializer.fromJson<String>(json['damageReportId']),
      localPath: serializer.fromJson<String>(json['localPath']),
      remotePath: serializer.fromJson<String?>(json['remotePath']),
      uploadStatus: serializer.fromJson<String>(json['uploadStatus']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'serverId': serializer.toJson<String?>(serverId),
      'damageReportId': serializer.toJson<String>(damageReportId),
      'localPath': serializer.toJson<String>(localPath),
      'remotePath': serializer.toJson<String?>(remotePath),
      'uploadStatus': serializer.toJson<String>(uploadStatus),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  DamageReportAttachmentLocal copyWith({
    String? id,
    Value<String?> serverId = const Value.absent(),
    String? damageReportId,
    String? localPath,
    Value<String?> remotePath = const Value.absent(),
    String? uploadStatus,
    String? syncStatus,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => DamageReportAttachmentLocal(
    id: id ?? this.id,
    serverId: serverId.present ? serverId.value : this.serverId,
    damageReportId: damageReportId ?? this.damageReportId,
    localPath: localPath ?? this.localPath,
    remotePath: remotePath.present ? remotePath.value : this.remotePath,
    uploadStatus: uploadStatus ?? this.uploadStatus,
    syncStatus: syncStatus ?? this.syncStatus,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  DamageReportAttachmentLocal copyWithCompanion(
    DamageReportAttachmentsCompanion data,
  ) {
    return DamageReportAttachmentLocal(
      id: data.id.present ? data.id.value : this.id,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      damageReportId: data.damageReportId.present
          ? data.damageReportId.value
          : this.damageReportId,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      remotePath: data.remotePath.present
          ? data.remotePath.value
          : this.remotePath,
      uploadStatus: data.uploadStatus.present
          ? data.uploadStatus.value
          : this.uploadStatus,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DamageReportAttachmentLocal(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('damageReportId: $damageReportId, ')
          ..write('localPath: $localPath, ')
          ..write('remotePath: $remotePath, ')
          ..write('uploadStatus: $uploadStatus, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    serverId,
    damageReportId,
    localPath,
    remotePath,
    uploadStatus,
    syncStatus,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DamageReportAttachmentLocal &&
          other.id == this.id &&
          other.serverId == this.serverId &&
          other.damageReportId == this.damageReportId &&
          other.localPath == this.localPath &&
          other.remotePath == this.remotePath &&
          other.uploadStatus == this.uploadStatus &&
          other.syncStatus == this.syncStatus &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DamageReportAttachmentsCompanion
    extends UpdateCompanion<DamageReportAttachmentLocal> {
  final Value<String> id;
  final Value<String?> serverId;
  final Value<String> damageReportId;
  final Value<String> localPath;
  final Value<String?> remotePath;
  final Value<String> uploadStatus;
  final Value<String> syncStatus;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const DamageReportAttachmentsCompanion({
    this.id = const Value.absent(),
    this.serverId = const Value.absent(),
    this.damageReportId = const Value.absent(),
    this.localPath = const Value.absent(),
    this.remotePath = const Value.absent(),
    this.uploadStatus = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DamageReportAttachmentsCompanion.insert({
    required String id,
    this.serverId = const Value.absent(),
    required String damageReportId,
    required String localPath,
    this.remotePath = const Value.absent(),
    this.uploadStatus = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       damageReportId = Value(damageReportId),
       localPath = Value(localPath);
  static Insertable<DamageReportAttachmentLocal> custom({
    Expression<String>? id,
    Expression<String>? serverId,
    Expression<String>? damageReportId,
    Expression<String>? localPath,
    Expression<String>? remotePath,
    Expression<String>? uploadStatus,
    Expression<String>? syncStatus,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverId != null) 'server_id': serverId,
      if (damageReportId != null) 'damage_report_id': damageReportId,
      if (localPath != null) 'local_path': localPath,
      if (remotePath != null) 'remote_path': remotePath,
      if (uploadStatus != null) 'upload_status': uploadStatus,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DamageReportAttachmentsCompanion copyWith({
    Value<String>? id,
    Value<String?>? serverId,
    Value<String>? damageReportId,
    Value<String>? localPath,
    Value<String?>? remotePath,
    Value<String>? uploadStatus,
    Value<String>? syncStatus,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<int>? rowid,
  }) {
    return DamageReportAttachmentsCompanion(
      id: id ?? this.id,
      serverId: serverId ?? this.serverId,
      damageReportId: damageReportId ?? this.damageReportId,
      localPath: localPath ?? this.localPath,
      remotePath: remotePath ?? this.remotePath,
      uploadStatus: uploadStatus ?? this.uploadStatus,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (damageReportId.present) {
      map['damage_report_id'] = Variable<String>(damageReportId.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (remotePath.present) {
      map['remote_path'] = Variable<String>(remotePath.value);
    }
    if (uploadStatus.present) {
      map['upload_status'] = Variable<String>(uploadStatus.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DamageReportAttachmentsCompanion(')
          ..write('id: $id, ')
          ..write('serverId: $serverId, ')
          ..write('damageReportId: $damageReportId, ')
          ..write('localPath: $localPath, ')
          ..write('remotePath: $remotePath, ')
          ..write('uploadStatus: $uploadStatus, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<String> localId = GeneratedColumn<String>(
    'local_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
    'data',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastAttemptAtMeta = const VerificationMeta(
    'lastAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>(
        'last_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    localId,
    entityType,
    operation,
    data,
    status,
    retryCount,
    lastError,
    lastAttemptAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
        _dataMeta,
        this.data.isAcceptableOrUnknown(data['data']!, _dataMeta),
      );
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
        _lastAttemptAtMeta,
        lastAttemptAt.isAcceptableOrUnknown(
          data['last_attempt_at']!,
          _lastAttemptAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      data: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}data'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      lastAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_attempt_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final String id;
  final String localId;
  final String entityType;
  final String operation;
  final String data;
  final String status;
  final int retryCount;
  final String? lastError;
  final DateTime? lastAttemptAt;
  final DateTime createdAt;
  const SyncQueueData({
    required this.id,
    required this.localId,
    required this.entityType,
    required this.operation,
    required this.data,
    required this.status,
    required this.retryCount,
    this.lastError,
    this.lastAttemptAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['local_id'] = Variable<String>(localId);
    map['entity_type'] = Variable<String>(entityType);
    map['operation'] = Variable<String>(operation);
    map['data'] = Variable<String>(data);
    map['status'] = Variable<String>(status);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      localId: Value(localId),
      entityType: Value(entityType),
      operation: Value(operation),
      data: Value(data),
      status: Value(status),
      retryCount: Value(retryCount),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
      createdAt: Value(createdAt),
    );
  }

  factory SyncQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<String>(json['id']),
      localId: serializer.fromJson<String>(json['localId']),
      entityType: serializer.fromJson<String>(json['entityType']),
      operation: serializer.fromJson<String>(json['operation']),
      data: serializer.fromJson<String>(json['data']),
      status: serializer.fromJson<String>(json['status']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'localId': serializer.toJson<String>(localId),
      'entityType': serializer.toJson<String>(entityType),
      'operation': serializer.toJson<String>(operation),
      'data': serializer.toJson<String>(data),
      'status': serializer.toJson<String>(status),
      'retryCount': serializer.toJson<int>(retryCount),
      'lastError': serializer.toJson<String?>(lastError),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SyncQueueData copyWith({
    String? id,
    String? localId,
    String? entityType,
    String? operation,
    String? data,
    String? status,
    int? retryCount,
    Value<String?> lastError = const Value.absent(),
    Value<DateTime?> lastAttemptAt = const Value.absent(),
    DateTime? createdAt,
  }) => SyncQueueData(
    id: id ?? this.id,
    localId: localId ?? this.localId,
    entityType: entityType ?? this.entityType,
    operation: operation ?? this.operation,
    data: data ?? this.data,
    status: status ?? this.status,
    retryCount: retryCount ?? this.retryCount,
    lastError: lastError.present ? lastError.value : this.lastError,
    lastAttemptAt: lastAttemptAt.present
        ? lastAttemptAt.value
        : this.lastAttemptAt,
    createdAt: createdAt ?? this.createdAt,
  );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      localId: data.localId.present ? data.localId.value : this.localId,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      operation: data.operation.present ? data.operation.value : this.operation,
      data: data.data.present ? data.data.value : this.data,
      status: data.status.present ? data.status.value : this.status,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('localId: $localId, ')
          ..write('entityType: $entityType, ')
          ..write('operation: $operation, ')
          ..write('data: $data, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    localId,
    entityType,
    operation,
    data,
    status,
    retryCount,
    lastError,
    lastAttemptAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.localId == this.localId &&
          other.entityType == this.entityType &&
          other.operation == this.operation &&
          other.data == this.data &&
          other.status == this.status &&
          other.retryCount == this.retryCount &&
          other.lastError == this.lastError &&
          other.lastAttemptAt == this.lastAttemptAt &&
          other.createdAt == this.createdAt);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<String> id;
  final Value<String> localId;
  final Value<String> entityType;
  final Value<String> operation;
  final Value<String> data;
  final Value<String> status;
  final Value<int> retryCount;
  final Value<String?> lastError;
  final Value<DateTime?> lastAttemptAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.localId = const Value.absent(),
    this.entityType = const Value.absent(),
    this.operation = const Value.absent(),
    this.data = const Value.absent(),
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    required String id,
    required String localId,
    required String entityType,
    required String operation,
    required String data,
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       localId = Value(localId),
       entityType = Value(entityType),
       operation = Value(operation),
       data = Value(data);
  static Insertable<SyncQueueData> custom({
    Expression<String>? id,
    Expression<String>? localId,
    Expression<String>? entityType,
    Expression<String>? operation,
    Expression<String>? data,
    Expression<String>? status,
    Expression<int>? retryCount,
    Expression<String>? lastError,
    Expression<DateTime>? lastAttemptAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (localId != null) 'local_id': localId,
      if (entityType != null) 'entity_type': entityType,
      if (operation != null) 'operation': operation,
      if (data != null) 'data': data,
      if (status != null) 'status': status,
      if (retryCount != null) 'retry_count': retryCount,
      if (lastError != null) 'last_error': lastError,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncQueueCompanion copyWith({
    Value<String>? id,
    Value<String>? localId,
    Value<String>? entityType,
    Value<String>? operation,
    Value<String>? data,
    Value<String>? status,
    Value<int>? retryCount,
    Value<String?>? lastError,
    Value<DateTime?>? lastAttemptAt,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      localId: localId ?? this.localId,
      entityType: entityType ?? this.entityType,
      operation: operation ?? this.operation,
      data: data ?? this.data,
      status: status ?? this.status,
      retryCount: retryCount ?? this.retryCount,
      lastError: lastError ?? this.lastError,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (localId.present) {
      map['local_id'] = Variable<String>(localId.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(data.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('localId: $localId, ')
          ..write('entityType: $entityType, ')
          ..write('operation: $operation, ')
          ..write('data: $data, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('lastAttemptAt: $lastAttemptAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FarmersTable farmers = $FarmersTable(this);
  late final $FarmsTable farms = $FarmsTable(this);
  late final $DamageReportsTable damageReports = $DamageReportsTable(this);
  late final $DamageItemsTable damageItems = $DamageItemsTable(this);
  late final $DamageReportAttachmentsTable damageReportAttachments =
      $DamageReportAttachmentsTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    farmers,
    farms,
    damageReports,
    damageItems,
    damageReportAttachments,
    syncQueue,
  ];
}

typedef $$FarmersTableCreateCompanionBuilder =
    FarmersCompanion Function({
      required String id,
      Value<String?> serverId,
      Value<int> idTypeId,
      Value<String> idNumber,
      Value<String> firstNameAr,
      Value<String> fatherNameAr,
      Value<String> grandfatherNameAr,
      Value<String> familyNameAr,
      Value<String> firstNameEn,
      Value<String> fatherNameEn,
      Value<String> grandfatherNameEn,
      Value<String> familyNameEn,
      Value<DateTime?> birthDate,
      Value<int> gender,
      Value<String> phoneNumber,
      Value<int> familySize,
      Value<String> governorateId,
      Value<String> localityId,
      Value<String> address,
      Value<String> name,
      Value<String> nationalId,
      Value<String> rowVersion,
      Value<String> syncStatus,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$FarmersTableUpdateCompanionBuilder =
    FarmersCompanion Function({
      Value<String> id,
      Value<String?> serverId,
      Value<int> idTypeId,
      Value<String> idNumber,
      Value<String> firstNameAr,
      Value<String> fatherNameAr,
      Value<String> grandfatherNameAr,
      Value<String> familyNameAr,
      Value<String> firstNameEn,
      Value<String> fatherNameEn,
      Value<String> grandfatherNameEn,
      Value<String> familyNameEn,
      Value<DateTime?> birthDate,
      Value<int> gender,
      Value<String> phoneNumber,
      Value<int> familySize,
      Value<String> governorateId,
      Value<String> localityId,
      Value<String> address,
      Value<String> name,
      Value<String> nationalId,
      Value<String> rowVersion,
      Value<String> syncStatus,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

class $$FarmersTableFilterComposer
    extends Composer<_$AppDatabase, $FarmersTable> {
  $$FarmersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idTypeId => $composableBuilder(
    column: $table.idTypeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get idNumber => $composableBuilder(
    column: $table.idNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstNameAr => $composableBuilder(
    column: $table.firstNameAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fatherNameAr => $composableBuilder(
    column: $table.fatherNameAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grandfatherNameAr => $composableBuilder(
    column: $table.grandfatherNameAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get familyNameAr => $composableBuilder(
    column: $table.familyNameAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstNameEn => $composableBuilder(
    column: $table.firstNameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fatherNameEn => $composableBuilder(
    column: $table.fatherNameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grandfatherNameEn => $composableBuilder(
    column: $table.grandfatherNameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get familyNameEn => $composableBuilder(
    column: $table.familyNameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get familySize => $composableBuilder(
    column: $table.familySize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get governorateId => $composableBuilder(
    column: $table.governorateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localityId => $composableBuilder(
    column: $table.localityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nationalId => $composableBuilder(
    column: $table.nationalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rowVersion => $composableBuilder(
    column: $table.rowVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FarmersTableOrderingComposer
    extends Composer<_$AppDatabase, $FarmersTable> {
  $$FarmersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idTypeId => $composableBuilder(
    column: $table.idTypeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get idNumber => $composableBuilder(
    column: $table.idNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstNameAr => $composableBuilder(
    column: $table.firstNameAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fatherNameAr => $composableBuilder(
    column: $table.fatherNameAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grandfatherNameAr => $composableBuilder(
    column: $table.grandfatherNameAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get familyNameAr => $composableBuilder(
    column: $table.familyNameAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstNameEn => $composableBuilder(
    column: $table.firstNameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fatherNameEn => $composableBuilder(
    column: $table.fatherNameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grandfatherNameEn => $composableBuilder(
    column: $table.grandfatherNameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get familyNameEn => $composableBuilder(
    column: $table.familyNameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get familySize => $composableBuilder(
    column: $table.familySize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get governorateId => $composableBuilder(
    column: $table.governorateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localityId => $composableBuilder(
    column: $table.localityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nationalId => $composableBuilder(
    column: $table.nationalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rowVersion => $composableBuilder(
    column: $table.rowVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FarmersTableAnnotationComposer
    extends Composer<_$AppDatabase, $FarmersTable> {
  $$FarmersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<int> get idTypeId =>
      $composableBuilder(column: $table.idTypeId, builder: (column) => column);

  GeneratedColumn<String> get idNumber =>
      $composableBuilder(column: $table.idNumber, builder: (column) => column);

  GeneratedColumn<String> get firstNameAr => $composableBuilder(
    column: $table.firstNameAr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fatherNameAr => $composableBuilder(
    column: $table.fatherNameAr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get grandfatherNameAr => $composableBuilder(
    column: $table.grandfatherNameAr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get familyNameAr => $composableBuilder(
    column: $table.familyNameAr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get firstNameEn => $composableBuilder(
    column: $table.firstNameEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fatherNameEn => $composableBuilder(
    column: $table.fatherNameEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get grandfatherNameEn => $composableBuilder(
    column: $table.grandfatherNameEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get familyNameEn => $composableBuilder(
    column: $table.familyNameEn,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<int> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<int> get familySize => $composableBuilder(
    column: $table.familySize,
    builder: (column) => column,
  );

  GeneratedColumn<String> get governorateId => $composableBuilder(
    column: $table.governorateId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localityId => $composableBuilder(
    column: $table.localityId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get nationalId => $composableBuilder(
    column: $table.nationalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rowVersion => $composableBuilder(
    column: $table.rowVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$FarmersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FarmersTable,
          FarmerLocal,
          $$FarmersTableFilterComposer,
          $$FarmersTableOrderingComposer,
          $$FarmersTableAnnotationComposer,
          $$FarmersTableCreateCompanionBuilder,
          $$FarmersTableUpdateCompanionBuilder,
          (
            FarmerLocal,
            BaseReferences<_$AppDatabase, $FarmersTable, FarmerLocal>,
          ),
          FarmerLocal,
          PrefetchHooks Function()
        > {
  $$FarmersTableTableManager(_$AppDatabase db, $FarmersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FarmersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FarmersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FarmersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<int> idTypeId = const Value.absent(),
                Value<String> idNumber = const Value.absent(),
                Value<String> firstNameAr = const Value.absent(),
                Value<String> fatherNameAr = const Value.absent(),
                Value<String> grandfatherNameAr = const Value.absent(),
                Value<String> familyNameAr = const Value.absent(),
                Value<String> firstNameEn = const Value.absent(),
                Value<String> fatherNameEn = const Value.absent(),
                Value<String> grandfatherNameEn = const Value.absent(),
                Value<String> familyNameEn = const Value.absent(),
                Value<DateTime?> birthDate = const Value.absent(),
                Value<int> gender = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<int> familySize = const Value.absent(),
                Value<String> governorateId = const Value.absent(),
                Value<String> localityId = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> nationalId = const Value.absent(),
                Value<String> rowVersion = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FarmersCompanion(
                id: id,
                serverId: serverId,
                idTypeId: idTypeId,
                idNumber: idNumber,
                firstNameAr: firstNameAr,
                fatherNameAr: fatherNameAr,
                grandfatherNameAr: grandfatherNameAr,
                familyNameAr: familyNameAr,
                firstNameEn: firstNameEn,
                fatherNameEn: fatherNameEn,
                grandfatherNameEn: grandfatherNameEn,
                familyNameEn: familyNameEn,
                birthDate: birthDate,
                gender: gender,
                phoneNumber: phoneNumber,
                familySize: familySize,
                governorateId: governorateId,
                localityId: localityId,
                address: address,
                name: name,
                nationalId: nationalId,
                rowVersion: rowVersion,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> serverId = const Value.absent(),
                Value<int> idTypeId = const Value.absent(),
                Value<String> idNumber = const Value.absent(),
                Value<String> firstNameAr = const Value.absent(),
                Value<String> fatherNameAr = const Value.absent(),
                Value<String> grandfatherNameAr = const Value.absent(),
                Value<String> familyNameAr = const Value.absent(),
                Value<String> firstNameEn = const Value.absent(),
                Value<String> fatherNameEn = const Value.absent(),
                Value<String> grandfatherNameEn = const Value.absent(),
                Value<String> familyNameEn = const Value.absent(),
                Value<DateTime?> birthDate = const Value.absent(),
                Value<int> gender = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<int> familySize = const Value.absent(),
                Value<String> governorateId = const Value.absent(),
                Value<String> localityId = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> nationalId = const Value.absent(),
                Value<String> rowVersion = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FarmersCompanion.insert(
                id: id,
                serverId: serverId,
                idTypeId: idTypeId,
                idNumber: idNumber,
                firstNameAr: firstNameAr,
                fatherNameAr: fatherNameAr,
                grandfatherNameAr: grandfatherNameAr,
                familyNameAr: familyNameAr,
                firstNameEn: firstNameEn,
                fatherNameEn: fatherNameEn,
                grandfatherNameEn: grandfatherNameEn,
                familyNameEn: familyNameEn,
                birthDate: birthDate,
                gender: gender,
                phoneNumber: phoneNumber,
                familySize: familySize,
                governorateId: governorateId,
                localityId: localityId,
                address: address,
                name: name,
                nationalId: nationalId,
                rowVersion: rowVersion,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FarmersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FarmersTable,
      FarmerLocal,
      $$FarmersTableFilterComposer,
      $$FarmersTableOrderingComposer,
      $$FarmersTableAnnotationComposer,
      $$FarmersTableCreateCompanionBuilder,
      $$FarmersTableUpdateCompanionBuilder,
      (FarmerLocal, BaseReferences<_$AppDatabase, $FarmersTable, FarmerLocal>),
      FarmerLocal,
      PrefetchHooks Function()
    >;
typedef $$FarmsTableCreateCompanionBuilder =
    FarmsCompanion Function({
      required String id,
      Value<String?> serverId,
      required String farmerId,
      required String name,
      required String governorateId,
      required String localityId,
      required double landArea,
      required String landAreaUnit,
      Value<double?> latitude,
      Value<double?> longitude,
      required String ownershipTypeId,
      Value<String> rowVersion,
      Value<String> syncStatus,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$FarmsTableUpdateCompanionBuilder =
    FarmsCompanion Function({
      Value<String> id,
      Value<String?> serverId,
      Value<String> farmerId,
      Value<String> name,
      Value<String> governorateId,
      Value<String> localityId,
      Value<double> landArea,
      Value<String> landAreaUnit,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String> ownershipTypeId,
      Value<String> rowVersion,
      Value<String> syncStatus,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

class $$FarmsTableFilterComposer extends Composer<_$AppDatabase, $FarmsTable> {
  $$FarmsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get farmerId => $composableBuilder(
    column: $table.farmerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get governorateId => $composableBuilder(
    column: $table.governorateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localityId => $composableBuilder(
    column: $table.localityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get landArea => $composableBuilder(
    column: $table.landArea,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get landAreaUnit => $composableBuilder(
    column: $table.landAreaUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownershipTypeId => $composableBuilder(
    column: $table.ownershipTypeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rowVersion => $composableBuilder(
    column: $table.rowVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FarmsTableOrderingComposer
    extends Composer<_$AppDatabase, $FarmsTable> {
  $$FarmsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get farmerId => $composableBuilder(
    column: $table.farmerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get governorateId => $composableBuilder(
    column: $table.governorateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localityId => $composableBuilder(
    column: $table.localityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get landArea => $composableBuilder(
    column: $table.landArea,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get landAreaUnit => $composableBuilder(
    column: $table.landAreaUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownershipTypeId => $composableBuilder(
    column: $table.ownershipTypeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rowVersion => $composableBuilder(
    column: $table.rowVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FarmsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FarmsTable> {
  $$FarmsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get farmerId =>
      $composableBuilder(column: $table.farmerId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get governorateId => $composableBuilder(
    column: $table.governorateId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localityId => $composableBuilder(
    column: $table.localityId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get landArea =>
      $composableBuilder(column: $table.landArea, builder: (column) => column);

  GeneratedColumn<String> get landAreaUnit => $composableBuilder(
    column: $table.landAreaUnit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get ownershipTypeId => $composableBuilder(
    column: $table.ownershipTypeId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rowVersion => $composableBuilder(
    column: $table.rowVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$FarmsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FarmsTable,
          FarmLocal,
          $$FarmsTableFilterComposer,
          $$FarmsTableOrderingComposer,
          $$FarmsTableAnnotationComposer,
          $$FarmsTableCreateCompanionBuilder,
          $$FarmsTableUpdateCompanionBuilder,
          (FarmLocal, BaseReferences<_$AppDatabase, $FarmsTable, FarmLocal>),
          FarmLocal,
          PrefetchHooks Function()
        > {
  $$FarmsTableTableManager(_$AppDatabase db, $FarmsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FarmsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FarmsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FarmsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<String> farmerId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> governorateId = const Value.absent(),
                Value<String> localityId = const Value.absent(),
                Value<double> landArea = const Value.absent(),
                Value<String> landAreaUnit = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String> ownershipTypeId = const Value.absent(),
                Value<String> rowVersion = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FarmsCompanion(
                id: id,
                serverId: serverId,
                farmerId: farmerId,
                name: name,
                governorateId: governorateId,
                localityId: localityId,
                landArea: landArea,
                landAreaUnit: landAreaUnit,
                latitude: latitude,
                longitude: longitude,
                ownershipTypeId: ownershipTypeId,
                rowVersion: rowVersion,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> serverId = const Value.absent(),
                required String farmerId,
                required String name,
                required String governorateId,
                required String localityId,
                required double landArea,
                required String landAreaUnit,
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                required String ownershipTypeId,
                Value<String> rowVersion = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FarmsCompanion.insert(
                id: id,
                serverId: serverId,
                farmerId: farmerId,
                name: name,
                governorateId: governorateId,
                localityId: localityId,
                landArea: landArea,
                landAreaUnit: landAreaUnit,
                latitude: latitude,
                longitude: longitude,
                ownershipTypeId: ownershipTypeId,
                rowVersion: rowVersion,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FarmsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FarmsTable,
      FarmLocal,
      $$FarmsTableFilterComposer,
      $$FarmsTableOrderingComposer,
      $$FarmsTableAnnotationComposer,
      $$FarmsTableCreateCompanionBuilder,
      $$FarmsTableUpdateCompanionBuilder,
      (FarmLocal, BaseReferences<_$AppDatabase, $FarmsTable, FarmLocal>),
      FarmLocal,
      PrefetchHooks Function()
    >;
typedef $$DamageReportsTableCreateCompanionBuilder =
    DamageReportsCompanion Function({
      required String id,
      Value<String?> serverId,
      required String farmId,
      required String farmerId,
      required DateTime damageDate,
      required DateTime documentationDate,
      required String governorateId,
      required String localityId,
      Value<double?> latitude,
      Value<double?> longitude,
      required String statusId,
      required String notes,
      Value<String> rowVersion,
      Value<String> syncStatus,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$DamageReportsTableUpdateCompanionBuilder =
    DamageReportsCompanion Function({
      Value<String> id,
      Value<String?> serverId,
      Value<String> farmId,
      Value<String> farmerId,
      Value<DateTime> damageDate,
      Value<DateTime> documentationDate,
      Value<String> governorateId,
      Value<String> localityId,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String> statusId,
      Value<String> notes,
      Value<String> rowVersion,
      Value<String> syncStatus,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

class $$DamageReportsTableFilterComposer
    extends Composer<_$AppDatabase, $DamageReportsTable> {
  $$DamageReportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get farmId => $composableBuilder(
    column: $table.farmId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get farmerId => $composableBuilder(
    column: $table.farmerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get damageDate => $composableBuilder(
    column: $table.damageDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get documentationDate => $composableBuilder(
    column: $table.documentationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get governorateId => $composableBuilder(
    column: $table.governorateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localityId => $composableBuilder(
    column: $table.localityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statusId => $composableBuilder(
    column: $table.statusId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rowVersion => $composableBuilder(
    column: $table.rowVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DamageReportsTableOrderingComposer
    extends Composer<_$AppDatabase, $DamageReportsTable> {
  $$DamageReportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get farmId => $composableBuilder(
    column: $table.farmId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get farmerId => $composableBuilder(
    column: $table.farmerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get damageDate => $composableBuilder(
    column: $table.damageDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get documentationDate => $composableBuilder(
    column: $table.documentationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get governorateId => $composableBuilder(
    column: $table.governorateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localityId => $composableBuilder(
    column: $table.localityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statusId => $composableBuilder(
    column: $table.statusId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rowVersion => $composableBuilder(
    column: $table.rowVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DamageReportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DamageReportsTable> {
  $$DamageReportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get farmId =>
      $composableBuilder(column: $table.farmId, builder: (column) => column);

  GeneratedColumn<String> get farmerId =>
      $composableBuilder(column: $table.farmerId, builder: (column) => column);

  GeneratedColumn<DateTime> get damageDate => $composableBuilder(
    column: $table.damageDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get documentationDate => $composableBuilder(
    column: $table.documentationDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get governorateId => $composableBuilder(
    column: $table.governorateId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localityId => $composableBuilder(
    column: $table.localityId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get statusId =>
      $composableBuilder(column: $table.statusId, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get rowVersion => $composableBuilder(
    column: $table.rowVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DamageReportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DamageReportsTable,
          DamageReportLocal,
          $$DamageReportsTableFilterComposer,
          $$DamageReportsTableOrderingComposer,
          $$DamageReportsTableAnnotationComposer,
          $$DamageReportsTableCreateCompanionBuilder,
          $$DamageReportsTableUpdateCompanionBuilder,
          (
            DamageReportLocal,
            BaseReferences<
              _$AppDatabase,
              $DamageReportsTable,
              DamageReportLocal
            >,
          ),
          DamageReportLocal,
          PrefetchHooks Function()
        > {
  $$DamageReportsTableTableManager(_$AppDatabase db, $DamageReportsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DamageReportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DamageReportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DamageReportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<String> farmId = const Value.absent(),
                Value<String> farmerId = const Value.absent(),
                Value<DateTime> damageDate = const Value.absent(),
                Value<DateTime> documentationDate = const Value.absent(),
                Value<String> governorateId = const Value.absent(),
                Value<String> localityId = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String> statusId = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<String> rowVersion = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DamageReportsCompanion(
                id: id,
                serverId: serverId,
                farmId: farmId,
                farmerId: farmerId,
                damageDate: damageDate,
                documentationDate: documentationDate,
                governorateId: governorateId,
                localityId: localityId,
                latitude: latitude,
                longitude: longitude,
                statusId: statusId,
                notes: notes,
                rowVersion: rowVersion,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> serverId = const Value.absent(),
                required String farmId,
                required String farmerId,
                required DateTime damageDate,
                required DateTime documentationDate,
                required String governorateId,
                required String localityId,
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                required String statusId,
                required String notes,
                Value<String> rowVersion = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DamageReportsCompanion.insert(
                id: id,
                serverId: serverId,
                farmId: farmId,
                farmerId: farmerId,
                damageDate: damageDate,
                documentationDate: documentationDate,
                governorateId: governorateId,
                localityId: localityId,
                latitude: latitude,
                longitude: longitude,
                statusId: statusId,
                notes: notes,
                rowVersion: rowVersion,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DamageReportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DamageReportsTable,
      DamageReportLocal,
      $$DamageReportsTableFilterComposer,
      $$DamageReportsTableOrderingComposer,
      $$DamageReportsTableAnnotationComposer,
      $$DamageReportsTableCreateCompanionBuilder,
      $$DamageReportsTableUpdateCompanionBuilder,
      (
        DamageReportLocal,
        BaseReferences<_$AppDatabase, $DamageReportsTable, DamageReportLocal>,
      ),
      DamageReportLocal,
      PrefetchHooks Function()
    >;
typedef $$DamageItemsTableCreateCompanionBuilder =
    DamageItemsCompanion Function({
      required String id,
      Value<String?> serverId,
      required String damageReportId,
      required String agriculturalSectorId,
      required String subSectorId,
      required String cropId,
      required String damageTypeId,
      required double affectedArea,
      required double damagePercentage,
      required double quantity,
      required double estimatedLoss,
      Value<String> rowVersion,
      Value<String> syncStatus,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$DamageItemsTableUpdateCompanionBuilder =
    DamageItemsCompanion Function({
      Value<String> id,
      Value<String?> serverId,
      Value<String> damageReportId,
      Value<String> agriculturalSectorId,
      Value<String> subSectorId,
      Value<String> cropId,
      Value<String> damageTypeId,
      Value<double> affectedArea,
      Value<double> damagePercentage,
      Value<double> quantity,
      Value<double> estimatedLoss,
      Value<String> rowVersion,
      Value<String> syncStatus,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

class $$DamageItemsTableFilterComposer
    extends Composer<_$AppDatabase, $DamageItemsTable> {
  $$DamageItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get damageReportId => $composableBuilder(
    column: $table.damageReportId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get agriculturalSectorId => $composableBuilder(
    column: $table.agriculturalSectorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subSectorId => $composableBuilder(
    column: $table.subSectorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cropId => $composableBuilder(
    column: $table.cropId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get damageTypeId => $composableBuilder(
    column: $table.damageTypeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get affectedArea => $composableBuilder(
    column: $table.affectedArea,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get damagePercentage => $composableBuilder(
    column: $table.damagePercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get estimatedLoss => $composableBuilder(
    column: $table.estimatedLoss,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rowVersion => $composableBuilder(
    column: $table.rowVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DamageItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $DamageItemsTable> {
  $$DamageItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get damageReportId => $composableBuilder(
    column: $table.damageReportId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get agriculturalSectorId => $composableBuilder(
    column: $table.agriculturalSectorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subSectorId => $composableBuilder(
    column: $table.subSectorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cropId => $composableBuilder(
    column: $table.cropId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get damageTypeId => $composableBuilder(
    column: $table.damageTypeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get affectedArea => $composableBuilder(
    column: $table.affectedArea,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get damagePercentage => $composableBuilder(
    column: $table.damagePercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get estimatedLoss => $composableBuilder(
    column: $table.estimatedLoss,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rowVersion => $composableBuilder(
    column: $table.rowVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DamageItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DamageItemsTable> {
  $$DamageItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get damageReportId => $composableBuilder(
    column: $table.damageReportId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get agriculturalSectorId => $composableBuilder(
    column: $table.agriculturalSectorId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get subSectorId => $composableBuilder(
    column: $table.subSectorId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cropId =>
      $composableBuilder(column: $table.cropId, builder: (column) => column);

  GeneratedColumn<String> get damageTypeId => $composableBuilder(
    column: $table.damageTypeId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get affectedArea => $composableBuilder(
    column: $table.affectedArea,
    builder: (column) => column,
  );

  GeneratedColumn<double> get damagePercentage => $composableBuilder(
    column: $table.damagePercentage,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get estimatedLoss => $composableBuilder(
    column: $table.estimatedLoss,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rowVersion => $composableBuilder(
    column: $table.rowVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DamageItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DamageItemsTable,
          DamageItemLocal,
          $$DamageItemsTableFilterComposer,
          $$DamageItemsTableOrderingComposer,
          $$DamageItemsTableAnnotationComposer,
          $$DamageItemsTableCreateCompanionBuilder,
          $$DamageItemsTableUpdateCompanionBuilder,
          (
            DamageItemLocal,
            BaseReferences<_$AppDatabase, $DamageItemsTable, DamageItemLocal>,
          ),
          DamageItemLocal,
          PrefetchHooks Function()
        > {
  $$DamageItemsTableTableManager(_$AppDatabase db, $DamageItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DamageItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DamageItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DamageItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<String> damageReportId = const Value.absent(),
                Value<String> agriculturalSectorId = const Value.absent(),
                Value<String> subSectorId = const Value.absent(),
                Value<String> cropId = const Value.absent(),
                Value<String> damageTypeId = const Value.absent(),
                Value<double> affectedArea = const Value.absent(),
                Value<double> damagePercentage = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<double> estimatedLoss = const Value.absent(),
                Value<String> rowVersion = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DamageItemsCompanion(
                id: id,
                serverId: serverId,
                damageReportId: damageReportId,
                agriculturalSectorId: agriculturalSectorId,
                subSectorId: subSectorId,
                cropId: cropId,
                damageTypeId: damageTypeId,
                affectedArea: affectedArea,
                damagePercentage: damagePercentage,
                quantity: quantity,
                estimatedLoss: estimatedLoss,
                rowVersion: rowVersion,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> serverId = const Value.absent(),
                required String damageReportId,
                required String agriculturalSectorId,
                required String subSectorId,
                required String cropId,
                required String damageTypeId,
                required double affectedArea,
                required double damagePercentage,
                required double quantity,
                required double estimatedLoss,
                Value<String> rowVersion = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DamageItemsCompanion.insert(
                id: id,
                serverId: serverId,
                damageReportId: damageReportId,
                agriculturalSectorId: agriculturalSectorId,
                subSectorId: subSectorId,
                cropId: cropId,
                damageTypeId: damageTypeId,
                affectedArea: affectedArea,
                damagePercentage: damagePercentage,
                quantity: quantity,
                estimatedLoss: estimatedLoss,
                rowVersion: rowVersion,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DamageItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DamageItemsTable,
      DamageItemLocal,
      $$DamageItemsTableFilterComposer,
      $$DamageItemsTableOrderingComposer,
      $$DamageItemsTableAnnotationComposer,
      $$DamageItemsTableCreateCompanionBuilder,
      $$DamageItemsTableUpdateCompanionBuilder,
      (
        DamageItemLocal,
        BaseReferences<_$AppDatabase, $DamageItemsTable, DamageItemLocal>,
      ),
      DamageItemLocal,
      PrefetchHooks Function()
    >;
typedef $$DamageReportAttachmentsTableCreateCompanionBuilder =
    DamageReportAttachmentsCompanion Function({
      required String id,
      Value<String?> serverId,
      required String damageReportId,
      required String localPath,
      Value<String?> remotePath,
      Value<String> uploadStatus,
      Value<String> syncStatus,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });
typedef $$DamageReportAttachmentsTableUpdateCompanionBuilder =
    DamageReportAttachmentsCompanion Function({
      Value<String> id,
      Value<String?> serverId,
      Value<String> damageReportId,
      Value<String> localPath,
      Value<String?> remotePath,
      Value<String> uploadStatus,
      Value<String> syncStatus,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<int> rowid,
    });

class $$DamageReportAttachmentsTableFilterComposer
    extends Composer<_$AppDatabase, $DamageReportAttachmentsTable> {
  $$DamageReportAttachmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get damageReportId => $composableBuilder(
    column: $table.damageReportId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remotePath => $composableBuilder(
    column: $table.remotePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uploadStatus => $composableBuilder(
    column: $table.uploadStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DamageReportAttachmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DamageReportAttachmentsTable> {
  $$DamageReportAttachmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serverId => $composableBuilder(
    column: $table.serverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get damageReportId => $composableBuilder(
    column: $table.damageReportId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remotePath => $composableBuilder(
    column: $table.remotePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uploadStatus => $composableBuilder(
    column: $table.uploadStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DamageReportAttachmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DamageReportAttachmentsTable> {
  $$DamageReportAttachmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get damageReportId => $composableBuilder(
    column: $table.damageReportId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get remotePath => $composableBuilder(
    column: $table.remotePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get uploadStatus => $composableBuilder(
    column: $table.uploadStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DamageReportAttachmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DamageReportAttachmentsTable,
          DamageReportAttachmentLocal,
          $$DamageReportAttachmentsTableFilterComposer,
          $$DamageReportAttachmentsTableOrderingComposer,
          $$DamageReportAttachmentsTableAnnotationComposer,
          $$DamageReportAttachmentsTableCreateCompanionBuilder,
          $$DamageReportAttachmentsTableUpdateCompanionBuilder,
          (
            DamageReportAttachmentLocal,
            BaseReferences<
              _$AppDatabase,
              $DamageReportAttachmentsTable,
              DamageReportAttachmentLocal
            >,
          ),
          DamageReportAttachmentLocal,
          PrefetchHooks Function()
        > {
  $$DamageReportAttachmentsTableTableManager(
    _$AppDatabase db,
    $DamageReportAttachmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DamageReportAttachmentsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$DamageReportAttachmentsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DamageReportAttachmentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> serverId = const Value.absent(),
                Value<String> damageReportId = const Value.absent(),
                Value<String> localPath = const Value.absent(),
                Value<String?> remotePath = const Value.absent(),
                Value<String> uploadStatus = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DamageReportAttachmentsCompanion(
                id: id,
                serverId: serverId,
                damageReportId: damageReportId,
                localPath: localPath,
                remotePath: remotePath,
                uploadStatus: uploadStatus,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> serverId = const Value.absent(),
                required String damageReportId,
                required String localPath,
                Value<String?> remotePath = const Value.absent(),
                Value<String> uploadStatus = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DamageReportAttachmentsCompanion.insert(
                id: id,
                serverId: serverId,
                damageReportId: damageReportId,
                localPath: localPath,
                remotePath: remotePath,
                uploadStatus: uploadStatus,
                syncStatus: syncStatus,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DamageReportAttachmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DamageReportAttachmentsTable,
      DamageReportAttachmentLocal,
      $$DamageReportAttachmentsTableFilterComposer,
      $$DamageReportAttachmentsTableOrderingComposer,
      $$DamageReportAttachmentsTableAnnotationComposer,
      $$DamageReportAttachmentsTableCreateCompanionBuilder,
      $$DamageReportAttachmentsTableUpdateCompanionBuilder,
      (
        DamageReportAttachmentLocal,
        BaseReferences<
          _$AppDatabase,
          $DamageReportAttachmentsTable,
          DamageReportAttachmentLocal
        >,
      ),
      DamageReportAttachmentLocal,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueTableCreateCompanionBuilder =
    SyncQueueCompanion Function({
      required String id,
      required String localId,
      required String entityType,
      required String operation,
      required String data,
      Value<String> status,
      Value<int> retryCount,
      Value<String?> lastError,
      Value<DateTime?> lastAttemptAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$SyncQueueTableUpdateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<String> id,
      Value<String> localId,
      Value<String> entityType,
      Value<String> operation,
      Value<String> data,
      Value<String> status,
      Value<int> retryCount,
      Value<String?> lastError,
      Value<DateTime?> lastAttemptAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$SyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SyncQueueTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueTable,
          SyncQueueData,
          $$SyncQueueTableFilterComposer,
          $$SyncQueueTableOrderingComposer,
          $$SyncQueueTableAnnotationComposer,
          $$SyncQueueTableCreateCompanionBuilder,
          $$SyncQueueTableUpdateCompanionBuilder,
          (
            SyncQueueData,
            BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
          ),
          SyncQueueData,
          PrefetchHooks Function()
        > {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> localId = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> data = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueCompanion(
                id: id,
                localId: localId,
                entityType: entityType,
                operation: operation,
                data: data,
                status: status,
                retryCount: retryCount,
                lastError: lastError,
                lastAttemptAt: lastAttemptAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String localId,
                required String entityType,
                required String operation,
                required String data,
                Value<String> status = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueCompanion.insert(
                id: id,
                localId: localId,
                entityType: entityType,
                operation: operation,
                data: data,
                status: status,
                retryCount: retryCount,
                lastError: lastError,
                lastAttemptAt: lastAttemptAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueTable,
      SyncQueueData,
      $$SyncQueueTableFilterComposer,
      $$SyncQueueTableOrderingComposer,
      $$SyncQueueTableAnnotationComposer,
      $$SyncQueueTableCreateCompanionBuilder,
      $$SyncQueueTableUpdateCompanionBuilder,
      (
        SyncQueueData,
        BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
      ),
      SyncQueueData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FarmersTableTableManager get farmers =>
      $$FarmersTableTableManager(_db, _db.farmers);
  $$FarmsTableTableManager get farms =>
      $$FarmsTableTableManager(_db, _db.farms);
  $$DamageReportsTableTableManager get damageReports =>
      $$DamageReportsTableTableManager(_db, _db.damageReports);
  $$DamageItemsTableTableManager get damageItems =>
      $$DamageItemsTableTableManager(_db, _db.damageItems);
  $$DamageReportAttachmentsTableTableManager get damageReportAttachments =>
      $$DamageReportAttachmentsTableTableManager(
        _db,
        _db.damageReportAttachments,
      );
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
}
