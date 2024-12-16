package com.busanit501.project01.service;

import com.busanit501.project01.dto.PageRequestDTO;
import com.busanit501.project01.dto.PageResponseDTO;
import com.busanit501.project01.dto.TodoDTO;

import java.util.List;

public interface TodoService {
    void register(TodoDTO todoDTO);

    List<TodoDTO> getAll();

    //페이징 처리된 목록
    // 준비물을 준비 해둠,
    // 웹 -> 서버 , 박스
    // 웹 <- 서버, 박스
//    PageResponseDTO<TodoDTO> getListWithPage(PageRequestDTO pageRequestDTO);

    PageResponseDTO<TodoDTO> selectList(PageRequestDTO pageRequestDTO);


    TodoDTO getOne(Long tno);

    void delete(Long tno);

    void update(TodoDTO todoDTO);
}
