package oith.ws.dto;

import org.apache.commons.lang.builder.ToStringBuilder;

public class _OrmDTO {

    private String query;
    private int page;
    private int pageSize;
    private int totalPages;
    private long totalRecs;
    private String data;

    public _OrmDTO() {
    }

    public String getQuery() {
        return query;
    }

    public void setQuery(String query) {
        this.query = query;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }

    public long getTotalRecs() {
        return totalRecs;
    }

    public void setTotalRecs(long totalRecs) {
        this.totalRecs = totalRecs;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}
