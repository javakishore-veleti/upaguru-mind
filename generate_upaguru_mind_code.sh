#!/bin/bash

BASE_PACKAGE="com.upaguru.mind"
SRC_DIR="src/main/java/$(echo $BASE_PACKAGE | tr '.' '/')"

echo "Generating upaguru-mind source structure..."

# Create base directories
mkdir -p $SRC_DIR/config
mkdir -p $SRC_DIR/controller
mkdir -p $SRC_DIR/dto
mkdir -p $SRC_DIR/entity
mkdir -p $SRC_DIR/repository
mkdir -p $SRC_DIR/service
mkdir -p $SRC_DIR/service/impl

#########################################
# 1. Entity
#########################################
cat <<EOF > $SRC_DIR/entity/EmbeddingRecord.java
package $BASE_PACKAGE.entity;

import jakarta.persistence.*;
import lombok.*;
import java.util.Date;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class EmbeddingRecord {

    @Id
    private String id;

    private String source;

    private String text;

    @Column(columnDefinition = "vector(1536)") // Adjust dimension as per model
    private float[] embedding;

    private String embeddingType;

    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @PrePersist
    public void onCreate() {
        createdAt = new Date();
    }
}
EOF

#########################################
# 2. DTO
#########################################
cat <<EOF > $SRC_DIR/dto/EmbeddingRequest.java
package $BASE_PACKAGE.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class EmbeddingRequest {
    private String source;
    private String text;
    private String embeddingType;
}
EOF

cat <<EOF > $SRC_DIR/dto/EmbeddingResponse.java
package $BASE_PACKAGE.dto;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class EmbeddingResponse {
    private String id;
    private float[] embedding;
}
EOF

#########################################
# 3. Repository
#########################################
cat <<EOF > $SRC_DIR/repository/EmbeddingRecordRepository.java
package $BASE_PACKAGE.repository;

import $BASE_PACKAGE.entity.EmbeddingRecord;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EmbeddingRecordRepository extends JpaRepository<EmbeddingRecord, String> {
}
EOF

#########################################
# 4. Service + Impl
#########################################
cat <<EOF > $SRC_DIR/service/EmbeddingService.java
package $BASE_PACKAGE.service;

import $BASE_PACKAGE.dto.EmbeddingRequest;
import $BASE_PACKAGE.dto.EmbeddingResponse;

public interface EmbeddingService {
    EmbeddingResponse generateEmbedding(EmbeddingRequest request);
}
EOF

cat <<EOF > $SRC_DIR/service/impl/EmbeddingServiceImpl.java
package $BASE_PACKAGE.service.impl;

import $BASE_PACKAGE.config.OpenAiConfig;
import $BASE_PACKAGE.dto.EmbeddingRequest;
import $BASE_PACKAGE.dto.EmbeddingResponse;
import $BASE_PACKAGE.entity.EmbeddingRecord;
import $BASE_PACKAGE.repository.EmbeddingRecordRepository;
import $BASE_PACKAGE.service.EmbeddingService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class EmbeddingServiceImpl implements EmbeddingService {

    private final EmbeddingRecordRepository repository;
    private final OpenAiConfig config;

    @Override
    public EmbeddingResponse generateEmbedding(EmbeddingRequest request) {
        // Placeholder: Call to actual embedding engine (OpenAI, local model, etc.)
        float[] dummyVector = new float[1536]; // Replace with real embedding

        EmbeddingRecord record = new EmbeddingRecord();
        record.setId(UUID.randomUUID().toString());
        record.setSource(request.getSource());
        record.setText(request.getText());
        record.setEmbedding(dummyVector);
        record.setEmbeddingType(request.getEmbeddingType());

        repository.save(record);

        return new EmbeddingResponse(record.getId(), dummyVector);
    }
}
EOF

#########################################
# 5. Controller
#########################################
cat <<EOF > $SRC_DIR/controller/EmbeddingController.java
package $BASE_PACKAGE.controller;

import $BASE_PACKAGE.dto.EmbeddingRequest;
import $BASE_PACKAGE.dto.EmbeddingResponse;
import $BASE_PACKAGE.service.EmbeddingService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/embeddings")
@RequiredArgsConstructor
public class EmbeddingController {

    private final EmbeddingService embeddingService;

    @PostMapping
    public EmbeddingResponse createEmbedding(@RequestBody EmbeddingRequest request) {
        return embeddingService.generateEmbedding(request);
    }
}
EOF

#########################################
# 6. Config
#########################################
cat <<EOF > $SRC_DIR/config/OpenAiConfig.java
package $BASE_PACKAGE.config;

import lombok.Getter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Configuration
@Getter
public class OpenAiConfig {

    @Value("\${openai.api.key}")
    private String apiKey;

    @Value("\${openai.model:gpt-4}")
    private String model;

    private String apiUrl = "https://api.openai.com/v1/embeddings";
}
EOF

#########################################
# 7. Main Class
#########################################
cat <<EOF > $SRC_DIR/UpaguruMindApplication.java
package $BASE_PACKAGE;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class UpaguruMindApplication {
    public static void main(String[] args) {
        SpringApplication.run(UpaguruMindApplication.class, args);
    }
}
EOF

echo "✅ Code generated for upaguru-mind module."
