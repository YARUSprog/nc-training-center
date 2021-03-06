package ua.com.nc.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.time.OffsetDateTime;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

@EqualsAndHashCode(callSuper = true)
@Data
public class User extends Entity implements UserDetails {
    private String email;
    private transient String password;
    private String firstName;
    private String lastName;
    private String token;
    private OffsetDateTime created;
    private Integer managerId;
    private String imageUrl;
    private boolean isActive;
    private boolean isOnLandingPage;
    private String description;
    private Set<Role> roles;

    public User() {
    }

    public User(Integer id, String email, String password, String firstName, String lastName, String token, OffsetDateTime created, Integer managerId, String image, boolean isActive) {
        super(id);
        this.setEmail(email);
        this.setPassword(password);
        this.setFirstName(firstName);
        this.setLastName(lastName);
        this.setToken(token);
        this.setCreated(created);
        this.setManagerId(managerId);
        this.setImageUrl(image);
        this.setActive(isActive);
    }

    public User(String email, String password, String firstName, String lastName, String token, OffsetDateTime created, Integer managerId, String image, boolean isActive) {
        this.setEmail(email);
        this.setPassword(password);
        this.setFirstName(firstName);
        this.setLastName(lastName);
        this.setToken(token);
        this.setCreated(created);
        this.setManagerId(managerId);
        this.setImageUrl(image);
        this.setActive(isActive);
    }

//    public String getEmail() {
//        return email;
//    }
//
//    public void setEmail(String email) {
//        if (email != null) {
//            this.email = email.trim();
//        }
//    }
//
//    public String getFirstName() {
//        return firstName;
//    }
//
//    public void setFirstName(String firstName) {
//        if (firstName != null) {
//            this.firstName = firstName.trim();
//        }
//    }
//
//    public String getLastName() {
//        return lastName;
//    }
//
//    public void setLastName(String lastName) {
//        if (lastName != null) {
//            this.lastName = lastName.trim();
//        }
//    }
//
//    public Integer getManagerId() {
//        return managerId;
//    }
//
//    public void setManagerId(Integer managerId) {
//        if (managerId != null) {
//            this.managerId = managerId;
//        }
//    }
//

//    public String getImageUrl() {
//        return imageUrl;
//    }
//
//    public void setImageUrl(String imageUrl) {
//        if (imageUrl != null) {
//            this.imageUrl = imageUrl;
//        }
//    }
//
//    public String getToken() {
//        return token;
//    }
//
//    public void setToken(String token) {
//        this.token = token;
//    }
//
//    public OffsetDateTime getCreated() {
//        return created;
//    }
//
//    public void setCreated(OffsetDateTime created) {
//        this.created = created;
//    }
//
//    public boolean isActive() {
//        return isActive;
//    }
//
//    public void setActive(boolean active) {
//        isActive = active;
//    }

//    @Override
//    public boolean equals(Object o) {
//        if (this == o) return true;
//        if (!(o instanceof User)) return false;
//        User user = (User) o;
//        return isActive() == user.isActive() &&
//                Objects.equals(getEmail(), user.getEmail()) &&
//                Objects.equals(getPassword(), user.getPassword()) &&
//                Objects.equals(getFirstName(), user.getFirstName()) &&
//                Objects.equals(getLastName(), user.getLastName()) &&
//                Objects.equals(getManagerId(), user.getManagerId());
//    }
//
//    @Override
//    public int hashCode() {
//        return Objects.hash(getEmail(), getPassword(), getFirstName(), getLastName(), getManagerId(), isActive());
//    }

//    @Override
//    public String toString() {
//        return "User{" +
//                "email='" + getEmail() + '\'' +
//                ", password='" + getPassword() + '\'' +
//                ", firstName='" + getFirstName() + '\'' +
//                ", lastName='" + getLastName() + '\'' +
//                ", managerId=" + getManagerId() +
//                ", isActive=" + isActive() +
//                '}';
//    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Set<GrantedAuthority> authorities = new HashSet<>();
        if (this.roles != null && !this.roles.isEmpty()) {
            for (Role role : this.roles) {
                authorities.add(new SimpleGrantedAuthority(role.name()));
            }
        }
        return authorities;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return email;
    }

//    public void setPassword(String password) {
//        this.password = password;
//    }

    @Override
    public boolean isAccountNonExpired() {
        return isActive;
    }

    @Override
    public boolean isAccountNonLocked() {
        return isActive;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return isActive;
    }

    @Override
    public boolean isEnabled() {
        return isActive;
    }

//    public Set<Role> getRoles() {
//        return roles;
//    }
//
//    public void setRoles(Set<Role> roles) {
//        this.roles = roles;
//    }
}
