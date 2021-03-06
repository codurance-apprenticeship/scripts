#!/bin/sh

PROJECT_NAME=$1
if [ -z "$PROJECT_NAME" ]; then
    echo "Please specify a project name."
    exit 1
fi

echo Creating Gradle project in $PWD/$PROJECT_NAME...
mkdir -p $PROJECT_NAME/src/{main,test}/{java,resources}

echo "plugins {
    id 'java'
    id 'com.adarshr.test-logger' version '1.7.0'
}

sourceCompatibility = 11

repositories {
    mavenCentral()
}

test {
    useJUnitPlatform()
    testLogging {
        exceptionFormat = 'full'
        events = ['passed', 'failed', 'skipped', 'standard_error', 'standard_out']
    }
}

ext {
    junitVersion = '5.5.0'
    mockitoVersion = '3.0.0'
    assertjVersion = '3.11.1'
}

dependencies {
    testImplementation \"org.junit.jupiter:junit-jupiter-api:\${junitVersion}\"

    // pick your desired test flavors
    /*
    testImplementation \"org.junit.jupiter:junit-jupiter-params:\${junitVersion}\"
    testImplementation \"org.assertj:assertj-core:\${assertjVersion}\"
    testImplementation \"org.mockito:mockito-junit-jupiter:\${mockitoVersion}\"
    */
    testRuntimeOnly \"org.junit.jupiter:junit-jupiter-engine:\${junitVersion}\"

}
" > $PROJECT_NAME/build.gradle

echo ".idea
.gradle
*.iml
*.ipr
*.iws
out
build" > $PROJECT_NAME/.gitignore

cd $PROJECT_NAME
git init
git add -- build.gradle .gitignore
git commit -m "Init project with gradle build script."

echo "-------------------------------------------------------"
echo "All done. You can now import the project into your IDE."
echo "-------------------------------------------------------"
echo "Happy Gradling!"
