<%@ attribute name="title" required="true" %>
<%@ attribute name="activePage" required="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="bootstrap" tagdir="/WEB-INF/tags/bootstrap" %>
<%@taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
    <bootstrap:bootstrap-metadata/>
    <title>${title}</title>
    <bootstrap:bootstrap-css/>
    <link href="/css/custom.css" rel="stylesheet" />
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.2/dropzone.css" />
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light">
    <div class="container">
        <a class="navbar-brand" href="/">EmployeeManager</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <c:if test="${activePage == 'listEmployees' or activePage == 'editEmployee'}">
                    <c:set var="employeesMenuActive">active</c:set>
                </c:if>
                <li class="nav-item ${employeesMenuActive} dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown"
                       aria-haspopup="true" aria-expanded="false">
                        Employee
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="/listEmployees">List Employee</a>
                        <sec:authorize access="hasAuthority('ROLE_ADMIN')">
                            <a class="dropdown-item" href="/editEmployee">Create Employee</a>
                        </sec:authorize>
                    </div>
                </li>
                <li>
                    <form:form method="post" action="/logout">
                    <button class="btn btn-link" type="submit">Log Out</button>
                    </form:form>
                </li>
                <li>
                    <p>Logged in as ${currentUser.username}</p>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container" role="main">

    <img src="/img/logo.svg" class="mt-2 mb-2">

    <div class="page-header">
        <h1>Employee Management</h1>
    </div>

    <!-- Messages ----------------------------------------------------------- -->

    <!-- Error message ----------------------------------------------------------- -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger" role="alert">${errorMessage}</div>
    </c:if>
    <!-- Error message ----------------------------------------------------------- -->

    <!-- Warning message ----------------------------------------------------------- -->
    <c:if test="${not empty warningMessage}">
        <div class="alert alert-warning" role="warning">${warningMessage}</div>
    </c:if>
    <!-- Warning message ----------------------------------------------------------- -->

    <!-- successful message ----------------------------------------------------------- -->
    <c:if test="${not empty message}">
        <div class="alert alert-success" role="warning">${message}</div>
    </c:if>
    <!-- successful message ----------------------------------------------------------- -->

    <!-- Messages ----------------------------------------------------------- -->
    <jsp:doBody/>
</div>
<bootstrap:bootstrap-js/>
<script src="/js/custom.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/dropzone/5.9.2/dropzone.js"></script>
<script src="/js/custom-dropzone.js"></script>
</body>
</html>
