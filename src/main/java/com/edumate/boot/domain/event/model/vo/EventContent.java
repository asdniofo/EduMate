package com.edumate.boot.domain.event.model.vo;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class EventContent {
    private int eContentNo;
    private int eventId;
    private String eContentTitle;
    private String eContentPath;
    private String eContentYn;
    
    public String getEContentPath() {
        return eContentPath;
    }

    public String getEContentTitle() {
        return eContentTitle;
    }
    
}
