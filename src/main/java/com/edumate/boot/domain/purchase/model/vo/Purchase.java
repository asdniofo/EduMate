package com.edumate.boot.domain.purchase.model.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.NoArgsConstructor;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class Purchase {
    private int purchaseNo;
    private int lectureNo;
    private String memberId;
}
