package com.upaguru.mind.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class EmbeddingRequest {
    @Schema(description = "Source type (e.g., 'lesson-plan', 'document')", example = "lesson-plan")
    private String source;

    @Schema(description = "Unique ID of the source content", example = "lesson-001")
    private String sourceId;

    @Schema(description = "Text to embed", example = "What is the process of photosynthesis?")
    private String text;

    @Schema(description = "Embedding model identifier", example = "openai")
    private String embeddingType;

    private String userId;
}
