<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
<div class="container-fluid">


    <div class="row">
        <!--        <h1>Header</h1>-->
        <!--        네비게이션바 추가 시작-->
        <div class="row">
            <div class="col">
                <nav class="navbar navbar-expand-lg bg-body-tertiary">
                    <div class="container-fluid">
                        <a class="navbar-brand" href="/todo/list">목록가기</a>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                                aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarNav">
                            <ul class="navbar-nav">
                                <li class="nav-item">
                                    <a class="nav-link active" aria-current="page" href="#">Home</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#">Features</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#">Pricing</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link disabled" aria-disabled="true">Disabled</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>

            </div>
        </div>
        <!--        네비게이션바 추가 끝-->

        <%--    검색 및 필터 화면 추가--%>
        <div class="row content">
            <div class="col">
                <!--        카드 시작 부분-->
                <div class="card">
                    <%--                    <div class="card-header">--%>
                    <%--                        검색 및 필터--%>
                    <%--                    </div>--%>
                    <div class="card-body">
                        <h5 class="card-title">검색 및 필터 </h5>
                        <%--                        검색 입력창, 검색 조건, 필터 조건                        --%>
                        <form action="/todo/list" method="get">
                            <input type="hidden" name="size" value="${pageRequestDTO.size}">
                            <div class="mb-3">
                                <input type="checkbox" name="finished2" ${pageRequestDTO.finished2 ?"checked":""}> 완료여부
                            </div>
                            <div class="mb-3">
                                <input type="checkbox" name="types" value="t" ${pageRequestDTO.checkType("t")?"checked":""}>제목
                                <input type="checkbox" name="types" value="w" ${pageRequestDTO.checkType("w")?"checked":""}>작성자
                                <input type="text" name="keyword" class="form-control" value="${pageRequestDTO.keyword}">
                            </div>
                            <div class="input-group mb-3 dueDateDiv">
                                <input type="date" name="from" class="form-control" value="${pageRequestDTO.from}">
                                <input type="date" name="to" class="form-control" value="${pageRequestDTO.to}">
                            </div>
                            <div class="input-group mb-3">
                                <div class="float-end">
                                    <button class="btn btn-primary" type="submit">검색</button>
                                    <button class="btn btn-secondary clearBtn" type="reset">초기화</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <!--        카드 끝 부분-->

            </div>

        </div>
        <%--    검색 및 필터 화면 추가--%>

        <!--        class="row content"-->
        <div class="row content">
            <!--        col-->
            <div class="col">
                <!--        카드 시작 부분-->
                <div class="card">
                    <%--                    <div class="card-header">--%>
                    <%--                        Featured--%>
                    <%--                    </div>--%>
                    <div class="card-body">
                        <%--                        Todo List 부분 작성--%>
                        <h5 class="card-title">리스트 목록</h5>
                        <button type="button" class="btn btn-primary insertTodoBtn">글쓰기</button>
                        <table class="table">
                            <thead>
                            <%--                                소제목--%>
                            <tr>
                                <th scope="col">Tno</th>
                                <th scope="col">Title</th>
                                <th scope="col">Writer</th>
                                <th scope="col">DueDate</th>
                                <th scope="col">Finished</th>
                            </tr>
                            </thead>
                            <%--                                본문--%>
                            <tbody>

                            <c:forEach items="${pageResponseDTO.dtoList}" var="dto">
                                <tr>
                                    <th scope="row"><c:out value="${dto.tno}"></c:out></th>
                                        <%--                                    컨트롤러, 메서드의 파라미터 부분에, 일반 클래스 객체 타입이면, --%>
                                        <%--                                    모델로 전달을 안해도, 자동으로 모델이 , 뷰에서 사용할수 있게 해줍니다.--%>
                                        <%--                                    PageRequestDTO . -> pageRequestDTO, EL 표기법으로 사용하고, --%>
                                        <%--                                    목적, 페이징의 정보를 달고, 상세보기 화면으로 전달. --%>
                                        <%--                                    pageRequestDTO.link 이렇게 호출해도, pageRequestDTO.getLink 호출함--%>
                                    <td><a href="/todo/read?tno=${dto.tno}&${pageRequestDTO.link}"
                                           class="text-decoration-none">
                                        <c:out value="${dto.title}"></c:out>
                                    </a></td>
                                    <td><c:out value="${dto.writer}"></c:out></td>
                                    <td><c:out value="${dto.dueDate}"></c:out></td>
                                    <td><c:out value="${dto.finished}"></c:out></td>
                                </tr>
                            </c:forEach>

                            </tbody>
                        </table>
                        <%--                       Todo List 부분 작성--%>
                        <div class="float-end">
                            <ul class="pagination">
                                <%--                                    이전 버튼--%>
                                <%--                                페이징 이벤트 처리시, 직접 링크 부분에 추가 할수 있지만,--%>
                                <%--                                    그러면, 동적으로 각 페이지 번호에 맞게 넣는 작업이 어려움, --%>
                                <%--                                    data-num 변수처럼, 각각의 페이지 번호를 동적으로 표시하고, --%>
                                <%--                                    자바스크립트로 진행하기--%>
                                <c:if test="${pageResponseDTO.prev}">
                                    <li class="page-item">
                                        <a class="page-link" data-num="${pageResponseDTO.page - 1}">Previous</a>
                                    </li>
                                </c:if>
                                <%--    출력할 페이지 갯수, 10개 할 예정.--%>
                                <%--                                    반복문을 이용해서, 출력하기--%>
                                <c:forEach begin="${pageResponseDTO.start}"
                                           end="${pageResponseDTO.end}" var="num">
                                    <%--                                    현재 페이지 번호, 표시하는 페이지 번호가 일치한다면, 액티브 속성 추가 --%>

                                    <li class="page-item ${pageResponseDTO.page == num ? "active" : ""}"
                                    ><a class="page-link" data-num="${num}" href="#">${num}</a></li>
                                </c:forEach>


                                <%--    다음 버튼 부분--%>
                                <c:if test="${pageResponseDTO.next}">
                                    <li class="page-item">
                                        <a class="page-link" data-num="${pageResponseDTO.end + 1}">Next</a>
                                    </li>
                                </c:if>
                            </ul>
                        </div>

                    </div>
                </div>
                <!--        카드 끝 부분-->
            </div>
            <!--        col-->
        </div>
        <!--        class="row content"-->
    </div>
    <%--    <div class="row content">--%>
    <%--        <h1>Content</h1>--%>
    <%--    </div>--%>
    <div class="row footer">
        <!--        <h1>Footer</h1>-->
        <div class="row fixed-bottom" style="z-index: -100">
            <footer class="py-1 my-1">
                <p class="text-center text-muted">Footer</p>
            </footer>
        </div>
    </div>
