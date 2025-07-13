package com.upaguru.mind.service.impl;

import com.google.gson.Gson;
import com.upaguru.mind.config.OpenAiConfig;
import com.upaguru.mind.dto.EmbeddingRequest;
import com.upaguru.mind.dto.EmbeddingResponse;
import com.upaguru.mind.entity.EmbeddingRecord;
import com.upaguru.mind.repository.EmbeddingRecordRepository;
import com.upaguru.mind.service.EmbeddingService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.LinkedHashMap;
import java.util.Map;
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

         Gson gson = new Gson();
        float[] embeddingArray = new float[]{0.12f, 0.42f, 0.99f};
        String embeddingJson = gson.toJson(embeddingArray);  // Converts to "[0.12,0.42,0.99]"

        EmbeddingRecord record = new EmbeddingRecord();
        record.setId(UUID.randomUUID().toString());
        record.setSourceId(request.getSource());
        record.setText(request.getText());
        record.setEmbedding(embeddingJson);
        record.setSourceType(request.getEmbeddingType());

        Map<String, Object> metadataMap = new LinkedHashMap<>();
        metadataMap.put("userId", request.getUserId());
        metadataMap.put("sourceType", request.getEmbeddingType());
        metadataMap.put("notes", "Created for semantic search pipeline");

        record.setMetadata(new Gson().toJson(metadataMap));

        repository.save(record);

        return new EmbeddingResponse(record.getId(), dummyVector);
    }
}
