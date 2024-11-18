package com.bravos.yeutube.model;

import com.bravos.yeutube.utils.TimeUtils;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;
import java.util.Set;
import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Video {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    @Column(nullable = false, length = 11)
    private String youtubeId;

    @Column(nullable = false, columnDefinition = "nvarchar(255)")
    private String title;

    private String poster;

    @ColumnDefault("0")
    private Long views = 0L;

    @Column(columnDefinition = "nvarchar(max)")
    private String description;

    private Boolean active;

    @CreationTimestamp
    private LocalDateTime createdTime = LocalDateTime.now();

    @OneToMany(mappedBy = "video", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<Favourite> favourites;

    @OneToMany(mappedBy = "video", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<Share> shares;

    public Video(UUID videoId) {
        this.id = videoId;
    }

    public String getTimeAgo() {
        if(getCreatedTime() != null) {
            return TimeUtils.getTimeAgo(this.getCreatedTime());
        }
        return "";
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("Video{");
        sb.append("title='").append(title).append('\'');
        sb.append('}');
        return sb.toString();
    }
}
