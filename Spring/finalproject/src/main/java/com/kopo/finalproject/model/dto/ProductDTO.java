package com.kopo.finalproject.model.dto;

import lombok.Data;

@Data
public class ProductDTO {
    String productName;
    int price;

    public ProductDTO(String productName, int price) {
        this.productName = productName;
        this.price = price;
    }
}
