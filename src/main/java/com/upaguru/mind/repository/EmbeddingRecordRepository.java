package com.upaguru.mind.repository;

import com.upaguru.mind.entity.EmbeddingRecord;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EmbeddingRecordRepository extends JpaRepository<EmbeddingRecord, String> {
}
