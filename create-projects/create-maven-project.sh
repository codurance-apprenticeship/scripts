#!/bin/sh

PROJECT_NAME=$1
if [ -z "$PROJECT_NAME" ]; then
    echo "Please specify a project name"
    exit 1
fi

echo Creating Maven project in $PWD/$PROJECT_NAME...
mkdir -p $PROJECT_NAME/src/{main,test}/{java/com/$USER,resources}

echo "<project>
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.$USER</groupId>
    <artifactId>$PROJECT_NAME</artifactId>
    <version>1.0-SNAPSHOT</version>

    <properties>
        <maven.compiler.target>11</maven.compiler.target>
        <maven.compiler.source>11</maven.compiler.source>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter-api</artifactId>
            <version>5.5.1</version>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter-params</artifactId>
            <version>5.5.1</version>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>org.mockito</groupId>
            <artifactId>mockito-all</artifactId>
            <version>1.10.19</version>
            <scope>test</scope>
        </dependency>
    </dependencies>
</project>
" > $PROJECT_NAME/pom.xml

echo ".idea
*.iml
*.ipr
*.iws
target" > $PROJECT_NAME/.gitignore

cd $PROJECT_NAME
git init
git add -- pom.xml .gitignore
git commit -m "Added build script and .gitignore"

echo "All done. You can now import the project into your IDE."
