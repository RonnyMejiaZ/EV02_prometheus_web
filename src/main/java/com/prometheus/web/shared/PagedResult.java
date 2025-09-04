package com.prometheus.web.shared;

import java.util.List;

public class PagedResult<T> {
  public final List<T> items;
  public final int total;
  public final int page;
  public final int size;

  public PagedResult(List<T> items, int total, int page, int size) {
    this.items = items;
    this.total = total;
    this.page = page;
    this.size = size;
  }

  public int totalPages() {
    return (int) Math.ceil(total / (double) size);
  }
}
