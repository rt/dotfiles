# Maven

https://books.sonatype.com/mvnex-book/reference/index.html

Apache Maven is a software project management and comprehension tool. Based on
the concept of a project object model (POM), Maven can manage a project's
build, reporting and documentation from a central piece of information

```
<project xmlns = "http://maven.apache.org/POM/4.0.0"
   xmlns:xsi = "http://www.w3.org/2001/XMLSchema-instance"
   xsi:schemaLocation = "http://maven.apache.org/POM/4.0.0
   http://maven.apache.org/xsd/maven-4.0.0.xsd">
   <modelVersion>4.0.0</modelVersion>

   <groupId>com.companyname.project-group</groupId>
   <artifactId>project</artifactId>
   <version>1.0</version>
</project>
```

Run the following to display as result in console, after
inheritance, interpolation, and profiles are applied.  

``` 
mvn help:effective-pom 
```

## Goal

A goal represents a specific task which contributes to the building and
managing of a project. It may be *bound* to zero or more build phases. A goal not
bound to any build phase could be executed outside of the build lifecycle by
direct invocation.

You will usually have plugins that you can tap their goals and specify what
phase to execute them in.  (see pom.xml)

## Standard Lifecyles

Each lifecycle consists of phases.

When you execute a phase, maven performs all the phases up until and including that phase.

### clean

Maven clean goal (clean:clean) is bound to the clean phase in the clean
lifecycle. Its clean:cleangoal deletes the output of a build by deleting the
build directory. Thus, when mvn clean command executes, Maven deletes the build
directory.

- pre-clean
- clean
- post-clean

### default (build)

- validate :  

Validates whether project is correct and all necessary information is available
to complete the build process.

- initialize

Initializes build state, for example set properties.

- generate-sources

Generate any source code to be included in compilation phase.

- process-sources

Process the source code, for example, filter any value.

- generate-resources

Generate resources to be included in the package.

- process-resources

Copy and process the resources into the destination directory, ready for
packaging phase.

- compile

Compile the source code of the project.

- process-classes

Post-process the generated files from compilation, for example to do bytecode
enhancement/optimization on Java classes.

- generate-test-sources

Generate any test source code to be included in compilation phase.

- process-test-sources

Process the test source code, for example, filter any values.

- test-compile

Compile the test source code into the test destination directory.

- process-test-classes

Process the generated files from test code file compilation.

- test

Run tests using a suitable unit testing framework (Junit is one).

- prepare-package

Perform any operations necessary to prepare a package before the actual
packaging.

- package

Take the compiled code and package it in its distributable format, such as a
JAR, WAR, or EAR file.

- pre-integration-test

Perform actions required before integration tests are executed. For example,
setting up the required environment.

- integration-test

Process and deploy the package if necessary into an environment where
integration tests can be run.

- post-integration-test

Perform actions required after integration tests have been executed. For
example, cleaning up the environment.

- verify

Run any check-ups to verify the package is valid and meets quality criteria.

- install

Install the package into the local repository, which can be used as a
dependency in other projects locally.

- deploy

Copies the final package to the remote repository for sharing with other
developers and projects.

### site

Maven Site plugin is generally used to create fresh documentation to create
reports, deploy site, etc.

- pre-site
- site
- post-site
- site-deploy

*Phases*
 
Each lifecly


## Resources

https://maven.apache.org/
https://www.tutorialspoint.com/maven/index.htm

