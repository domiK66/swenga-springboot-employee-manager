package at.fhj.ima.employee.employeemanager.entity

import at.fhj.ima.employee.employeemanager.controller.advice.CurrentUserControllerAdvice
import java.io.Serializable
import java.time.LocalDate
import javax.persistence.*
import javax.validation.constraints.NotNull
import javax.validation.constraints.Past
import javax.validation.constraints.Size

@Entity
@Table(uniqueConstraints = [UniqueConstraint(name = "ssn_UK", columnNames = ["ssn"])])
class Employee(
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        var id: Int? = null,
        @Column(nullable = false)
        @field:NotNull
        var ssn: Int? = null,
        @field:Size(min = 2, max = 240)
        var firstName: String? = null,
        @field:Size(min = 2, max = 240)
        var lastName: String? = null,
        @field:Past
        var dayOfBirth: LocalDate? = null,
        @ManyToOne
        @field:NotNull
        var department: Department? = null,
        @ManyToMany
        var projects: Set<Project>? = null,
        @ManyToMany
        var users: Set<User?>? = null,
        @ManyToMany(fetch = FetchType.EAGER)
        var files: List<File>? = null


) : Comparable<Employee>, Serializable {

    override fun compareTo(other: Employee): Int {
        return compareValues(id, other.id)
    }

    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (javaClass != other?.javaClass) return false
        other as Employee
        if (id != other.id) return false
        return true
    }

    override fun hashCode(): Int {
        return id.hashCode()
    }
}
