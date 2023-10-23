package com.kopo.finalproject.firebase;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;


@Getter
@ToString
@NoArgsConstructor
public class NotificationRequest {
    private String title;
    private String message;
    private String token;
    private String icon;

    @Builder
    public NotificationRequest(String title, String message, String token, String icon) {
        this.title = title;
        this.message = message;
        this.token = token;
        this.icon = icon;
    }

}