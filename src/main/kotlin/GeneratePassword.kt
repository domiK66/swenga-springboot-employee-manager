import org.springframework.security.crypto.argon2.Argon2PasswordEncoder
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder

fun main() {
    print(BCryptPasswordEncoder().encode("admin"));
}