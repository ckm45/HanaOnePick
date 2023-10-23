package com.kopo.finalproject.model.dto;

import lombok.Data;

@Data
public class SearchHistoryDTO {
    int searchHistoryId;
    String searchPlace;
    String searchDate;
    String searchIndustryCode;
    String memberId;
    String searchStatusCode;

}
