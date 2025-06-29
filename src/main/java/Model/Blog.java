package Model;

import java.time.LocalDateTime;

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
}
