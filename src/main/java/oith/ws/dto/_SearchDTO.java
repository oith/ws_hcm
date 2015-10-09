package oith.ws.dto;

import org.apache.commons.lang.builder.ToStringBuilder;

public class _SearchDTO {

    private String searchTerm;
    private int page;
    private int pageSize;
    private int totalPages;
    private long totalRecs;

    public _SearchDTO() {
    }

    public String getSearchTerm() {
        return searchTerm;
    }

    public void setSearchTerm(String searchTerm) {
        this.searchTerm = searchTerm;
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

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}
