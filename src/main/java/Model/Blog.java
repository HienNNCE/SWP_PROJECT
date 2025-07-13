package Model;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

public class Blog {
    private int id;
    private String title;
    private String summary;
    private String content;
    private String image;
    private LocalDateTime publishedAt;

    public Blog(int id, String title, String summary, String content, String image, LocalDateTime publishedAt) {
        this.id = id;
        this.title = title;
        this.summary = summary;
        this.content = content;
        this.image = image;
        this.publishedAt = publishedAt;
    }

    // Getters
    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getSummary() {
        return summary;
    }

    public String getContent() {
        return content;
    }

    public String getImage() {
        return image;
    }

    public LocalDateTime getPublishedAt() {
        return publishedAt;
    }

    // ✅ Convert LocalDateTime to java.util.Date for JSTL fmt:formatDate
    public Date getPublishedDate() {
        return publishedAt != null
            ? Date.from(publishedAt.atZone(ZoneId.systemDefault()).toInstant())
            : null;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public void setPublishedAt(LocalDateTime publishedAt) {
        this.publishedAt = publishedAt;
    }
}
