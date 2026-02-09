# Artifact Manifest

This document is a source map for the `artifact` runtime and `artifact_gen` code generator. Use it to jump directly to the right file when debugging, extending, or reviewing behavior.

## 1. High-Level Layout

- Runtime package (public APIs used by generated code): `lib/`
- Code generator package (build_runner builder + emitters): `artifact_gen/lib/`
- Builder wiring for build_runner: `build.yaml`
- Usage/demo sample: `example/lib/example.dart`

## 2. End-to-End Flow

1. `build.yaml` registers the `artifact` builder and declares generated outputs:
   - `lib/gen/artifacts.gen.dart`
   - `lib/gen/exports.gen.dart`
2. `artifact_gen/lib/artifact_gen.dart` exposes the build factory (`artifactBuilderBuildRunner`).
3. `artifact_gen/lib/builder.dart` scans `lib/**.dart` for `@Artifact` classes, indexes classes/subclasses, then emits extension code per class.
4. `artifact_gen/lib/component/*.dart` files each generate one feature slice (`toMap`, `fromMap`, `copyWith`, reflection, etc).
5. Generated code calls runtime helpers from `lib/artifact.dart`, `lib/codec.dart`, `lib/reflect.dart`, and `lib/shrink.dart`.
6. At load time, generated code registers package-level accessors into `ArtifactAccessor` so global APIs (`$artifactToMap`, reflection, events) can work.

## 3. File Index

### Root and Build Wiring

- `build.yaml`
  - Declares builder import/factory and build extensions.
  - Enables source output + `source_gen:combining_builder`.
- `pubspec.yaml`
  - Runtime package metadata and dependencies.

### Runtime Package (`lib/`)

- `lib/artifact.dart`
  - Public exports for codec/events/reflection/shrink helpers.
  - Core annotations and markers:
    - `Artifact`, `ArtifactEncrypt`, `codec`, `describe`, `rename`, `attach`
    - `external` / `internal` for export filtering.
  - Global accessor registry via `ArtifactAccessor` for cross-package model utilities.
  - Generated API support types:
    - `ArtifactModelExporter` (`.to.json`, `.to.yaml`, etc)
    - `ArtifactModelImporter` (`$Type.from.json(...)`, etc)
    - Reflection model descriptors (`$AClass`, `$AFld`, `$AMth`, `MethodParameters`)
- `lib/codec.dart`
  - Conversion and format gateway (`ArtifactCodecUtil`).
  - Built-in codecs and codec registry (`$artifactCodecs`, `ArtifactCodec`).
  - Encryption/decryption map helpers (`q`, `s`) tied to `$artifactCipher`.
  - Format adapters:
    - JSON, YAML, TOML, TOON, properties, BSON.
  - Primitive/type parsing helpers and map-entry reconstruction helpers.
- `lib/reflect.dart`
  - Runtime mirror wrappers:
    - `ArtifactMirror`
    - `ArtifactFieldMirror`
    - `ArtifactMethodMirror`
  - Annotation lookup APIs for class/field/method reflection.
- `lib/events.dart`
  - Event bus built on generated reflection metadata.
  - Listener registration via `@EventHandler` annotations on reflected methods.
- `lib/shrink.dart`
  - Compact helper extensions used in generated code (`$m`, `$l`, `$s`, `$nn`, `$u`, etc).

### Generator Package (`artifact_gen/lib/`)

- `artifact_gen/lib/artifact_gen.dart`
  - Builder factory entrypoint for build_runner.
- `artifact_gen/lib/builder.dart`
  - Generator orchestration and output assembly.
  - Key responsibilities:
    - Reads project config from `pubspec.yaml` (`artifact:` block).
    - Scans libraries/classes and detects `@Artifact`.
    - Tracks subtype graph for polymorphic serialization.
    - Registers type defs and string/value dictionaries for compression mode.
    - Collects and registers custom codecs from class/field/method/constructor annotations.
    - Writes `artifacts.gen.dart` with imports, helpers, class extensions, global functions.
    - Writes `exports.gen.dart` based on `@external` / `@internal` and `artifact.export`.
  - Global generated utility functions come from here:
    - `$isArtifact`
    - `$constructArtifact<T>`
    - `$artifactToMap`
    - `$artifactFromMap<T>`
- `artifact_gen/lib/converter.dart`
  - Recursive type conversion planner for map encoding/decoding.
  - Handles artifact types, enums, lists, sets, maps, nullable types, and codec fallback.
- `artifact_gen/lib/util.dart`
  - Analyzer helpers:
    - Finds default constructor.
    - Filters constructor parameters to serializable ctor fields.

