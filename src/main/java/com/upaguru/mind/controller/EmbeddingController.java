package com.upaguru.mind.controller;

import com.upaguru.mind.dto.EmbeddingRequest;
import com.upaguru.mind.dto.EmbeddingResponse;
import com.upaguru.mind.service.EmbeddingService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/embeddings")
@RequiredArgsConstructor
public class EmbeddingController {

    private final EmbeddingService embeddingService;

    @Operation(
            summary = "Generate embedding from raw text",
            description = "Generates embedding vector using a selected model (e.g., OpenAI) and stores the result in the DB"
    )
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Embedding generated successfully"),
            @ApiResponse(responseCode = "400", description = "Invalid input provided")
    })
    @PostMapping
    public EmbeddingResponse createEmbedding(@RequestBody EmbeddingRequest request) {
        return embeddingService.generateEmbedding(request);
    }
}
