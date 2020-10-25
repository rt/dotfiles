# Gradle


https://www.tutorialspoint.com/gradle/index.htm
https://guides.gradle.org/creating-new-gradle-builds/


```
brew install gradle
```

```
gradle init
```

Produces the following

├── build.gradle: Project configuration script for configuring tasks in the current project
├── gradle
│   └── wrapper
│       ├── gradle-wrapper.jar
│       └── gradle-wrapper.properties: 	Gradle Wrapper configuration properties
├── gradlew
├── gradlew.bat
└── settings.gradle: Settings configuration script for configuring which Projects participate in the build


## Create a task

Gradle provides APIs for creating and configuring tasks through a Groovy or
Kotlin-based DSL. A Project includes a collection of Tasks, each of which
performs some basic operation.

```
task copy(type: Copy, group: "Custom", description: "Copies sources to the dest directory") {
    from "src"
    into "dest"
}
```

## Apply a plugin

For example, `base` plugin allows you to zip with core type `Zip`
```
plugins {
    id "base"
}

```

And then you can
```
task zip(type: Zip, group: "Archive", description: "Archives sources in a zip file") {
    from "src"
}
```



## Modules

I made a directory called my and initialized with the following

```
gradle init --type my-library
```

```
./gradlew build create mode 100644 patterns/behavioral/strategy/gradle/wrapper/gradle-wrapper.
```

```
./gradlew test
```



Similar to mvn -DskipTests

```
gradle build -x test -x integTest
```
