<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="bootstrap" tagdir="/WEB-INF/tags/bootstrap" %>
<%@taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<layout:page-container title="Employees" activePage="listEmployees">

    <div class="row">
        <div class="col-md-10 col-md-offset-1">

            <form id="searchform">
                <div class="row">
                    <div class="col">
                        <label for="inputSearch" class="form-label">Search</label>
                        <input id="inputSearch" name="search" class="form-control" value="${param.search}"/>
                    </div>
                    <div class="col">
                        <label for="departmentSearch" class="form-label">Search</label>
                        <select id="departmentSearch" name="department" class="form-control">
                            <option value=""></option>
                            <c:forEach var="department" items="${departments}">
                                <option value="${department.id}"<c:if test="${param.department == department.id}"> selected</c:if>>${department.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </form>

            <table data-toggle="table" class="table table-striped">
                <thead>
                <tr>
                    <th data-sortable="true">SSN</th>
                    <th data-sortable="true">First Name</th>
                    <th data-sortable="true">Last Name</th>
                    <th data-sortable="true">Day of birth</th>
                    <th data-sortable="true">Department</th>
                    <sec:authorize access="hasAuthority('ROLE_ADMIN')"><th>Actions</th></sec:authorize>
                </tr>
                </thead>
                <tbody>
                <!--  list all employees ----------------------------------------------------------- -->
                <c:forEach items="${employees}" var="employee">
                    <tr>
                        <td>${employee.ssn}</td>
                        <td>${employee.firstName}</td>
                        <td>${employee.lastName}</td>
                        <td>
                            <fmt:parseDate value="${employee.dayOfBirth}" pattern="yyyy-MM-dd" var="parsedDate"
                                           type="date"/>
                            <fmt:formatDate value="${parsedDate}" type="date" pattern="dd.MM.yyyy"/>
                        </td>
                        <td>${employee.department.name}</td>

                        <sec:authorize access="hasAuthority('ROLE_ADMIN')">
                            <td>
                                <a href="editEmployee?id=${employee.id}" class="btn btn-xs btn-success">Edit</a>
                                <form:form method="post" action="/deleteEmployee?id=${employee.id}">
                                    <button type="submit" class="btn btn-xs btn-danger">Delete</button>
                                </form:form>
                            </td>
                        </sec:authorize>

                    </tr>
                </c:forEach>
                <!--  list all employees ----------------------------------------------------------- -->
                </tbody>
            </table>
        </div>
    </div>

</layout:page-container>
