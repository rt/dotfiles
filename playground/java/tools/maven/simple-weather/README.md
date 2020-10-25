# simple-lib


## Quick Starts

```
mvn archetype:generate -DgroupId=org.sonatype.mavenbook.custom \
      -DartifactId=simple-weather \
      -Dversion=1.0
```


### Add Build Section

Currently, this is not needed (generated)

```
   <build>
        <plugins>
            <plugin>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.3</version>
                <configuration>
                    <source>1.5</source>
                    <target>1.5</target>
                </configuration>
            </plugin>
        </plugins>
    </build>
```


### Add `organization`, `licenses`, `developers`

Skip this

### Add Dependencies 


You can find public libs in http://mvnrepository.com/ or http://repository.sonatype.org


To parse the XML response from Yahoo, we’re going to be using Dom4J and Jaxen,
to format the output of this command-line program we are going to be using
Velocity, and we will also need to add a dependency for Log4J which we will be
using for logging

```
    <dependencies>
        <dependency>
            <groupId>log4j</groupId>
            <artifactId>log4j</artifactId>
            <version>1.2.14</version>
        </dependency>
        <dependency>
            <groupId>dom4j</groupId>
            <artifactId>dom4j</artifactId>
            <version>1.6.1</version>
        </dependency>
        <dependency>
            <groupId>jaxen</groupId>
            <artifactId>jaxen</artifactId>
            <version>1.1.1</version>
        </dependency>
        <dependency>
            <groupId>velocity</groupId>
            <artifactId>velocity</artifactId>
            <version>1.5</version>
        </dependency>
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>3.8.1</version>
            <scope>test</scope>
        </dependency>
    </dependencies>
```


### The Code

This is good to just show the test and jar created with the generated `App.java` and `AppTest.java`.  

Put weather code in

### Resources

This example uses Velocity to render a template and we also set log4j properties.

```
cd src/main
mkdir resources
```

### Build and Run

```
mvn install
mvn exec:java -Dexec.mainClass=org.sonatype.mavenbook.weather.Main -Dexec.args="96816"
```
You can see the details of this exec plugin

```
 mvn help:describe -Dplugin=exec -Dfull
```

Although the Exec plugin is useful, you shouldn’t rely on it as a way to
execute your application outside of running tests during development

Notice that no “build process” was involved. We didn’t need to define how or
where the Java compiler compiles our source to bytecode, and we didn’t need to
instruct the build system how to locate the bytecode when we executed the
example application

The Exec plugin makes it possible for us to run the Simple Weather program
without having to load the appropriate dependencies into the classpath. In any
other build system, we would have to copy all of the program dependencies into
some sort of lib/ directory containing a collection of JAR files. Then, we
would have to write a simple script that includes our program’s bytecode and
all of our dependencies in a classpath. Only then could we run java
org.sonatype.mavenbook.weather.Main. The Exec plugin leverages the fact that
Maven already knows how to create and manage your classpath and dependencies.

This is convenient, but it’s also nice to know exactly what is being included
in your project’s classpath. Although the project depends on a few libraries
such as Dom4J, Log4J, Jaxen, and Velocity, it also relies on a few transitive
dependencies. If you need to find out what is on the classpath, you can use the
Maven Dependency plugin to print out a list of dependencies.

```
mvn dependency:resolve
```

```
mvn dependency:tree
```

### Writing Unit Tests

`src/test/java`


### Adding Test-scoped Dependencies

In WeatherFormatterTest, we used a utility from Apache Commons IO—the IOUtils
class. IOUtils provides a number of helpful static methods that take most of
the work out of input/output operations. In this particular unit test, we used
IOUtils.toString() to copy the format-expected.dat classpath resource to a
String. We could have done this without using Commons IO, but it would have
required an extra six or seven lines of code to deal with the various
InputStreamReader and StringWriter objects. The main reason we used Commons IO
was to give us an excuse to add a test-scoped dependency on Commons IO.

A test-scoped dependency is a dependency that is available on the classpath
only during test compilation and test execution. If your project has war or ear
packaging, a test-scoped dependency would not be included in the project’s
output archive. To add a test-scoped dependency, add the dependency element to
your project’s dependencies section, as shown in the following example:

```
<project>
    ...
    <dependencies>
        ...
        <dependency>
            <groupId>org.apache.commons</groupId>
            <artifactId>commons-io</artifactId>
            <version>1.3.2</version>
            <scope>test</scope>
        </dependency>
        ...
    </dependencies>
</project>
```


### Adding Unit Test Resources

### Executing Unit Tests

```
mvn test
```

Executing mvn test from the command line caused Maven to execute all lifecycle
phases up to the test phase. The Maven Surefire plugin has a test goal which is
bound to the test phase. This test goal executes all of the unit tests this
project can find under src/test/java with filenames matching \*\*/Test\*.java,
\*\*/\*Test.java and \*\*/\*TestCase.java. In the case of this project, you can see
that the Surefire plugin’s test goal executed WeatherFormatterTest and
YahooParserTest. When the Maven Surefire plugin runs the JUnit tests, it also
generates XML and text reports in the ${basedir}/target/surefire-reports
directory. If your tests are failing, you should look in this directory for
details like stack traces and error messages generated by your unit tests.


You can ignore failures (and build) or skip tests in either the pom.xml maven-surefire-plugin configuration or at the cli

```
mvn test -Dmaven.test.failure.ignore=true
```

```
mvn install -Dmaven.test.skip=true
```

