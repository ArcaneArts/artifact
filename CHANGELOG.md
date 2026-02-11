# 1.0.31
* Fixed YAML import normalization to recursively convert nested `YamlMap`/`YamlList` values into plain Dart maps/lists for `fromMap` compatibility.
* Added TOML null-safe round-tripping by encoding nulls through an internal sentinel and restoring them on decode.
* Expanded format coverage with end-to-end tests across JSON/YAML/TOML/TOON/PROPS/BSON, including nullable TOML/YAML scenarios.

# 1.0.30
* Added full recursive type descriptors via `$AT<T>` for reflected classes, fields, and methods.
* Exposed descriptor access in reflection APIs (`ArtifactTypeMirror`, `ArtifactFieldInfo`/`ArtifactFieldMirror`, `ArtifactMethodInfo`/`ArtifactMethodMirror`).
* Added method descriptor metadata for return, ordered parameters, and named parameters.
* Fixed reflected nested generic nullability coverage with regression tests for nullable list/set/map element/value types.

# 1.0.29
* Added typed reflection mapper helpers for runtime generic binding on `$AClass` and `$AFld`, plus mirror wrappers.
* Fixed list/set copyWith remove handling through runtime collection helpers.
* Expanded generated API test coverage and refreshed generated fixtures/docs.

# 1.0.28
* Unified reflection access around `ArtifactAccessor` and `ArtifactReflection` query APIs.
* Added richer runtime mirrors (`ArtifactTypeMirror`, field/method info wrappers) and dynamic field/method access helpers.
* Added nullable-type-aware reflection lookup and cross-registry mirror filtering helpers.

# 1.0.27
* Split non-codec runtime utilities into `runtime_util.dart` (`ArtifactDataUtil`, `ArtifactSecurityUtil`, `PropertiesConverter`) and exported them.
* Removed runtime event-manager/event-bus internals; `events.dart` now provides event annotations only.
* Removed generated attachment accessor APIs (`getAttachment`, `getAttachments`, `rootAttachments`) in favor of unified reflection annotation access.

# 1.0.26
* @internal and @external for auto exporting files

# 1.0.25
* Additional reflection apis with `<instance>.$mirror`

# 1.0.24
* Remove XML support

# 1.0.23
* Full TOON support
* Support for new export systems

# 1.0.22
* Added better codec supports

# 1.0.21
* Encryption Json Compress API

# 1.0.20
* Support to/fromToon 

# 1.0.19
* Event handling management

# 1.0.18
* Re add reflect flag

# 1.0.17
* Add .getValue and .setValue for dynamic field access on reflection
* Relfective access to methods, fields, constructors, annotations, class extends, mixins & interfaces
* Auto enable reflection

# 1.0.16
* Docs

# 1.0.15
* Lots more stuff

# 1.0.14
* Describe Checker

# 1.0.13
* Schema gen support

# 1.0.12
* Fix int to double decode issue

# 1.0.11
* Attachment api

# 1.0.10
* Fixes

# 1.0.9
* Fixes

# 1.0.8
* Fixes

# 1.0.7
* Support for renaming fields
* Default Value deduplication
* Even more compression

# 1.0.6
* Fixes

# 1.0.5
* Fix from map artifact self recurse bug

# 1.0.4
* Copywith Deltas
* Removed change functions

# 1.0.3
* Full Dynamic Support
* Compression Improvements

# 1.0.2
* Improved Compression on Types
* String Deduplication Compression
* Support for Enums
* Support for codecs

# 1.0.1
* Fixes and additions

# 1.0.0

* Initial Release
