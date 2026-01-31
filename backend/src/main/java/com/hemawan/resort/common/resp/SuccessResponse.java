package com.hemawan.resort.common.resp;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
public class SuccessResponse {
    private Data data;

    public static SuccessResponse of(String responseCode, String reason) {
        return new SuccessResponse(new Data(new Status(responseCode, reason)));
    }

    @lombok.Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Data {
        private Status status;
    }

    @lombok.Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Status {
        private String responseCode;
        private String reason;
    }
}

