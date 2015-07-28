Spring-Boot based Amazon Simple Storage Service(S3) API Sample
=======

```
Spring Boot + Spring Cloud AWS
Description : http://brantiffy.axisj.com/archives/131
```

###How to Open
```
IntelliJ -> Open -> build.gradle
```

###Compile Setting
```
Open IntelliJ Preference
    - Build, Execution, Deployment -> Compiler
        -> Check 'Make project automatically'
```

###How to Run
```
- application-example.properties rename to application.properties
- set your AWS accessKey & secretKey
- Run main() on Application Class
```

### API 
```
GET /api/aws/s3/list : List of Objects
GET /api/aws/s3/download?key={key} : Download
POST /api/aws/s3/upload : Upload
```

### Environment
- Java 8
- Spring Boot 1.3.0.M2
- Spring Cloud AWS 1.0.2.RELEASE
- Gradle 2.4