<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="bootstrap" tagdir="/WEB-INF/tags/bootstrap" %>
<%@taglib prefix="layout" tagdir="/WEB-INF/tags/layout" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="file" tagdir="/WEB-INF/tags/file" %>

<layout:page-container title="Employees" activePage="editEmployee">

    <div class="row">
        <div class="col-md-8 col-md-offset-2">
                <%--@elvariable id="employee" type="at.fhj.ima.employee.employeemanager.entity.Employee"--%>
            <form:form modelAttribute="employee" method="post" action="changeEmployee">

                <form:hidden path="id" />

                <fieldset>
                    <legend>Change Employee ${employee.ssn}</legend>

                    <! ---------------- ssn ---------------- -->
                    <div class="mb-3">
                        <label for="inputSSN" class="form-label">SSN</label>
                        <c:set var="ssnInvalid"><form:errors path="ssn" cssClass="invalid-feedback" /></c:set>
                        <form:input path="ssn" class="form-control ${not empty ssnInvalid ? 'is-invalid' : ''}" id="inputSSN" type="number"/>
                            ${ssnInvalid}
                    </div>

                    <! ---------------- first Name ---------------- -->
                    <div class="mb-3">
                        <label for="inputFirstName" class="form-label">First Name</label>
                        <c:set var="firstNameInvalid"><form:errors path="firstName" cssClass="invalid-feedback" /></c:set>
                        <form:input path="firstName" class="form-control ${not empty firstNameInvalid ? 'is-invalid' : ''}" id="inputFirstName" type="text"/>
                            ${firstNameInvalid}
                    </div>

                    <! ---------------- last Name ---------------- -->
                    <div class="mb-3">
                        <label for="inputLastName" class="form-label">Last
                            Name</label>
                        <c:set var="lastNameInvalid"><form:errors path="lastName" cssClass="invalid-feedback" /></c:set>
                        <form:input path="lastName" class="form-control ${not empty lastNameInvalid ? 'is-invalid' : ''}" id="inputLastName" type="text"/>
                            ${lastNameInvalid}
                    </div>

                    <! ---------------- dayOfBirth ---------------- -->
                    <div class="mb-3">
                        <label for="inputDate" class="form-label">Date</label>
                        <c:set var="dayOfBirthInvalid"><form:errors path="dayOfBirth" cssClass="invalid-feedback" /></c:set>
                        <form:input path="dayOfBirth" class="form-control ${not empty dayOfBirthInvalid ? 'is-invalid' : ''}" id="inputDate" placeholder="Date" type="date"/>
                            ${dayOfBirthInvalid}
                    </div>

                    <! ---------------- department ------------------>
                    <div class="mb-3">
                        <label for="department" class="form-label">Department</label>
                        <c:set var="departmentInvalid"><form:errors path="department" cssClass="invalid-feedback" /></c:set>
                        <form:select id="department" path="department" cssClass="form-control ${not empty departmentInvalid ? 'is-invalid' : ''}">
                            <form:option value="">&nbsp;</form:option>
                            <form:options items="${departments}" itemValue="id" itemLabel="name" />
                        </form:select>
                        ${departmentInvalid}
                    </div>

                    <! ---------------- projects ------------------>
                    <div class="mb-3">
                        <label for="projects" class="form-label">Projects</label>
                        <form:select id="projects" path="projects" cssClass="form-control">
                            <form:options items="${projects}" itemValue="id" itemLabel="name" />
                        </form:select>
                    </div>

                    <! ---------------- users ------------------>
                    <div class="mb-3">
                        <label for="users" class="form-label">Users</label>
                        <form:select id="users" path="users" cssClass="form-control">
                            <form:options items="${users}" itemValue="id" itemLabel="username" />
                        </form:select>
                    </div>

                    <! ---------------- files ------------------>
                    <div class="mb-3">
                        <label for="users" class="form-label">Files</label>
                        <file:file value="${employee.files}" />
                    </div>

                    <! ---------------- buttons ---------------- -->
                    <div class="mb-3">
                        <button type="submit" class="btn btn-primary">Submit</button>
                        <a href="listEmployees" class="btn btn-default">Cancel</a>
                    </div>

                </fieldset>
            </form:form>
        </div>
    </div>

</layout:page-container>
