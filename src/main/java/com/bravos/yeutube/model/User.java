package com.bravos.yeutube.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import java.util.Set;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "Users")
public class User {

    @Id
    private String id;

    @Column(nullable = false)
    private String password;

    private String email;

    @Column(columnDefinition = "nvarchar(60)")
    private String fullName;

    @Column(nullable = false)
    @ColumnDefault("0")
    private Boolean admin = false;

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private Set<Favourite> favourites;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<Share> shares;

    public User(String username) {
        this.id = username;
    }

}