</div>
<%--입력 폼에 관련 유효성 체크, 서버로부터  erros 키로 값을 받아오면, --%>
<%--자바스크립 콘솔에 임시 출력.--%>
<script>
    const serverValidResult = {};
    // jstl , 반복문으로, 서버로부터 넘어온 여러 에러 종류가 많습니다.
    //     하나씩 꺼내서, 출력하는 용도.,
    <c:forEach items="${errors}" var="error">
    serverValidResult['${error.getField()}'] = '${error.defaultMessage}'
    </c:forEach>
    console.log(serverValidResult)
</script>

<script>
    document.querySelector(".insertTodoBtn").addEventListener("click",
        function (e) {
// 글쓰기 폼으로 가야함.
            self.location = "/todo/register"
                , false
        })

    // 페이지네이션 , 이동할 페이지 번호를 data-num 이름으로 작업.
    // 해당 번호를 가지고, 링크 이동하는 이벤트 추가.
    // <ul class="pagination"> ,기준으로 하위 a 태그에 접근 하기.
    document.querySelector(".pagination").addEventListener("click",
        function (e) {
            e.preventDefault()
            e.stopPropagation()
            // a 태그에 접근 할려면, 해당 요소 선택자 필요.
            const target = e.target
            //  a 태그 인경우에 이벤트 리스너 동작을하고,
            // a 태그 가 아니면, 이벤트 처리 안함.
            if (target.tagName !== "A") {
                return
            }
            const num = target.getAttribute("data-num")

            // 백틱, 숫자 키보드 1번 왼쪽에 보면.
            //  기존 페이지 이동해서,
            // self.location = `/todo/list?page=\${num}`
            // 폼의 정보를 이용해서 이동.
            const formObj = document.querySelector("form")
            // 자바스크립트에서, 백틱 안에서, 문자열 구현하기가 쉽다.
            formObj.innerHTML += `<input type='hidden' name='page' value='\${num}'>`
            formObj.submit()


        }, false)

    // 검색 초기화, 이벤트 리스너
    document.querySelector(".clearBtn").addEventListener("click",
        function (e){
        e.preventDefault();
        e.stopPropagation();

        self.location="/todo/list"
    }, false)


</script>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>