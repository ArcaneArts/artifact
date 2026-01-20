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
 