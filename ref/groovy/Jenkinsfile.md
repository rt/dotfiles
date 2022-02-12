
A scripted pipeline is a groovy-based DSL. It provides greater flexibility and
scalability for Jenkins users than the Declarative pipeline

```groovy
#!/usr/bin/env groovy

// Jenkinsfile (Declarative Pipeline)
pipeline {
  agent any
  stages {
    stage('Stage 1') {
      steps {
        echo 'Hello world!'
      }
    }
  }
}
```

The Declarative Pipeline syntax is more stringent. It needs to use Jenkins'
predefined DSL structure, which provides a simpler and more assertive syntax
for writing Jenkins pipelines.

```groovy
// Jenkinsfile (Scripted Pipeline)
node { // node/agent
  stage('Stage 1') {
    echo 'Hello World' // echo Hello World
  }
}
```
