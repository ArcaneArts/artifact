# 1.3.8
* Added reflective import collection for field types, method return types, and method parameter types to improve multi-file generation reliability.
* Fixed converter import emission for fallback decode paths and map key types to avoid missing-type compile failures.
* Added alias-annotation diagnostics in the builder to warn when classes look artifact-annotated but do not resolve to `@Artifact`.

# 1.3.7
* Updated enum type descriptor generation to emit enum option providers (`$AT<Enum>.e(() => Enum.values)`).
* Raised minimum `artifact` dependency to `1.0.33`.

# 1.3.5
* Fixed no-artifact output generation so the emitted helpers always compile when zero artifact classes are discovered.
* Added explicit empty-state fallbacks for `$isArtifact`, `$constructArtifact`, `$artifactToMap`, and `$artifactFromMap`.

# 1.3.4
* Fixed export scanning to skip unreadable assets during generation (`step.canRead`) to avoid transient `AssetNotFoundException` failures for generated files like `lib/gen/crud.gen.dart` when multiple builders run together.

# 1.3.3
* Fixed nested annotation argument serialization inside collection/map annotation parameters (for example `@Property(validators: [EmailValidator(message: "...")])`).
* Improved annotation source parsing to recover arguments from both constructor-style and invocation-style AST nodes during reflection codegen.

# 1.3.2
* Fixed reflection annotation emission to preserve explicit constructor arguments (including inherited/super-forwarded values like validator messages).
* Improved annotation argument extraction with AST-driven source recovery and constant-field fallback for robust codegen across analyzer shapes.
* Added generator integration coverage for annotation argument serialization in generated reflection fields.

# 1.3.1
* Added full recursive type descriptors via `$AT<T>` for reflected classes, fields, and methods.
* Exposed descriptor access in reflection APIs (`ArtifactTypeMirror`, `ArtifactFieldInfo`/`ArtifactFieldMirror`, `ArtifactMethodInfo`/`ArtifactMethodMirror`).
* Added method descriptor metadata for return, ordered parameters, and named parameters.
* Fixed reflected nested generic nullability coverage with regression tests for nullable list/set/map element/value types.

# 1.3.0
* Fixed generated reflection field/method type emission to preserve nested nullability (e.g. `List<String?>`, `Map<String, Model?>`).
* Fixed copyWith generation for nested nullable generic collections/maps so parameter types and forwarded setters stay type-safe.
* Added regression coverage in generator/runtime tests for nullable generic reflection/copyWith output.

# 1.2.11
* Extracted component-oriented helper logic out of `ArtifactBuilder` into `component/component_helpers.dart`.
* Renamed `inatance.dart` to `instance.dart` and updated builder wiring.

# 1.2.10
* Improved copyWith generation for typed empty collection defaults (`const <T>[]` / `const <T>{}`) to avoid bad casts.
* Updated copyWith behavior/tests to cover append + remove collection operations more comprehensively.
* Added/expanded reflection component tests around typed class/field mapper flows.

# 1.2.9
* Aligned generated/runtime reflection flows with new Artifact reflection mapper APIs.
* Updated generator integration test runner to use resolved Dart executable with analytics suppression for stable automation.

# 1.2.8
* Removed the attachment codegen component; annotation metadata is now consumed through reflection APIs.
* Converted component interface usage to mixin-based outputs (`with $ArtifactBuilderOutput`) and shared component helpers.
* Added component-stage guard diagnostics so generation failures report class/parameter/stage context.

# 1.2.7
* Hardened reflector constant emission (null-safe annotation handling, better constructor argument reconstruction).
* Switched generated `$mirror` getter to use `ArtifactReflection.instanceOf`.
* Reworked schema generation for enums, lists/sets/maps, nested artifact schemas, required fields, and `@describe`.

# 1.2.6
* Added generator fixture/integration harness validating generated artifacts and exports end-to-end.
* Refactored builder/component orchestration for clearer per-stage generation behavior.
* Added support for Artifact `1.0.27+`.

# 1.2.5
* Even more fixes

# 1.2.4
* Fix field annotation missing issue 

# 1.2.3
* Support artifact 1.0.25+

# 1.2.2
* Fix reflection defs on operator methods (we skip them now)

# 1.2.1
* Fix naming for exception tag

# 1.2.0
* Support for Artifact 1.0.23
* BREAKING: Removes the toJson, toYaml, toXXX and the fromJson, fromYaml, fromXXX methods. Use .to.json, or .from.json("...") instead

# 1.1.7
* Support for Artifact 1.0.22

# 1.1.5
* Fix reflective imports

# 1.1.4
* Fixes
* Event code gen handling
* Fix enum processing in annotation reflection

# 1.1.3
* Fixes

# 1.1.2
* Requires artifact 1.0.18

# 1.1.1
* Reflection capabilities requires artifact 1.0.17

# 1.1.0
* Performance improvements, sources generate 50% faster now (sometimes 300% faster)
* Upgrade to the new analyzer, sourcegen system: 
  * build_runner 2.10.0
  * build: ">=4.0.0 <5.0.0"
  * source_gen: ">=4.0.0 <5.0.0"
  * analyzer: ">=8.0.0 <9.0.0"

# 1.0.22
* Fixes

# 1.0.21
* Fixes

# 1.0.20
* Support datetime in required params for newInstance

# 1.0.19
* Fixes

# 1.0.18
* Support for $isArtifact, $artifactToMap and $artifactFromMap<T>(data)

# 1.0.17
* Support for $[model].newInstance which handles all parameter modes

# 1.0.16
* Support for reflection
* Support for the ability to disable compression
* Fixed a bug causing `@rename` to not work with `fromMap` or `schema` calls

# 1.0.13
* Fix non-string map-key serialization

# 1.0.12
* Enable compression

# 1.0.11
* Fix list set conversion on toMap

# 1.0.10
* Schema generation additionalProperties

# 1.0.9
* Schema generation

# 1.0.8
* Formatting Fixes

# 1.0.7
* Fixed (Subclass(...) as Superclass).copyWith() is! Subclass type loss issue

# 1.0.6
* Fixed a type cast issue in dart compiler bug which caused dynamic down-casting when using copyWith on an object using List or Set AND it had a default value causing method extensions to break at runtime. 

# 1.0.5
* Fixes & Support for Artifact 1.0.11

# 1.0.4
* Fixes & Support for Artifact 1.0.10

# 1.0.3
* Fixes & Support for Artifact 1.0.9

# 1.0.2
* Fixes & Support for Artifact 1.0.8

# 1.0.1
* Support for artifact 1.0.7

# 1.0.0
* Initial Generator
 
