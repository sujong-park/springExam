package com.busanit501.project01.mapper;

import com.busanit501.project01.domain.TodoVO;
import com.busanit501.project01.dto.PageRequestDTO;

import java.util.List;

public interface TodoMapper {
    
    void insert(TodoVO todoVO);

    List<TodoVO> selectAll();

    TodoVO selectOne(Long tno);

    void delete(Long tno);

    void update(TodoVO todoVO);

    //페이징한 전체 목록
    List<TodoVO> selectList(PageRequestDTO pageRequestDTO);

    // 페이징 위해서, 전체갯수,
    int getCount(PageRequestDTO pageRequestDTO);
}





