package com.busanit501.springex.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.Positive;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.util.Arrays;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PageRequestDTO {
    // 웹 -> 서버
    //예시: http://localhost:8080/todo/list?page=1&size=10
    // 화면에서 전달할 페이지 번호, 크기를 받을 상자필요.
    // 현재 페이지 번호
    @Builder.Default
    @Min(value = 1)
    @Positive
    private int page = 1;

    // 페이징당 출력할 데이터 갯수
    @Builder.Default
    @Min(value = 10)
    @Max(value = 100)
    @Positive
    private int size = 10;

    //목록 -> 상세보기 화면 이동시, 페이지 정보를 쿼리 스트링으로 전달하는 용도 멤버
    private String link;

    // 검색 또는 필터 관련 조건
    // 1, 검색어
    private String keyword;
    //2, 검색 유형 ,1) 제목,t 2) 작성자,w 3) 제목 + 작성자,tw
    private String[] types;
    //3, todo 완료 여부
    private boolean finished2;
    //4, 기한 1
    private LocalDate from;
    //4, 기한 2
    private LocalDate to;

    // 데이터를 얼마나 스킵 할지 정할 기능.
    public int getSkip() {
        return (page - 1) * size;
    }

    // 페이징 정보를 쿼리 스트링 형식으로 반환 하는 메서드
    // 예시 ) http://localhost:8080/todo/list&page=7&size=10
    // page=7&size=10 , 문자열 생성해주는 기능.

    // 추가기능, 다른 페이지 이동시, 검색어, 타입, 기한 이런 정보도
    // 같이 담아서, 전달하기, -> 검색어를 유지를 하는 기능.
    public String getLink() {
        StringBuilder builder = new StringBuilder();
        builder.append("page=" + this.page);
        builder.append("&size=" + this.size);

        // 검색 및 필터 조건 추가 하기.

        // 이부분,  URLEncoding 부분 누락 . -> 수정
        if(keyword != null) {
            try {
                builder.append("&keyword="+ URLEncoder.encode(keyword, "UTF-8"));
            } catch (UnsupportedEncodingException e) {
//          throw new RuntimeException(e);
                e.printStackTrace();
            }
        }

        //   list&page=7&size=10&finished=on
        if (finished2) {
            // finished ,  체크박스 이어서, 전달 받을 때 문자열 "on"
            builder.append("&finished2=on");
        }

        if (types != null && types.length > 0) {
            for (int i = 0; i < types.length; i++) {
                //   list&page=7&size=10&finished=on&types=t
                builder.append("&types=").append(types[i]);
            }
        }

        if(from != null){
            //   list&page=7&size=10&finished=on&types=t&from=2024-12-05
            builder.append("&from="+ from.toString());
        }
        if(to != null){
            //   list&page=7&size=10&finished=on&types=t&from=2024-1205&to=2024-12-06
            builder.append("&to="+ to.toString());
        }

        return builder.toString();
    }

    //검색에서, 작성자, 제목으로 체크박스 체크여부를 확인하는 기능.
    public boolean checkType(String type) {
        if (types == null || types.length == 0) {
            return false;
        }
        // Arrays.stream(types) : 배열을 의미, {"t","w"}
        // 배열중에서, 요소 하나씩 꺼내서 계속 비교해요. type과비교
        // type ,예를 들어 t로 왔다.
        return Arrays.stream(types).anyMatch(type::equals);
    }
}




