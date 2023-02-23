// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'model/blog.dart';
import 'model/user.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 9105634663828243263),
      name: 'Blog',
      lastPropertyId: const IdUid(6, 7948047776063199672),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4363130398979636842),
            name: 'id',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 5916502683238656805),
            name: 'blogId',
            type: 9,
            flags: 2080,
            indexId: const IdUid(1, 3880146460523201159)),
        ModelProperty(
            id: const IdUid(3, 2023751129000081104),
            name: 'title',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 6243907382754511156),
            name: 'content',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 1441746342394973976),
            name: 'view',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 7948047776063199672),
            name: 'image',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[
        ModelBacklink(name: 'user', srcEntity: 'User', srcField: '')
      ]),
  ModelEntity(
      id: const IdUid(2, 5404242064788204015),
      name: 'User',
      lastPropertyId: const IdUid(5, 2298174321435901355),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 1493864074548348214),
            name: 'userId',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 1756462968822091885),
            name: 'usrId',
            type: 9,
            flags: 2080,
            indexId: const IdUid(2, 6874142888791140443)),
        ModelProperty(
            id: const IdUid(3, 2558170714004826875),
            name: 'username',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 737974796184652267),
            name: 'email',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 2298174321435901355),
            name: 'password',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(1, 120889184953418855),
            name: 'blog',
            targetId: const IdUid(1, 9105634663828243263))
      ],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(2, 5404242064788204015),
      lastIndexId: const IdUid(2, 6874142888791140443),
      lastRelationId: const IdUid(1, 120889184953418855),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Blog: EntityDefinition<Blog>(
        model: _entities[0],
        toOneRelations: (Blog object) => [],
        toManyRelations: (Blog object) =>
            {RelInfo<User>.toManyBacklink(1, object.id): object.user},
        getId: (Blog object) => object.id,
        setId: (Blog object, int id) {
          object.id = id;
        },
        objectToFB: (Blog object, fb.Builder fbb) {
          final blogIdOffset =
              object.blogId == null ? null : fbb.writeString(object.blogId!);
          final titleOffset =
              object.title == null ? null : fbb.writeString(object.title!);
          final contentOffset =
              object.content == null ? null : fbb.writeString(object.content!);
          final imageOffset =
              object.image == null ? null : fbb.writeString(object.image!);
          fbb.startTable(7);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, blogIdOffset);
          fbb.addOffset(2, titleOffset);
          fbb.addOffset(3, contentOffset);
          fbb.addInt64(4, object.view);
          fbb.addOffset(5, imageOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Blog(
              blogId: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              image: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 14),
              title: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              content: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10),
              view: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 12),
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));
          InternalToManyAccess.setRelInfo(object.user, store,
              RelInfo<User>.toManyBacklink(1, object.id), store.box<Blog>());
          return object;
        }),
    User: EntityDefinition<User>(
        model: _entities[1],
        toOneRelations: (User object) => [],
        toManyRelations: (User object) =>
            {RelInfo<User>.toMany(1, object.userId): object.blog},
        getId: (User object) => object.userId,
        setId: (User object, int id) {
          object.userId = id;
        },
        objectToFB: (User object, fb.Builder fbb) {
          final usrIdOffset =
              object.usrId == null ? null : fbb.writeString(object.usrId!);
          final usernameOffset = object.username == null
              ? null
              : fbb.writeString(object.username!);
          final emailOffset =
              object.email == null ? null : fbb.writeString(object.email!);
          final passwordOffset = object.password == null
              ? null
              : fbb.writeString(object.password!);
          fbb.startTable(6);
          fbb.addInt64(0, object.userId);
          fbb.addOffset(1, usrIdOffset);
          fbb.addOffset(2, usernameOffset);
          fbb.addOffset(3, emailOffset);
          fbb.addOffset(4, passwordOffset);
          fbb.finish(fbb.endTable());
          return object.userId;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = User(
              usrId: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              username: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              email: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10),
              password: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 12),
              userId:
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));
          InternalToManyAccess.setRelInfo(object.blog, store,
              RelInfo<User>.toMany(1, object.userId), store.box<User>());
          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Blog] entity fields to define ObjectBox queries.
class Blog_ {
  /// see [Blog.id]
  static final id = QueryIntegerProperty<Blog>(_entities[0].properties[0]);

  /// see [Blog.blogId]
  static final blogId = QueryStringProperty<Blog>(_entities[0].properties[1]);

  /// see [Blog.title]
  static final title = QueryStringProperty<Blog>(_entities[0].properties[2]);

  /// see [Blog.content]
  static final content = QueryStringProperty<Blog>(_entities[0].properties[3]);

  /// see [Blog.view]
  static final view = QueryIntegerProperty<Blog>(_entities[0].properties[4]);

  /// see [Blog.image]
  static final image = QueryStringProperty<Blog>(_entities[0].properties[5]);
}

/// [User] entity fields to define ObjectBox queries.
class User_ {
  /// see [User.userId]
  static final userId = QueryIntegerProperty<User>(_entities[1].properties[0]);

  /// see [User.usrId]
  static final usrId = QueryStringProperty<User>(_entities[1].properties[1]);

  /// see [User.username]
  static final username = QueryStringProperty<User>(_entities[1].properties[2]);

  /// see [User.email]
  static final email = QueryStringProperty<User>(_entities[1].properties[3]);

  /// see [User.password]
  static final password = QueryStringProperty<User>(_entities[1].properties[4]);

  /// see [User.blog]
  static final blog =
      QueryRelationToMany<User, Blog>(_entities[1].relations[0]);
}
