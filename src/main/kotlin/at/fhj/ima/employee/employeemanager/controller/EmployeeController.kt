package at.fhj.ima.employee.employeemanager.controller

import at.fhj.ima.employee.employeemanager.entity.Department
import at.fhj.ima.employee.employeemanager.entity.Employee
import at.fhj.ima.employee.employeemanager.entity.UserRole
import at.fhj.ima.employee.employeemanager.repository.DepartmentRepository
import at.fhj.ima.employee.employeemanager.repository.EmployeeRepository
import at.fhj.ima.employee.employeemanager.repository.ProjectRepository
import at.fhj.ima.employee.employeemanager.repository.UserRepository
import org.springframework.dao.DataIntegrityViolationException
import org.springframework.security.access.annotation.Secured
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.ui.set
import org.springframework.validation.BindingResult
import org.springframework.web.bind.annotation.ModelAttribute
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.bind.annotation.RequestParam
import java.time.LocalDate
import javax.validation.Valid

@Controller
class EmployeeController(
    val employeeRepository: EmployeeRepository,
    val departmentRepository: DepartmentRepository,
    val projectRepository: ProjectRepository,
    val userRepository: UserRepository) {

    @RequestMapping("/editEmployee", method = [RequestMethod.GET])
    @Secured("ROLE_ADMIN")
    fun editEmployee(model: Model, @RequestParam(required = false) id: Int?): String {
        if (id != null) {
            val employee = employeeRepository.findById(id).get()
            model["employee"] = employee
        } else {
            val newEmployee = Employee()
            newEmployee.dayOfBirth = LocalDate.now()
            model["employee"] = newEmployee
        }
        return populateEditEmployeeView(model)
    }

    private fun populateEditEmployeeView(model: Model): String {
        model["departments"] = departmentRepository.findAll()
        model["projects"] = projectRepository.findAll()
        model["users"] = userRepository.findAll()
        return "editEmployee"
    }


    @RequestMapping("/changeEmployee", method = [RequestMethod.POST])
    @Secured("ROLE_ADMIN")
    fun changeEmployee(@ModelAttribute @Valid employee: Employee, bindingResult: BindingResult, model: Model): String {
        if(bindingResult.hasErrors()){
            return populateEditEmployeeView(model)
        }
        try {
            employeeRepository.save(employee)
        } catch (dive: DataIntegrityViolationException) {
            if (dive.message.orEmpty().contains("constraint [ssn_UK]")) {
                bindingResult.rejectValue("ssn", "ssn.alreadyInUse", "SSN already in use.");
                return populateEditEmployeeView(model)
            } else {
                throw dive;
            }
        }
        return "redirect:/editEmployee?id=" + employee.id
    }

    @RequestMapping("/listEmployees", method = [RequestMethod.GET])
    fun listEmployees(model: Model, @RequestParam(required = false) search: String? = null, @RequestParam(required = false) department: Department? = null): String {
        val auth = SecurityContextHolder.getContext().authentication
        val username = auth.name

        val currentUser = userRepository.findByUsername(username)

        if (currentUser != null) {
            if (currentUser.role == UserRole.ROLE_ADMIN) {
                model["employees"] = employeeRepository.findBySearchText(search, department)
            } else {
                model["employees"] = employeeRepository.findBySearchText(search, department, currentUser)
            }
        }
        model["departments"] = departmentRepository.findAll()
        return "listEmployees"

    }

    @RequestMapping("/deleteEmployee", method = [RequestMethod.POST])
    @Secured("ROLE_ADMIN")
    fun deleteEmployee(model: Model, @RequestParam id: Int): String {
        val employee = employeeRepository.findById(id).get()
        employeeRepository.delete(employee);
        model["message"] = "Employee having SSN ${employee.ssn} deleted"
        return listEmployees(model)
    }

}
