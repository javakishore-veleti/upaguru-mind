package com.upaguru.mind.entity;

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

    private String sourceType;
    private String sourceId;

    @Column(columnDefinition = "text")
    private String text;

    @Column(columnDefinition = "text")  // NOT jsonb
    private String embedding;

    @Column(columnDefinition = "text")  // NOT jsonb
    private String metadata;

    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @PrePersist
    public void prePersist() {
        this.createdAt = new Date();
    }
}
