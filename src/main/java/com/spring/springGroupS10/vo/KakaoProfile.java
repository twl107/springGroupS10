package com.spring.springGroupS10.vo;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
@Data
public class KakaoProfile {

    private long id;
    
    @JsonProperty("kakao_account")
    private KakaoAccount kakaoAccount;

    @Data
    public static class KakaoAccount {
        private String email;
        private Profile profile;
    }

    @Data
    public static class Profile {
        private String nickname;
    }
}
