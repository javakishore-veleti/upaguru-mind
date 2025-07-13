package com.upaguru.mind.service;

import com.upaguru.mind.dto.EmbeddingRequest;
import com.upaguru.mind.dto.EmbeddingResponse;

public interface EmbeddingService {
    EmbeddingResponse generateEmbedding(EmbeddingRequest request);
}
