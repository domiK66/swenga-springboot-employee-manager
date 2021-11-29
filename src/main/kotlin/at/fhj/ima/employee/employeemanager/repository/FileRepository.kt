package at.fhj.ima.employee.employeemanager.repository


import at.fhj.ima.employee.employeemanager.entity.File
import org.springframework.data.jpa.repository.JpaRepository

interface FileRepository : JpaRepository<File, Int> {
}