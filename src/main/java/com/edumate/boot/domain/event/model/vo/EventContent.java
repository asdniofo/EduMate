package com.edumate.boot.domain.event.model.vo;

public class EventContent {
    private int eContentNo;
    private int eventId;
    private String eContentTitle;
    private String eContentPath;
    private String eContentYn;
    
    // 기본 생성자
    public EventContent() {}
    
    // 전체 필드 생성자
    public EventContent(int eContentNo, int eventId, String eContentTitle, String eContentPath, String eContentYn) {
        this.eContentNo = eContentNo;
        this.eventId = eventId;
        this.eContentTitle = eContentTitle;
        this.eContentPath = eContentPath;
        this.eContentYn = eContentYn;
    }
    
    // Getter 메서드들
    public int getEContentNo() {
        return eContentNo;
    }
    
    public int getEventId() {
        return eventId;
    }
    
    public String getEContentTitle() {
        return eContentTitle;
    }
    
    public String getEContentPath() {
        return eContentPath;
    }
    
    public String getEContentYn() {
        return eContentYn;
    }
    
    // Setter 메서드들
    public void setEContentNo(int eContentNo) {
        this.eContentNo = eContentNo;
    }
    
    public void setEventId(int eventId) {
        this.eventId = eventId;
    }
    
    public void setEContentTitle(String eContentTitle) {
        this.eContentTitle = eContentTitle;
    }
    
    public void setEContentPath(String eContentPath) {
        this.eContentPath = eContentPath;
    }
    
    public void setEContentYn(String eContentYn) {
        this.eContentYn = eContentYn;
    }
    
    @Override
    public String toString() {
        return "EventContent{" +
                "eContentNo=" + eContentNo +
                ", eventId=" + eventId +
                ", eContentTitle='" + eContentTitle + '\'' +
                ", eContentPath='" + eContentPath + '\'' +
                ", eContentYn='" + eContentYn + '\'' +
                '}';
    }
}