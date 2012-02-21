<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="fn" uri="/WEB-INF/tld/fn.tld"%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" media="screen" href="${base}/css/include/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${base}/css/include/highlight/github.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${base}/css/application.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${base}/css/login.css" />
<script type="text/javascript" src="${base}/js/include/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="${base}/js/include/jquery.json-2.3.min.js"></script>
<script type="text/javascript" src="${base}/js/include/highlight.pack.js"></script>
<script type="text/javascript" src="${base}/js/include/form2js.js"></script>
<script type="text/javascript" src="${base}/js/application.js"></script>
<script type="text/javascript">
$(function() {
    //代码高亮
    hljs.tabReplace = '    ';
    hljs.initHighlightingOnLoad();

    $("#add-answer").click(function() {
        $.ajax({
            type : 'POST',
            url  : '${base}/question/${obj.id}/answer/add',
            data :  $.toJSON(form2js("answer-form")),
            dataType : 'json',
            success: function( data ) {
                if (console && console.log){
                      console.log( 'Sample of data:', $.toJSON(data) );
                }
                if (data['ok']) { //添加成功
                    $("#content").val("");
                    $("#format").val("txt");
                    window.location.reload();
                } else {
                    alert('Fail ' + data['msg']);
                }
            }
        });
    });
});
</script>
<title>Question</title>
</head>
<body>
    <jsp:include page="../_include_navbar.jsp" />
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span8 box">
                <div class="question" id="question_${obj.id}">
                    <div class="row">
                        <div class="span10">
                            <h3>${obj.showTitle}</h3>
                            <div class="question-info info sep21">
                                <span class="questioner-name">${obj.user.id}</span>&nbsp;||&nbsp;Question at ${obj.showCreatedAt}${obj.showTags}
                            </div>
                        </div>
                        <div class="span1">
                            <img class="questioner-img" src="${base}/img/img.jpeg" alt="${obj.user.id}">
                        </div>
                    </div>
                    <hr />
                    <div class="question-content">${obj.showContent}</div>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn">Edit</button>
                </div>
            </div>
        </div>
        <c:if test="${! empty obj.answers}">
        <div class="row-fluid">
            <div class="span8 box sep21">
                <c:forEach items="${obj.answers}" var="answer">
                    <div class="row" id="answer_${answer.id}">
                        <div class="span1">
                            <img class="answerer-img" src="${base}/img/img.jpeg" alt="${answer.user.id}">
                        </div>
                        <div class="span10">
                            <div class="answer-info info">
                                <span class="answerer-name">${answer.user.id}</span><span class="answer-time">Answer at ${answer.showCreatedAt}</span>
                            </div>
                            <div class="answer-content">
                                ${answer.showContent}
                            </div>
                        </div>
                    </div>
                    <div class="sep21"><hr /></div>
                </c:forEach>
            </div>
        </div>
        </c:if>
        <div class="row-fluid">
            <div class="span8 box sep21">
                <form class="well" id="answer-form" >
                <legend>Answer your answer</legend>
                    <label>Content</label>
                    <textarea class="input-xxlarge" id="content" name="content" rows="10" placeholder="content"></textarea>
                    <label for="format">Format</label>
                    <select id="format" name="format">
                        <option selected="selected" value="txt">Plain Text</option>
                        <option value="markdown">Markdown</option>
                    </select>
                    <br />
                    <button type="button" class="btn" id="add-answer">Submit</button>
                </form>
            </div>
        </div>
        <jsp:include page="../_include_footer.jsp" />
    </div>
</body>
</html>
