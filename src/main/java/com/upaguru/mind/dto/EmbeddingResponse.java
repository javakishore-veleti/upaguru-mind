package com.upaguru.mind.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Schema(description = "Embedding generation response")
@NoArgsConstructor
@AllArgsConstructor
public class EmbeddingResponse {

    @Schema(description = "ID of the saved record")
    private String id;

    @Schema(description = "Raw embedding vector preview", example = "[0.12, 0.42, 0.99]")
    private float[] embeddingPreview;
}