### Generator Components (`artifact_gen/lib/component/`)

- `to_map.dart` (`$ArtifactToMapComponent`)
  - Generates:
    - `to` exporter getter
    - `toMap()` implementation
  - Handles:
    - rename overrides
    - subclass marker injection (`_subclass_<Base>`)
    - encryption/compression wrapping via codec util
- `from_map.dart` (`$ArtifactFromMapComponent`)
  - Generates:
    - `from` importer getter
    - `fromMap()` implementation
  - Handles:
    - required/default parameter semantics
    - rename overrides
    - subclass dispatch from `_subclass_<Base>`
    - encrypted payload decode path
- `copy_with.dart` (`$ArtifactCopyWithComponent`)
  - Generates `copyWith(...)`.
  - Supports:
    - direct replacement
    - nullable delete flags
    - reset-to-default flags
    - numeric deltas (`deltaX`)
    - list/set append/remove operations
    - subclass forwarding when the base extension sees a subtype instance
- `inatance.dart` (`$ArtifactInstanceComponent`)
  - Generates `newInstance` factory for zero-argument construction defaults.
  - Used by global constructor helpers and reflection.
- `attach.dart` (`$ArtifactAttachComponent`)
  - Generates attachment lookup APIs:
    - `getAttachments<T, R>(...)`
    - `getAttachment<T, R>(...)`
    - `rootAttachments`
  - Resolves class/field `@attach(...)` constants into generated code.
- `reflector.dart` (`$ArtifactReflectorComponent`)
  - Enabled only when `@Artifact(reflection: true)`.
  - Generates class mirrors:
    - `$mirror`
    - `$annotations`
    - `$fields`
    - `$methods`
  - Converts analyzer constant values into emitted Dart literal code.
- `schema.dart` (`$ArtifactSchemaComponent`)
  - Enabled only when `@Artifact(generateSchema: true)`.
  - Generates static schema maps using ctor field types and optional `@describe`.

## 4. Generated Surface Per Model

Given:

```dart
@artifact
class MyModel {
  final int value;
  final double otherValue;
  const MyModel({this.value = 4, required this.otherValue});
}
```

The generated extension (shape) includes:

- `MyModel get _H`
- `ArtifactModelExporter get to` (`.json`, `.yaml`, `.toml`, `.toon`, `.props`, `.bson`)
- `Map<String, dynamic> toMap()`
- `static ArtifactModelImporter<MyModel> get from`
- `static MyModel fromMap(Map<String, dynamic>)`
- `MyModel copyWith(...)`
- `static MyModel get newInstance`
- optional reflection and schema members depending on annotation flags.

## 5. Feature -> Where To Change It

- Constructor-field selection logic:
  - `artifact_gen/lib/util.dart`
  - `artifact_gen/lib/builder.dart` (`generate(...)`)
- Key renaming (`@rename`):
  - `artifact_gen/lib/component/to_map.dart`
  - `artifact_gen/lib/component/from_map.dart`
  - `artifact_gen/lib/component/schema.dart`
- Encryption/retention (`@encrypt` / `@retain`):
  - Builder field selection: `artifact_gen/lib/builder.dart`
  - Runtime encode/decode: `lib/codec.dart` (`q`, `s`)
- Polymorphism and subclass markers:
  - subtype map assembly: `artifact_gen/lib/builder.dart`
  - emission/dispatch: `artifact_gen/lib/component/to_map.dart`, `artifact_gen/lib/component/from_map.dart`
- `copyWith` behavior:
  - `artifact_gen/lib/component/copy_with.dart`
  - collection helper semantics: `lib/shrink.dart`
- Runtime reflection data model:
  - generation: `artifact_gen/lib/component/reflector.dart`
  - access APIs: `lib/reflect.dart`, `lib/artifact.dart`
- Event system:
  - runtime dispatcher and registration: `lib/events.dart`
  - depends on generated reflection metadata
- Global export generation (`exports.gen.dart`):
  - `artifact_gen/lib/builder.dart` (`getExpString(...)`)
  - tag controls: `lib/artifact.dart` (`@external`, `@internal`)
- Type conversions and custom codecs:
  - generator planning: `artifact_gen/lib/converter.dart`
  - runtime codec registry/execution: `lib/codec.dart`

## 6. Notes and Gotchas

- Constructor parameters define serialization shape; getters/private fields are not serialized.
- Reflection and schema generation are opt-in via `@Artifact` flags.
- Encryption/compression requires `$artifactCipher` to be set at runtime.
- `artifact_gen/lib/component/inatance.dart` file name is intentionally/currently spelled `inatance.dart`.
- Export generation skips `part of` units and avoids re-exporting generated self files.
