package com.edumate.boot.app.admin.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Timestamp;

@Getter
@Setter
@ToString
public class WithDrawRequest {
    private int withDrawNo;
    private String memberId;
    private String memberName;
    private String bank;
    private int accountNo;
    private int amount;
    private Timestamp createDate;
    private String status;
    private Timestamp processedDate;
}
